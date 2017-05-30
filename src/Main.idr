module Main

import Site
import Home
import CV
import Contact

data HtmlClass = Menu | MenuItem

menu : List Page
menu =
  [ home
  , cv
  , contact
  ]

htmlClass : HtmlClass -> Maybe String
htmlClass Menu = Just "menu"
htmlClass MenuItem = Just "menu-item"

menuItem : Page -> Element InList
menuItem page = Li (htmlClass MenuItem) [A (path page) (menuTitle page)]

assemblePage : Page -> List Page -> Element Root
assemblePage page allPages =
  Html $
  [ Head $
    [ Link Stylesheet TextCss "normalize.css"
    , Link Stylesheet TextCss "styles.css"
    ]
  , Body $
    [ H1 $ title page
    , Ul (htmlClass Menu) (map menuItem allPages)
    ] ++ content page
  ]

main : IO ()
main = getArgs >>= generate assemblePage menu
