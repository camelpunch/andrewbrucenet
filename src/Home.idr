module Home

import Site

export
home : Page
home =
  MkPage "/" "index" "Home" "A software person in London"
  [ P
    [ Text "Here is my face"
    ]
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  , Ul []
    [ li "Test Driven Development (TDD)"
    , li "Pair programming and mentoring"
    , li "Complaining about what an Agile/XP team is(n't) doing"
    , li "Working on CloudFoundry"
    , li "Ruby"
    , li "JavaScript"
    , li "Objective-C"
    , li "Swift"
    , li "Go"
    ]
  , H2   "Things I wish people would pay me for"
  , Ul []
    [ li "Idris"
    , li "Haskell"
    , li "Elm"
    , li "Clojure / ClojureScript"
    , li "Teaching them anything I know from the comfort of my home"
    ]
  , H2   "Current role"
  , P
    [ Text      "I'm employed as a software engineer for "
    , A []      "https://pivotal.io/" "Pivotal"
    , Text      ", currently on the CloudOps team."
    ]
  ]
