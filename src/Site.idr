module Site

import System
import public Data.Vect

public export
data ElementContext = Root | RootChild | HeadChild | InList | General

public export
data RelValue = Stylesheet
%name RelValue rel

public export
data LinkTypeValue = TextCss
%name LinkTypeValue t

export
interface Show c => HtmlClass c

public export
Show a => HtmlClass a where

data NoClass

export
noClass : List NoClass
noClass = []

export
Show NoClass where
  show _ = ""
  
public export
data AttributeContext = AttrInLink | AttrGeneral

public export
data Attribute : AttributeContext -> Type where
  Rel : RelValue -> Attribute AttrInLink
  LinkType : LinkTypeValue -> Attribute AttrInLink
  Href : String -> Attribute AttrInLink
  Classes : HtmlClass a => Vect (S n) a -> Attribute AttrGeneral

public export
data Element : ElementContext -> Type where
  Html : List (Element RootChild) -> Element Root
  Head : List (Element HeadChild) -> Element RootChild
  Title : String -> Element HeadChild
  Link : List (Attribute AttrGeneral) -> List (Attribute AttrInLink) -> Element HeadChild
  Body : List (Element General) -> Element RootChild
  P : List (Element General) -> Element General
  Div : List (Attribute AttrGeneral) -> List (Element General) -> Element General
  Pre : HtmlClass c => List c -> String -> Element General
  Text : String -> Element General
  Img : String -> Element General
  H1 : String -> Element General
  H2 : String -> Element General
  H3 : String -> Element General
  H4 : String -> Element General
  H5 : String -> Element General
  Ul : List (Attribute AttrGeneral) -> (Vect (S n) (Element InList)) -> Element General
  Li : List (Attribute AttrGeneral) -> (List (Element General)) -> Element InList
  A : List (Attribute AttrGeneral) -> List (Attribute AttrInLink) -> String -> Element General

attributes : (attrs : List (String, String)) -> String
attributes attrs =
  unwords (map (\(k, v) => k ++ "=\"" ++ v ++ "\"") attrs)

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

classAttrs : HtmlClass c => List c -> List (String, String)
classAttrs [] = []
classAttrs classes = [ ("class", unwords (map show classes)) ]

classAttrsV : HtmlClass a => (classes : Vect (S n) a) -> (String, String)
classAttrsV classes = ("class", unwords (map show (toList classes)))

mutual
  attributify : (attrs : List (Attribute a)) -> List (String, String)
  attributify [] = []
  attributify (Rel rel :: xs) = ("rel", show rel) :: attributify xs
  attributify (LinkType t :: xs) = ("type", show t) :: attributify xs
  attributify (Href href :: xs) = ("href", href) :: attributify xs
  attributify (Classes classes :: xs) = classAttrsV classes :: attributify xs

  showEls : Show a => List a -> String
  showEls = concat . map show

  Show (Element RootChild) where
    show (Head content) = "<head><meta charset=\"utf-8\">" ++ showEls content ++ "</head>"
    show (Body content) = tag "body" [] $ Just (showEls content)

  Show (Element HeadChild) where
    show (Link attrs linkAttrs) = tag "link" (attributify attrs ++ attributify linkAttrs) Nothing
    show (Title str) = tag "title" [] $ Just str

  Show RelValue where
    show Stylesheet = "Stylesheet"

  Show LinkTypeValue where
    show TextCss = "text/css"

  Show (Element InList) where
    show (Li attrs els) = tag "li" (attributify attrs) $ Just (showEls els)

  Show (Element General) where
    show (P els) = tag "p" [] $ Just (showEls els)
    show (Div attrs els) = tag "div" (attributify attrs) $ Just (showEls els)
    show (Pre classes str) = tag "pre" (classAttrs classes) $ Just str
    show (Text str) = str
    show (Img src) = tag "img" [ ("src", src) ] Nothing
    show (H1 str) = heading "h1" str
    show (H2 str) = heading "h2" str
    show (H3 str) = heading "h3" str
    show (H4 str) = heading "h4" str
    show (H5 str) = heading "h5" str
    show (Ul attrs lis) = tag "ul" (attributify attrs) $ Just (showEls $ toList lis)
    show (A attrs aAttrs str) = tag "a" (attributify attrs ++ attributify aAttrs) $ Just str
  heading : String -> String -> String
  heading name str = tag name [] $ Just str

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
generate : (Page -> Vect (S n) Page -> Element Root) ->
           Vect (S n) Page ->
           List String ->
           IO ()
generate {n} assemblePage pages args =
  case args of
    []            => die $ "must provide a page: " ++ (concat $ intersperse ", " (map filepath pages))
    [_, pageName] => generatePage pageName pages
    _multiple     => die "only one page argument allowed"
  where
    die : String -> IO ()
    die msg = do
      fPutStrLn stderr msg
      exitFailure

    pagesWithName : String -> Vect (S n) Page -> List Page
    pagesWithName name pages = filter (\p => filepath p == name) $ toList pages

    generatePage : String -> Vect (S n) Page -> IO ()
    generatePage pageName pages =
      case pagesWithName pageName pages of
        []     => die "couldn't find a matching page"
        [page] => putStr $ html (assemblePage page pages)
        _pages => die "multiple pages match"
