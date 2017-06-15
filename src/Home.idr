module Home

import Site
import Classes

export
home : Page
home =
  MkPage "/" "index" "Home" "A software person in London"
  [ P
    [ Text "Here is my face"
    ]
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  , Ul noClass
    [ Li noClass [ Text "Test Driven Development (TDD)" ]
    , Li noClass [ Text "Pair programming and mentoring" ]
    , Li noClass [ Text "Complaining about what an Agile/XP team is(n't) doing" ]
    , Li noClass [ Text "Working on CloudFoundry" ]
    , Li noClass [ Text "Ruby" ]
    , Li noClass [ Text "JavaScript" ]
    , Li noClass [ Text "Objective-C" ]
    , Li noClass [ Text "Swift" ]
    , Li noClass [ Text "Go" ]
    ]
  , H2   "Things I wish people would pay me for"
  , Ul noClass
    [ Li noClass [ Text "Idris" ]
    , Li noClass [ Text "Haskell" ]
    , Li noClass [ Text "Elm" ]
    , Li noClass [ Text "Clojure / ClojureScript" ]
    , Li noClass [ Text "Teaching them anything I know from the comfort of my home" ]
    ]
  , H2   "Current role"
  , P
    [ Text      "I'm employed as a software engineer for "
    , A noClass "https://pivotal.io/" "Pivotal"
    , Text      ", currently on the CloudOps team."
    ]
  ]
