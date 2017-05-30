module Site

import System

public export
data ElementContext = Root | RootChild | HeadChild | InList | General

public export
data LinkRel = Stylesheet
%name LinkRel rel

public export
data LinkType = TextCss
%name LinkType t

public export
data Element : ElementContext -> Type where
  Html : List (Element RootChild) -> Element Root
  Head : List (Element HeadChild) -> Element RootChild
  Title : String -> Element HeadChild
  Link : LinkRel -> LinkType -> (href : String) -> Element HeadChild
  Body : List (Element General) -> Element RootChild
  P : List (Element General) -> Element General
  Text : String -> Element General
  Img : String -> Element General
  H1 : String -> Element General
  H2 : String -> Element General
  Ul : Maybe String -> (List (Element InList)) -> Element General
  Li : Maybe String -> (List (Element General)) -> Element InList
  A : String -> String -> Element General

mutual
  showEls : Show a => List a -> String
  showEls = concat . map show

  Show (Element RootChild) where
    show (Head content) = "<body>" ++ showEls content ++ "</body>"
    show (Body content) = "<head>" ++ showEls content ++ "</head>"

  Show (Element HeadChild) where
    show (Link rel t href) =
      "<link rel=\"" ++ show rel ++ "\" type=\"" ++ show t ++ "\" href=\"" ++ href ++ "\"/>"
    show (Title str) =
      "<title>" ++ str ++ "</title>"

  Show LinkRel where
    show Stylesheet = "Stylesheet"

  Show LinkType where
    show TextCss = "text/css"

  Show (Element InList) where
    show (Li Nothing els) =
      "<li>" ++ showEls els ++ "</li>"
    show (Li (Just c) els) =
      "<li class=\"" ++ c ++ "\">" ++ showEls els ++ "</li>"

  Show (Element General) where
    show (P els) = "<p>" ++ show els ++ "</p>"
    show (Text str) = str
    show (Img src) = "<img src=\"" ++ src ++ "\"/>"
    show (H1 str) = "<h1>" ++ str ++ "</h1>"
    show (H2 str) = "<h2>" ++ str ++ "</h2>"
    show (Ul _ []) = ""
    show (Ul Nothing lis) =
      "<ul>" ++ showEls lis ++ "</ul>"
    show (Ul (Just ulClass) lis) =
      "<ul class=\"" ++ ulClass ++ "\">" ++ showEls lis ++ "</ul>"
    show (A href str) =
      "<a href=\"" ++ href ++ "\">" ++ str ++ "</a>"

export
li : String -> Element InList
li str = Li Nothing [ P [ Text str ] ]

public export
record Page where
  constructor MkPage
  path : String
  filepath : String
  menuTitle : String
  title : String
  content : List (Element General)

html : Element Root -> String
html (Html content) =
  """<!DOCTYPE html>
<html>
""" ++ showEls content ++ """
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
