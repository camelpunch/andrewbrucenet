module Site

import System

public export
data ElementContext = Root | General | InList

public export
data Element : ElementContext -> Type where
  Html : List (Element General) -> Element Root
  P : List (Element General) -> Element General
  Text : String -> Element General
  Img : String -> Element General
  H1 : String -> Element General
  H2 : String -> Element General
  Ul : Maybe String -> (List (Element InList)) -> Element General
  Li : Maybe String -> (List (Element General)) -> Element InList
  A : String -> String -> Element General

export
li : String -> Element InList
li str = Li Nothing [ P [ Text str ] ]

public export
Content : Type
Content = List (Element General)

public export
record Page where
  constructor MkPage
  path : String
  filepath : String
  menuTitle : String
  title : String
  content : Content

mutual
  total toHtml : Element General -> String
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

  elementsToHtml : List (Element General) -> String
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

export
generate : (Page -> List Page -> Element Root) ->
           List Page ->
           List String ->
           IO ()
generate assemblePage pages args =
  case args of
    []            => die $ "must provide a page: " ++ (concat $ intersperse ", " (map filepath pages))
    [_, pageName] => generatePage pageName pages
    _multiple     => die "only one page argument allowed"
  where
    die : String -> IO ()
    die msg = do
      fPutStrLn stderr msg
      exitFailure

    pagesWithName : String -> List Page -> List Page
    pagesWithName name pages = filter (\p => filepath p == name) pages

    generatePage : String -> List Page -> IO ()
    generatePage pageName pages =
      case pagesWithName pageName pages of
        []     => die "couldn't find a matching page"
        [page] => putStr $ html (assemblePage page pages)
        _pages => die "multiple pages match"
