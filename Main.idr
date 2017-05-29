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
menuItem (MkPage path menuTitle _ _) =
  Li (htmlClass MenuItem) [A path menuTitle]

assemblePage : Page -> List Page -> Element Root
assemblePage (MkPage _ _ title content) allPages =
  Html $
  [ H1 title
  , Ul (htmlClass Menu) (map menuItem allPages)
  ] ++ content

main : IO ()
main = putStr (html (assemblePage home menu))
