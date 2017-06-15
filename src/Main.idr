module Main

import Site
import Home
import CV
import Contact
import Blog
import Classes

menu : List Page
menu =
  [ home
  , cv
  , contact
  , blog
  ]

menuItem : Page -> Element InList
menuItem page = Li [MenuItem]
                  [ A [NoHist] (path page) (menuTitle page)
                  ]

assemblePage : Page -> List Page -> Element Root
assemblePage page allPages =
  Html $
  [ Head $
    [ Title $ "Andrew Bruce: " ++ title page
    , Link Stylesheet TextCss "/normalize.css"
    , Link Stylesheet TextCss "/styles.css"
    ]
  , Body $
    [ Div [Container]
      ( [ H1 $ title page
        , Ul [Menu] (map menuItem allPages)
        ] ++ content page ++
        [ P [ A noClass "https://github.com/camelpunch/andrewbrucenet" "Source" ]
        ]
      )
    ]
  ]

main : IO ()
main = getArgs >>= generate assemblePage menu
