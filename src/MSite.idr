module MSite

import public Control.Monad.Writer
import public Control.Monad.Identity
import public Data.List

%default total
%access public export

namespace NodeNames
  data NodeName
    = Html
    | Head
    | Title
    | Link
    | Body
    | Div
    | Ul
    | Li
  %name NodeName nodeName

  Show NodeName where
    show Html = "html"
    show Head = "head"
    show Title = "title"
    show Link = "link"
    show Body = "body"
    show Div = "div"
    show Ul = "ul"
    show Li = "li"

  Eq NodeName where
    Html == Html = True
    Head == Head = True
    Title == Title = True
    Link == Link = True
    Body == Body = True
    Div == Div = True
    Ul == Ul = True
    Li == Li = True
    _ == _ = False

URI : Type
URI = String

data Attribute : Type where
  ClassNames : List String -> Attribute
  Href : URI -> Attribute
%name Attribute attr

classNames : List String -> Attribute
classNames = ClassNames

Show Attribute where
  show (ClassNames xs) = "class=\"" ++ unwords xs ++ "\""
  show (Href uri) = show uri

namespace Elements
  mutual
    data Element : (parent : NodeName) -> Type where
      Generic : (el : NodeName) ->
                (attrs : List Attribute) ->
                (children : Element el) ->
                {auto prf : el `HasParent` parent} ->
                {auto prfAttrs : attrsPermitted el attrs = True} ->
                Element parent
      Head : List Attribute ->
             (children : Element Head) ->
             {auto prf : numTitles children = 1} ->
             Element Html
      Link : List Attribute ->
             Element parent
      Empty : Element parent
      Text : String -> Element parent
      Collection : (existing : Element parent) ->
                   (new : Element parent) ->
                   Element parent

    attrsPermitted : NodeName -> List Attribute -> Bool
    attrsPermitted nodeName [] = True
    attrsPermitted Link (Href :: attrs) = attrsPermitted Link attrs
    attrsPermitted nodeName ((ClassNames _) :: attrs) = attrsPermitted nodeName attrs
    attrsPermitted _ _ = False

    numTitles : Element Head -> Nat
    numTitles (Generic Title xs children) = 1
    numTitles (Collection existing new) = numTitles existing + numTitles new
    numTitles _ = 0

    HasParent : (child : NodeName) -> (parent : NodeName) -> Type
    HasParent child parent = child `Elem` childrenOf parent where
      childrenOf : NodeName -> List NodeName
      childrenOf Html = [Head, Body]
      childrenOf Head = [Link, Title]
      childrenOf Title = []
      childrenOf Link = []
      childrenOf Body = [Div, Ul]
      childrenOf Div = [Ul, Li, Div]
      childrenOf Ul = [Li]
      childrenOf Li = [Div]

  showAttrs : List Attribute -> String
  showAttrs [] = ""
  showAttrs xs = " " ++ unwords (map show xs)

  openTag : NodeName -> List Attribute -> String
  openTag name attrs = "<" ++ show name ++ showAttrs attrs ++ ">"

  closeTag : NodeName -> String
  closeTag name = "</" ++ show name ++ ">"

  selfCloseTag : NodeName -> List Attribute -> String
  selfCloseTag name attrs = "<" ++ show name ++ showAttrs attrs ++ "/>"

  mutual
    openCloseTag : NodeName -> List Attribute -> Element _ -> String
    openCloseTag name attrs children =
      openTag name attrs
      ++ show children ++
      closeTag name

    Show (Element parent) where
      show (Generic el attrs children) =
        openCloseTag el attrs children
      show (Head attrs children) =
        openCloseTag Head attrs children
      show (Link attrs) = selfCloseTag Link attrs
      show Empty = ""
      show (Text x) = x
      show (Collection x y) = show x ++ show y

  Semigroup (Element parent) where
    (<+>) = Collection

  Monoid (Element parent) where
    neutral = Text ""

Document : (parent : NodeName) -> Type
Document parent = Writer (Element parent) ()

fromDocument : Document parent -> Element parent
fromDocument (WR (Id (_, contents))) = contents

Show (Document parent) where
  show x {parent} =
    "<" ++ show parent ++ ">"
    ++ show (fromDocument x) ++
    "</" ++ show parent ++ ">"

head : List Attribute ->
       (children : Document Head) ->
       {auto prf : numTitles (fromDocument children) = 1} ->
       Document Html
head attrs children = tell $ Head attrs (fromDocument children)

title : (attrs : List Attribute) ->
        String ->
        {auto prf : attrsPermitted Title attrs = True} ->
        Document Head
title attrs text = tell $ Generic Title attrs (Text text)

body : (attrs : List Attribute) ->
       Document Body ->
       {auto prf : attrsPermitted Body attrs = True} ->
       Document Html
body attrs children = tell $ Generic Body attrs (fromDocument children)

div : (attrs : List Attribute) ->
      Document Div ->
      {auto prf : Div `HasParent` parent} ->
      {auto attrsPrf : attrsPermitted Div attrs = True} ->
      Document parent
div attrs children = tell $ Generic Div attrs (fromDocument children)

link : (attrs : List Attribute) ->
       {auto prf : Link `HasParent` parent} ->
       {auto attrsPrf : attrsPermitted Link attrs = True} ->
       Document parent
link attrs = tell $ Generic Link attrs Elements.Empty

text : String -> Document a
text = tell . Text
