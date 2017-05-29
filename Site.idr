module Site

public export
data ElementContext = Root | Anywhere | InList

public export
data Element : ElementContext -> Type where
  Html : List (Element Anywhere) -> Element Root
  P : List (Element Anywhere) -> Element Anywhere
  Text : String -> Element Anywhere
  Img : String -> Element Anywhere
  H1 : String -> Element Anywhere
  H2 : String -> Element Anywhere
  Ul : Maybe String -> (List (Element InList)) -> Element Anywhere
  Li : Maybe String -> (List (Element Anywhere)) -> Element InList
  A : String -> String -> Element Anywhere

export
li : String -> Element InList
li str = Li Nothing [ P [ Text str ] ]

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
  toHtml (P els) = "<p>" ++ elementsToHtml els ++ "</p>"
  toHtml (Text str) = str
  toHtml (Img str) = "<img src=\"" ++ str ++ "\"/>"
  toHtml (H1 str) = "<h1>" ++ str ++ "</h1>"
  toHtml (H2 str) = "<h2>" ++ str ++ "</h2>"
  toHtml (Ul _ []) = ""
  toHtml (Ul Nothing lis) =
    "<ul>" ++ lisToHtml lis ++ "</ul>"
  toHtml (Ul (Just ulClass) lis) =
    "<ul class=\"" ++ ulClass ++ "\">" ++ lisToHtml lis ++ "</ul>"
  toHtml (A href text) = "<a href=\"" ++ href ++ "\">" ++ text ++ "</a>"

  lisToHtml : List (Element InList) -> String
  lisToHtml lis = concat $ map liToHtml lis

  liToHtml : Element InList -> String
  liToHtml (Li Nothing elements) =
    "<li>" ++ elementsToHtml elements ++ "</li>"
  liToHtml (Li (Just htmlClass) elements) =
    "<li class=\"" ++ htmlClass ++ "\">" ++ elementsToHtml elements ++ "</li>"

  elementsToHtml : List (Element Anywhere) -> String
  elementsToHtml elements = concat $ map toHtml elements

export
render : Content -> String
render [] = ""
render (element :: rest) = toHtml element ++ render rest

export
html : Element Root -> String
html (Html content) =
  """<!DOCTYPE html>
<html>
""" ++ render content ++ """
</html>"""
