module Main

import Site

data Class = Menu | MenuItem | Things | Thing

htmlClass : Class -> String
htmlClass Menu = "menu"
htmlClass MenuItem = "menu-item"
htmlClass Things = "things"
htmlClass Thing = "thing"

home : Page
home =
  MkPage "/" "Home" "A software person in London"
  [ P    "Here is my face"
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  , Ul (htmlClass Things) [ Li (htmlClass Thing) [ P "Test Driven Development (TDD)" ]]
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

total menuItem : Page -> Element InList
menuItem (MkPage path menuTitle _ _) = Li (htmlClass MenuItem) [A path menuTitle]

assemblePage : Page -> List Page -> Content
assemblePage (MkPage _ _ title content) allPages =
  [ H1 title
  , Ul (htmlClass Menu) (map menuItem allPages)
  ] ++
  content

main : IO ()
main = putStrLn (html (assemblePage home menu))
