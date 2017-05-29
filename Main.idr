module Main

import System

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

pageList : String
pageList = concat $ intersperse ", " (map menuTitle menu)

pagesWithName : String -> List Page -> List Page
pagesWithName name pages = filter (\p => menuTitle p == name) pages

happyPath : (pageName : String) -> List Page -> IO ()
happyPath pageName pages =
  case pagesWithName pageName pages of
       []     => do putStrLn "couldn't find a matching page"
                    exitFailure
       [page] => putStr $ html (assemblePage page pages)
       _pages => do putStrLn "multiple pages match"
                    exitFailure

main : IO ()
main = do
  args <- getArgs
  case args of
    []            => putStrLn $ "must provide a page: " ++ pageList
    [_, pageName] => happyPath pageName menu
    _multiple     => putStrLn "only one page argument allowed"
