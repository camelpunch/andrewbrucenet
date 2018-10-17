module TwoGroups

import public Data.PosNat

%default total
%access public export

data URI : Type where
  MkURI : String -> URI
%name URI uri

data LinkType
  = Stylesheet
  | Alternate
  | Archives
  | Author
  | Bookmark
  | External
  | Feed
  | First
  | Help
  | Icon
  | Index
  | Last
  | License
  | Next
  | Nofollow
  | Noreferrer
  | Pingback
  | Prefetch
  | Prev
  | Search
  | Sidebar
  | Tag
  | Up
%name LinkType rel

namespace MimeType
  data TextSubtype
    = CSS
    | Plain

  data MimeType
    = Text TextSubtype

data Language
  = English

data Direction
  = LeftToRight
  | RightToLeft

namespace Attribute
  data MetadataAttribute : Type where
    ID : String -> MetadataAttribute
    Title : String -> MetadataAttribute
    Lang : Language -> MetadataAttribute
    Dir : Direction -> MetadataAttribute
    ClassList : Show showable => List showable -> MetadataAttribute

namespace NonInteractive
  data NonInteractive : Type where
    Text : String -> NonInteractive
    Span : List NonInteractive -> NonInteractive

namespace Phrasing
  data Phrasing : Type where
    NonInteractive : NonInteractive -> Phrasing
    Span : List Phrasing -> Phrasing
    A : List MetadataAttribute ->
        URI ->
        List NonInteractive ->
        Phrasing

namespace Metadata
  data Metadata : Type where
    Link : (rel : LinkType) ->
           (mimeType : MimeType) ->
           (href : URI) ->
           Metadata

mutual
  namespace Flow
    data NonPhrasing : Type where
      H : (rank : Nat) ->
          {auto prf : rank `GTE` 1} ->
          {auto prf : 6 `GTE` rank} ->
          List MetadataAttribute ->
          List Phrasing ->
          NonPhrasing
      P : List MetadataAttribute -> List Phrasing -> NonPhrasing
      Div : List MetadataAttribute -> List FlowElem -> NonPhrasing
      Ul : List MetadataAttribute -> List FlowElem -> NonPhrasing
      Li : List MetadataAttribute -> List FlowElem -> NonPhrasing
      Menu : List MetadataAttribute -> List Phrasing -> NonPhrasing
      Phrasing : Phrasing -> NonPhrasing

  data FlowElem : Type where
    NonPhrasing : NonPhrasing -> FlowElem
    Phrasing : Phrasing -> FlowElem

data BrowsingContextKeyword
  = Blank
  | Self
  | Parent
  | Top

data BrowsingContextNameOrKeyWord : Type where
  Name : (firstChar : Char) ->
         (rest : List Char) ->
         {auto prf : firstChar == '_' = False} ->
         BrowsingContextNameOrKeyWord
  Keyword : BrowsingContextKeyword -> BrowsingContextNameOrKeyWord

data BaseElem : Type where
  BaseHrefTarget : (href : URI) ->
                   (target : BrowsingContextNameOrKeyWord) ->
                   BaseElem
  BaseHref : URI -> BaseElem
  BaseTarget : BrowsingContextNameOrKeyWord -> BaseElem

data HeadElem : Type where
  Head : (title : String) ->
         Maybe BaseElem ->
         (els : List Metadata) ->
         HeadElem
data BodyElem : Type where
  Body : (els : List FlowElem) ->
         BodyElem
data HtmlElem : Type where
  Html : (manifest : Maybe URI) ->
         HeadElem ->
         BodyElem ->
         HtmlElem

-- tests

doc : (title : String) ->
      (stylesheet : URI) ->
      (stylesheet2 : URI) ->
      HtmlElem
doc title stylesheet ss2 =
  Html Nothing (Head title Nothing []) (Body [])

-- Local Variables:
-- idris-load-packages: ("contrib")
-- End:
