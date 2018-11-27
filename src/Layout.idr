module Layout

import Mrk

import Classes

%default total

menuItem : URI -> String -> Document Ul
menuItem uri s =
  li [ClassNames [MenuItem]] $ do
     a (Just uri) [ClassNames [NoHist]] $ do
       text s

export
page : (headTitle : String) ->
       (pageTitle : String) ->
       Document Div ->
       Document Root
page headTitle pageTitle content = do
  html $ do
    head $ do
      meta $ Charset UTF8
      title headTitle
      stylesheet "/normalize.css"
      stylesheet "/styles.css"
    body $ do
      div [ClassNames [Container]] $ do
        h1 pageTitle
        ul [ClassNames [Menu, NoPrint]] $ do
          menuItem "/" "Home"
          menuItem "/cv/" "CV"
          menuItem "/contact/" "Contact"
        content
        p [ClassNames [NoPrint]] $ do
          a (Just "https://github.com/camelpunch/andrewbrucenet") "Source"

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
