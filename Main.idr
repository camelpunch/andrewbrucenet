module Main

import Site

data HtmlClass = Menu | MenuItem

htmlClass : HtmlClass -> Maybe String
htmlClass Menu = Just "menu"
htmlClass MenuItem = Just "menu-item"

li : String -> Element InList
li str = Li Nothing [ P [ Text str ] ]

home : Page
home =
  MkPage "/" "Home" "A software person in London"
  [ P
    [ Text "Here is my face"
    ]
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  , Ul Nothing
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
  , Ul Nothing
    [ li "Idris"
    , li "Haskell"
    , li "Elm"
    , li "Clojure / ClojureScript"
    , li "Teaching them anything I know from the comfort of my home"
    ]
  , H2   "Current role"
  , P
    [ Text "I'm employed as a software engineer for "
    , A    "https://pivotal.io/" "Pivotal"
    , Text ", currently on the CloudOps team."
    ]
  ]

cv : Page
cv =
  MkPage "/cv" "CV" "CV"
  []

contact : Page
contact =
  MkPage "/contact" "Contact" "Contact"
  []

menu : List Page
menu =
  [ home
  , cv
  , contact
  ]

menuItem : Page -> Element InList
menuItem (MkPage path menuTitle _ _) =
  Li (htmlClass MenuItem) [A path menuTitle]

assemblePage : Page -> List Page -> Content
assemblePage (MkPage _ _ title content) allPages =
  [ H1 title
  , Ul (htmlClass Menu) (map menuItem allPages)
  ] ++
  content

main : IO ()
main = putStrLn (html (assemblePage home menu))
