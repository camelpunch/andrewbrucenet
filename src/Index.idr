module Index

import Mrk
import Site

import Classes

%default total

menuItem : URI -> String -> Document Ul
menuItem uri s =
  li [ClassNames [MenuItem]] $ do
     a (Just uri) [ClassNames [NoHist]] $ do
       text s

export
index : Document Root
index = do
  html $ do
    head $ do
      meta $ Charset UTF8
      title "Andrew Bruce: A software person"
      stylesheet "/normalize.css"
      stylesheet "/styles.css"
    body $ do
      div [ClassNames [Container]] $ do
        h1 "A software person"
        ul [ClassNames [Menu, NoPrint]] $ do
          menuItem "/" "Home"
          menuItem "/cv/" "CV"
          menuItem "/contact/" "Contact"
        p "Here is my face."
        img "https://pbs.twimg.com/profile_images/422231524897878016/u4fu2WH-_400x400.jpeg"
            "I'm wearing silly glasses and a pink wig, in a wedding photo booth thingy."
        h2 "Things people usually pay me for."
        ul $ do
          li "Test Driven Development (TDD)"
          li "Pair programming and mentoring"
          li "DevOpsy things like Cloud Foundry and Kubernetes"
          li "Ruby"
          li "JavaScript"
          li "Objective-C"
          li "Swift"
          li "Go"
        h2 "Things I wish people would pay me for, but they probably shouldn't."
        ul $ do
          li "Idris"
          li "Haskell"
          li "Elm"
          li "Clojure / ClojureScript"
        h2 "Current role"
        p $ do
          text "I do consultancy through "
          a (Just "https://code.supply/") "Code Supply"
        p [ClassNames [NoPrint]] $ do
          a (Just "https://github.com/camelpunch/andrewbrucenet") "Source"

export
indexSite : Page
indexSite =
  MkPage "/" "index" "Home" neutral neutral

-- Local Variables:
-- idris-load-packages: ("site" "mrk")
-- End:
