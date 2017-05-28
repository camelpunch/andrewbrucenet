module Site

data Page = Home
          | CV
          | Contact

data Class = MenuItem | Menu
data ElementContext = Anywhere | InList
data Element : ElementContext -> Type where
  P : String -> Element Anywhere
  Img : String -> Element Anywhere
  H1 : String -> Element Anywhere
  H2 : String -> Element Anywhere
  Ul : Class -> (List (Element InList)) -> Element Anywhere
  Li : Class -> (List (Element Anywhere)) -> Element InList

Content : Type
Content = List (Element Anywhere)

Path : Type
Path = String

total path : Page -> Path
path Home = "/"
path CV = "/cv"
path Contact = "/contact"

total menuItem : Page -> Element InList
menuItem Home = Li MenuItem []
menuItem CV = ?menuItem_rhs_2
menuItem Contact = ?menuItem_rhs_3

header : String -> List (Element Anywhere)
header title = [ Ul Menu (map menuItem [Home, CV, Contact]) ]

total content : Page -> Content
content Home =
  header "A software person in London" ++
  [ P    "Here is my face"
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  ]
content CV = ?content_rhs_2
content Contact = ?content_rhs_3

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

  lisToHtml : List (Element InList) -> String
  lisToHtml lis = concat $ map liToHtml lis

  liToHtml : Element InList -> String
  liToHtml (Li htmlClass elements) = "<li class=\"" ++ classToString htmlClass ++ "\">" ++
                                     concat (map toHtml elements) ++
                                     "</li>"

  classToString : Class -> String
  classToString MenuItem = "menu-item"
  classToString Menu = "menu"

html : Content -> String
html [] = ""
html (element :: rest) = toHtml element ++ html rest
