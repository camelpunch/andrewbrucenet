import Test.Unit
import MSite

doc : Document Html
doc = do
  head [] $ do
    title [] "Best site evah"
    link [Href "foo"]
  body [ClassNames ["hi"]] $ do
    (div [] $ div [] $ text "")

tests : List (IO Bool)
tests =
     assertEquals
       (show doc)
       "<html><head><title>Best site evah</title><link href=\"foo\"/></head><body class=\"hi\"><div><div></div></div></body></html>"

  :: assertTrue True
  :: neutral

main : IO ()
main = do
  runTests tests

-- Local Variables:
-- idris-load-packages: ("contrib" "site")
-- End:
