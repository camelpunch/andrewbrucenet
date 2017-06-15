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
  Div : List String -> List (Element General) -> Element General
  Pre : List String -> String -> Element General
  Text : String -> Element General
  Img : String -> Element General
  H1 : String -> Element General
  H2 : String -> Element General
  Ul : List String -> (List (Element InList)) -> Element General
  Li : List String -> (List (Element General)) -> Element InList
  A : List String -> String -> String -> Element General

attributes : (attrs : List (String, String)) -> String
attributes attrs =
  concat $ intersperse " " (map (\(k, v) => k ++ "=\"" ++ v ++ "\"") attrs)

tag : (name : String) ->
      (attrs : List (String, String)) ->
      (content : Maybe String) ->
      String
tag name [] Nothing =
  "<" ++ name ++ "/>"
tag name [] (Just content) =
  "<" ++ name ++ ">" ++ content ++ "</" ++ name ++ ">"
tag name attrs Nothing =
  "<" ++ name ++ " " ++ attributes attrs ++ "/>"
tag name attrs (Just content) =
  "<" ++ name ++ " " ++ attributes attrs ++ ">" ++ content ++ "</" ++ name ++ ">"

classAttrs : List String -> List (String, String)
classAttrs [] = []
classAttrs classes = [ ("class", unwords classes) ]

mutual
  showEls : Show a => List a -> String
  showEls = concat . map show

  Show (Element RootChild) where
    show (Head content) = tag "head" [] $ Just (showEls content)
    show (Body content) = tag "body" [] $ Just (showEls content)

  Show (Element HeadChild) where
    show (Link rel t href) = tag "link" [ ("rel", show rel)
                                        , ("type", show t)
                                        , ("href", href)
                                        ]
                                        Nothing
    show (Title str) = tag "title" [] $ Just str

  Show LinkRel where
    show Stylesheet = "Stylesheet"

  Show LinkType where
    show TextCss = "text/css"

  Show (Element InList) where
    show (Li classes els) = tag "li" (classAttrs classes) $ Just (showEls els)

  Show (Element General) where
    show (P els) = tag "p" [] $ Just (showEls els)
    show (Div [] els) = tag "div" [] $ Just (showEls els)
    show (Div classes els) = tag "div" (classAttrs classes) $ Just (showEls els)
    show (Pre classes str) = tag "pre" (classAttrs classes) $ Just str
    show (Text str) = str
    show (Img src) = tag "img" [ ("src", src) ] Nothing
    show (H1 str) = tag "h1" [] $ Just str
    show (H2 str) = tag "h2" [] $ Just str
    show (Ul _ []) = ""
    show (Ul classes lis) = tag "ul" (classAttrs classes) $ Just (showEls lis)
    show (A classes href str) = tag "a" ( ("href", href) :: (classAttrs classes) ) $ Just str

export
li : String -> Element InList
li str = Li [] [ Text str ]

public export
record Page where
  constructor MkPage
  path : String
  filepath : String
  menuTitle : String
  title : String
  content : List (Element General)

html : Element Root -> String
html (Html els) = "<!DOCTYPE html>" ++ (tag "html" [] $ Just (showEls els))

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
