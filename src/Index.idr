module Index

import Site
import Classes

export
index : Page
index =
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
-- idris-load-packages: ("site")
-- End:
