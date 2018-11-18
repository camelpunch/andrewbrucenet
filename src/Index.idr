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
  html [] $ do
    head [] $ do
      meta (Charset UTF8) []
      title [] "Andrew Bruce: A software person"
      stylesheet "/normalize.css"
      stylesheet "/styles.css"
    body [] $ do
      div [ClassNames [Container]] $ do
        h1 [] $ text "A software person"
        ul [ClassNames [Menu, NoPrint]] $ do
          menuItem "/" "Home"
          menuItem "/cv/" "CV"
          menuItem "/contact/" "Contact"
        p [] $ do
          text "Here is my face."
        img "https://pbs.twimg.com/profile_images/422231524897878016/u4fu2WH-_400x400.jpeg"
            "I'm wearing silly glasses and a pink wig, in a wedding photo booth thingy."
            []
        h2 [] $ text "Things people usually pay me for."
        ul [] $ do
          li [] $ text "Test Driven Development (TDD)"
          li [] $ text "Pair programming and mentoring"
          li [] $ text "DevOpsy things like Cloud Foundry and Kubernetes"
          li [] $ text "Ruby"
          li [] $ text "JavaScript"
          li [] $ text "Objective-C"
          li [] $ text "Swift"
          li [] $ text "Go"
        h2 [] $ text "This I wish people would pay me for, but the probably shouldn't."
        ul [] $ do
          li [] $ text "Idris"
          li [] $ text "Haskell"
          li [] $ text "Elm"
          li [] $ text "Clojure / ClojureScript"
        h2 [] $ text "Current role"
        p [] $ do
          text "I do consultancy through "
          a (Just "https://code.supply/") [] $ text "Code Supply"
        p [ClassNames [NoPrint]] $ do
          a (Just "https://github.com/camelpunch/andrewbrucenet") [] $ do
            text "Source"

export
indexSite : Page
indexSite =
  MkPage "/" "index" "Home" "A software person"
  [ P
    []
    [ Text "Here is my face" ]
  , Img [ Alt "Andrew's face"
        , Src "https://pbs.twimg.com/profile_images/422231524897878016/u4fu2WH-_400x400.jpeg"
        ]
  , H2 [] "Things people usually pay me for."
  , Ul []
    [ Li [] [ Text "Test Driven Development (TDD)" ]
    , Li [] [ Text "Pair programming and mentoring" ]
    , Li [] [ Text "DevOpsy things like Cloud Foundry and Kubernetes"]
    , Li [] [ Text "Ruby" ]
    , Li [] [ Text "JavaScript" ]
    , Li [] [ Text "Objective-C" ]
    , Li [] [ Text "Swift" ]
    , Li [] [ Text "Go" ]
    ]
  , H2 [] "Things I wish people would pay me for, but they probably shouldn't."
  , Ul []
    [ Li [] [ Text "Idris" ]
    , Li [] [ Text "Haskell" ]
    , Li [] [ Text "Elm" ]
    , Li [] [ Text "Clojure / ClojureScript" ]
    ]
  , H2 [] "Current role"
  , P
    []
    [ Text "I do consultancy through "
    , A    [] [Href "https://code.supply/"] "Code Supply"
    ]
  ]

-- Local Variables:
-- idris-load-packages: ("mrk" "site")
-- End:
