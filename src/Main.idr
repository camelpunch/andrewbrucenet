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
menuItem (MkPage path _ menuTitle _ _) =
  Li (htmlClass MenuItem) [A path menuTitle]

assemblePage : Page -> List Page -> Element Root
assemblePage (MkPage _ _ _ title content) allPages =
  Html $
  [ H1 title
  , Ul (htmlClass Menu) (map menuItem allPages)
  ] ++ content

pageList : String
pageList = concat $ intersperse ", " (map menuTitle menu)

pagesWithName : String -> List Page -> List Page
pagesWithName name pages = filter (\p => filepath p == name) pages

die : String -> IO ()
die msg = do
  fPutStrLn stderr msg
  exitFailure

happyPath : (pageName : String) -> List Page -> IO ()
happyPath pageName pages =
  case pagesWithName pageName pages of
       []     => die "couldn't find a matching page"
       [page] => putStr $ html (assemblePage page pages)
       _pages => die "multiple pages match"

main : IO ()
main = do
  args <- getArgs
  case args of
    []            => die $ "must provide a page: " ++ pageList
    [_, pageName] => happyPath pageName menu
    _multiple     => die "only one page argument allowed"
