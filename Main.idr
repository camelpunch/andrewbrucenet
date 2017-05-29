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

assemblePage : Page -> List Page -> Content
assemblePage (MkPage _ _ title content) allPages =
  [ H1 title
  , Ul (htmlClass Menu) (map menuItem allPages)
  ] ++
  content

main : IO ()
main = putStrLn (html (assemblePage home menu))
