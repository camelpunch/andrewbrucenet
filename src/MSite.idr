module MSite

import Data.List

%default total

namespace Elements
  data Element
    = Html
    | Head
    | Body
    | Ul
    | Li
    | Div
  Show Element where
    show Html = "html"
    show Head = "head"
    show Body = "body"
    show Ul = "ul"
    show Li = "li"
    show Div = "div"

%name Elements.Element el

namespace GenericAttr
  data GenericAttr : Type where
    ClassNames : List String -> GenericAttr
  Show GenericAttr where
    show (ClassNames xs) = "class=\"" ++ unwords xs ++ "\""

AttrsFor : Element -> Type
AttrsFor Html = GenericAttr
AttrsFor Head = GenericAttr
AttrsFor Body = GenericAttr
AttrsFor Ul = GenericAttr
AttrsFor Li = GenericAttr
AttrsFor Div = GenericAttr

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
      Empty : Contents parent
      (>>=) : Contents parent -> (Element -> Contents parent) -> Contents parent

    allowedChildOf : Element -> List Element
    allowedChildOf Html = [Head, Body]
    allowedChildOf Head = []
    allowedChildOf Body = [Ul]
    allowedChildOf Ul = [Li]
    allowedChildOf Li = [Div]
    allowedChildOf Div = [Ul, Li, Div]
%name Contents contents

syntax "class" "=" [classes] = ClassNames (words classes)
syntax html [children] = Open Html [] children
syntax head [children] = Open Head [] children
syntax body [children] = Open Body [] children
syntax ul [children] = Open Ul [] children
syntax ul [attrs] ";" [children] = Open Ul attrs children
syntax li [children] = Open Li [] children
syntax li [attrs] ";" [children] = Open Li attrs children
syntax li "." [classes] ";" [children] = Open Li [ClassNames (words classes)] children
syntax ":" [s] = Text s
syntax "." = Empty

listy : Contents Html
listy = do
  head : ""
  body do
    ul do
      li .
    ul .
