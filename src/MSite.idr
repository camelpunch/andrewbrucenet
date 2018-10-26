module MSite

import Data.List

%default total

namespace Elements
  data Element
    = Html
    | Head
    | Title
    | Link
    | Body
    | Div
    | Ul
    | Li
  Show Element where
    show Html = "html"
    show Head = "head"
    show Title = "title"
    show Link = "link"
    show Body = "body"
    show Div = "div"
    show Ul = "ul"
    show Li = "li"

namespace GenericAttr
  data GenericAttr : Type where
    ClassNames : List String -> GenericAttr
  Show GenericAttr where
    show (ClassNames xs) = "class=\"" ++ unwords xs ++ "\""

AttrsFor : Element -> Type
AttrsFor Html = GenericAttr
AttrsFor Head = GenericAttr
AttrsFor Title = GenericAttr
AttrsFor Link = GenericAttr
AttrsFor Body = GenericAttr
AttrsFor Div = GenericAttr
AttrsFor Ul = GenericAttr
AttrsFor Li = GenericAttr

namespace Contents
  mutual
    data Contents : (parent : Element) -> Type where
      Open : (el : Element) ->
             List (AttrsFor el) ->
             (children : Contents el) ->
             {auto prf : el `Elem` allowedChildOf parent} ->
             Contents parent
      Closed : Element -> Contents parent
      Text : String -> Contents parent
      Empty : Contents parent
      (>>=) : Contents parent -> (Element -> Contents parent) -> Contents parent

    allowedChildOf : Element -> List Element
    allowedChildOf Html = [Head, Body]
    allowedChildOf Head = [Title]
    allowedChildOf Title = []
    allowedChildOf Link = []
    allowedChildOf Body = [Div, Ul]
    allowedChildOf Div = [Ul, Li, Div]
    allowedChildOf Ul = [Li]
    allowedChildOf Li = [Div]

syntax "class" "=" [classes] = ClassNames (words classes)
syntax html [children] = Open Html [] children
syntax head [children] = Open Head [] children
syntax title [s] = Open Title [] (Text s)
syntax body [children] = Open Body [] children
syntax div [children] = Open Div [] children
syntax ul [children] = Open Ul [] children
syntax ul [attrs] ";" [children] = Open Ul attrs children
syntax li [children] = Open Li [] children
syntax li [attrs] ";" [children] = Open Li attrs children
syntax li "." [classes] ";" [children] = Open Li [ClassNames (words classes)] children
syntax ":" [s] = Text s
syntax "." = Empty

listy : Contents Html
listy = do
  head do
    title "My Website"
  body do
    div do
      ul do
        li .
      ul .
