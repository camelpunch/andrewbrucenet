module Index

import Site
import Classes

export
index : Page
index =
  MkPage "/" "index" "Home" "A software person in London"
  [ P
    []
    [ Text "Here is my face" ]
  , Img  "https://pbs.twimg.com/profile_images/422231524897878016/u4fu2WH-_400x400.jpeg"
  , H2 [] "Things people usually pay me for"
  , Ul []
    [ Li [] [ Text "Test Driven Development (TDD)" ]
    , Li [] [ Text "Pair programming and mentoring" ]
    , Li [] [ Text "Complaining about what an Agile/XP team is(n't) doing" ]
    , Li [] [ Text "Working on CloudFoundry" ]
    , Li [] [ Text "Ruby" ]
    , Li [] [ Text "JavaScript" ]
    , Li [] [ Text "Objective-C" ]
    , Li [] [ Text "Swift" ]
    , Li [] [ Text "Go" ]
    ]
  , H2 [] "Things I wish people would pay me for"
  , Ul []
    [ Li [] [ Text "Idris" ]
    , Li [] [ Text "Haskell" ]
    , Li [] [ Text "Elm" ]
    , Li [] [ Text "Clojure / ClojureScript" ]
    , Li [] [ Text "Teaching them anything I know from the comfort of my home" ]
    ]
  , H2 [] "Current role"
  , P
    []
    [ Text "I'm employed as a software engineer for "
    , A    [] [Href "https://pivotal.io/"] "Pivotal"
    , Text ", currently on the Services Enablement team."
    ]
  ]
