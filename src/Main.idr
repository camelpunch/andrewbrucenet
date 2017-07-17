module Main

import Site
import Home
import CV
import Contact
import Blog
import Classes

menu : Vect 4 Page
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

assemblePage : Page -> Vect n Page -> Element Root
assemblePage page allPages =
  Html $
  [ Head $
    [ Title $ "Andrew Bruce: " ++ title page
    , Link [ Rel Stylesheet, LinkType TextCss, Href "/normalize.css"]
    , Link [ Rel Stylesheet, LinkType TextCss, Href "/styles.css"]
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
