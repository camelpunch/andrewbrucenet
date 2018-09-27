module Main

import Site
import Index
import CV
import Contact
import Classes

menu : Vect 3 Page
menu =
  [ index
  , cv
  , contact
  ]

menuItem : Page -> Element InList
menuItem page = Li [Classes [MenuItem]]
                   [A [Classes [NoHist]] [Href (path page)] (menuTitle page)]

assemblePage : Page -> Vect (S n) Page -> Element Root
assemblePage page allPages =
  Html $
  [ Head $
    [ Title $ "Andrew Bruce: " ++ title page
    , Link [] [Rel Stylesheet, LinkType TextCss, Href "/normalize.css"]
    , Link [] [Rel Stylesheet, LinkType TextCss, Href "/styles.css"]
    ]
  , Body $
    [ Div [Classes [Container]]
      ( [ H1 [] $ title page
        , Ul [Classes [Menu, NoPrint]] (map menuItem allPages)
        ] ++ content page ++
        [ P [Classes [NoPrint]] [ A [] [Href "https://github.com/camelpunch/andrewbrucenet"] "Source" ]
        ]
      )
    ]
  ]

main : IO ()
main = getArgs >>= generate assemblePage menu

-- Local Variables:
-- idris-load-packages: ("site")
-- End:
