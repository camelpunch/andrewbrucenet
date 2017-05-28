module Main

import Site

main : IO ()
main = putStrLn (html (content Home))
