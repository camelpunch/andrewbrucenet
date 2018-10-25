module MSite

import Data.List

showList : Show a => List a -> String
showList = unwords . map show

namespace Elements
  data Element = Ul | Li | Div
  Show Element where
    show Ul = "ul"
    show Li = "li"
    show Div = "div"

%name Elements.Element el

namespace UlAttr
  data UlAttr : Type where
    ClassNames : List String -> UlAttr
  Show UlAttr where
    show (ClassNames xs) = "class=\"" ++ unwords xs ++ "\""

namespace LiAttr
  data LiAttr : Type where
    ClassNames : List String -> LiAttr
  Show LiAttr where

data DivAttr : Type where
Show DivAttr where

AttrsFor : Element -> Type
AttrsFor Ul = UlAttr
AttrsFor Li = LiAttr
AttrsFor Div = DivAttr

namespace Contents
  mutual
    data Contents : (parent : Element) -> Type where
      Open : (el : Element) ->
             List (AttrsFor el) ->
             (child : Contents el) ->
             {auto prf : el `Elem` allowedChildOf parent} ->
             Contents parent
      Closed : Element -> Contents parent
      Text : String -> Contents parent
      (>>=) : Contents parent -> (Contents parent -> Contents parent) -> Contents parent

    allowedChildOf : Element -> List Element
    allowedChildOf el =
      case el of
           Ul => [Li]
           Li => [Div]
           Div => [Ul, Li, Div]

%name Contents contents

Show (Contents parent) where
  show (Open Ul attrs contents) =
    "<" ++ show Ul ++ " " ++ showList attrs ++ ">"
    ++ show contents ++
    "</" ++ show Ul ++ ">"
  show (Open Li attrs contents) =
    "<" ++ show Li ++ " " ++ showList attrs ++ ">"
    ++ show contents ++
    "</" ++ show Li ++ ">"
  show (Open Div attrs contents) =
    "<" ++ show Div ++ " " ++ showList attrs ++ ">"
    ++ show contents ++
    "</" ++ show Div ++ ">"
  show (Closed el) =
    "<" ++ show el ++ "/>"
  show (Text s) = s
  show (contents >>= f) =
    show contents ++ show (f contents)

syntax "class" "=" [classes] = ClassNames (words classes)
syntax ul [children] = Open Ul [] children
syntax ul [attrs] ";" [children] = Open Ul attrs children
syntax li [children] = Open Li [] children
syntax li [attrs] ";" [children] = Open Li attrs children
syntax li "." [classes] ";" [children] = Open Li [ClassNames (words classes)] children
syntax ":" [s] = Text s

listy : Contents Div
listy =
  ul [class="baz bar"]; do
    li : "foo"
    li : "bar"
