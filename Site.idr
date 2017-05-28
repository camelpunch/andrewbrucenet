module Site

public export
data Class = MenuItem | Menu | Things | Thing

public export
data ElementContext = Anywhere | InList

public export
data Element : ElementContext -> Type where
  P : String -> Element Anywhere
  Img : String -> Element Anywhere
  H1 : String -> Element Anywhere
  H2 : String -> Element Anywhere
  Ul : Class -> (List (Element InList)) -> Element Anywhere
  Li : Class -> (List (Element Anywhere)) -> Element InList
  A : String -> String -> Element Anywhere

public export
Content : Type
Content = List (Element Anywhere)

export
record Page where
  constructor MkPage
  path : String
  menuTitle : String
  title : String
  content : Content

total menuItem : Page -> Element InList
menuItem (MkPage path menuTitle _ _) = Li MenuItem [A path menuTitle]

mutual
  total toHtml : Element Anywhere -> String
  toHtml (P str) = "<p>" ++ str ++ "</p>"
  toHtml (Img str) = "<img src=\"" ++ str ++ "\"/>"
  toHtml (H1 str) = "<h1>" ++ str ++ "</h1>"
  toHtml (H2 str) = "<h2>" ++ str ++ "</h2>"
  toHtml (Ul _classAttr []) = ""
  toHtml (Ul classAttr lis) = "<ul class=\"" ++ classToString classAttr ++ "\">" ++
                              lisToHtml lis ++
                              "</ul>"
  toHtml (A href text) = "<a href=\"" ++ href ++ "\">" ++ text ++ "</a>"

  lisToHtml : List (Element InList) -> String
  lisToHtml lis = concat $ map liToHtml lis

  liToHtml : Element InList -> String
  liToHtml (Li htmlClass elements) = "<li class=\"" ++ classToString htmlClass ++ "\">" ++
                                     concat (map toHtml elements) ++
                                     "</li>"

  classToString : Class -> String
  classToString MenuItem = "menu-item"
  classToString Menu = "menu"
  classToString Things = "things"
  classToString Thing = "thing"

export
html : Content -> String
html [] = ""
html (element :: rest) = toHtml element ++ html rest

export
assemblePage : Page -> List Page -> Content
assemblePage currentPage allPages =
  [ H1 (title currentPage)
  , Ul Menu (map menuItem allPages)
  ] ++
  content currentPage
