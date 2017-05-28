module Main

import Site

home : Page
home =
  MkPage "/" "Home" "A software person in London"
  [ P    "Here is my face"
  , Img  "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"
  , H2   "Things people usually pay me for"
  , Ul Things [ Li Thing [ P "Test Driven Development (TDD)" ]]
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

main : IO ()
main = putStrLn (html (assemblePage home menu))
