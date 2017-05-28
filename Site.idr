module Site

public export
data ElementContext = Anywhere | InList

public export
data Element : ElementContext -> Type where
  P : String -> Element Anywhere
  Img : String -> Element Anywhere
  H1 : String -> Element Anywhere
  H2 : String -> Element Anywhere
  Ul : String -> (List (Element InList)) -> Element Anywhere
  Li : String -> (List (Element Anywhere)) -> Element InList
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

mutual
  total toHtml : Element Anywhere -> String
  toHtml (P str) = "<p>" ++ str ++ "</p>"
  toHtml (Img str) = "<img src=\"" ++ str ++ "\"/>"
  toHtml (H1 str) = "<h1>" ++ str ++ "</h1>"
  toHtml (H2 str) = "<h2>" ++ str ++ "</h2>"
  toHtml (Ul _ []) = ""
  toHtml (Ul htmlClass lis) = "<ul class=\"" ++ htmlClass ++ "\">" ++
                              lisToHtml lis ++
                              "</ul>"
  toHtml (A href text) = "<a href=\"" ++ href ++ "\">" ++ text ++ "</a>"

  lisToHtml : List (Element InList) -> String
  lisToHtml lis = concat $ map liToHtml lis

  liToHtml : Element InList -> String
  liToHtml (Li htmlClass elements) = "<li class=\"" ++ htmlClass ++ "\">" ++
                                     concat (map toHtml elements) ++
                                     "</li>"

export
html : Content -> String
html [] = ""
html (element :: rest) = toHtml element ++ html rest
