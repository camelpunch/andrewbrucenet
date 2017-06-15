module Main

import Site
import Home
import CV
import Contact
import Blog

data HtmlClass = Menu | MenuItem

menu : List Page
menu =
  [ home
  , cv
  , contact
  , blog
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
    [ Title $ "Andrew Bruce: " ++ title page
    , Link Stylesheet TextCss "/normalize.css"
    , Link Stylesheet TextCss "/styles.css"
    ]
  , Body $
    [ Div (Just "container")
      ([ H1 $ title page
       , Ul (htmlClass Menu) (map menuItem allPages)
       ] ++ content page)
    ]
  ]

main : IO ()
main = getArgs >>= generate assemblePage menu
