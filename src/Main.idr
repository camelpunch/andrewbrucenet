module Main

import WebServer
import WebServer.Routes
import WebServer.JS
import Site

import Index
import CV
import Contact
import Classes

%lib Node "fs"

menu : Vect 3 Page
menu =
  [ index
  , cv
  , contact
  ]

menuItem : Page -> Element InList
menuItem page = Li [Classes [MenuItem]]
                   [A [Classes [NoHist]] [Href (path page)] (menuTitle page)]

assemblePage : Page -> Vect (S n) Page -> Element Root
assemblePage page allPages =
  Html $
  [ Head $
    [ Title $ "Andrew Bruce: " ++ title page
    , Link [] [Rel Stylesheet, LinkType TextCss, Href "/normalize.css"]
    , Link [] [Rel Stylesheet, LinkType TextCss, Href "/styles.css"]
    ]
  , Body $
    [ Div [Classes [Container]]
      ( [ H1 [] $ title page
        , Ul [Classes [Menu, NoPrint]] (map menuItem allPages)
        ] ++ content page ++
        [ P [Classes [NoPrint]] [ A [] [Href "https://github.com/camelpunch/andrewbrucenet"] "Source" ]
        ]
      )
    ]
  ]

notFound : Response
notFound = MkResponse 404 "Not Found"

dynamic : Page -> Request -> Response
dynamic page _ = MkResponse 200 . html $ assemblePage page menu

static : String -> Request -> Response
static s _ = MkResponse 200 s

routes : (normalizeCssBody : String) ->
         (stylesCssBody : String) ->
         Routes
routes normalizeBody stylesCssBody =
  [ get "/"              $ dynamic index
  , get "/cv/"           $ dynamic cv
  , get "/contact/"      $ dynamic contact

  -- , get "/encrypt/" $ \req =>
  --   MkResponse 200 $
  --   encryptBody

  , get "/normalize.css" $ static normalizeBody
  , get "/styles.css"    $ static stylesCssBody
  ]

handler : Routes -> Request -> Response
handler routes req = fromMaybe notFound (handle req routes)

readFile : (path : String) -> JS_IO String
readFile =
  js "fs.readFileSync(%0)"
     (String -> JS_IO String)

main : JS_IO ()
main = do
  putStrLn' "Reading static files"
  normalizeBody <- readFile "public/normalize.css"
  stylesBody <- readFile "public/styles.css"
  putStrLn' "Server starting"
  startServer 8080
              (putStrLn' "Serving on http://0.0.0.0:8080")
              (handler (routes normalizeBody stylesBody))

-- Local Variables:
-- idris-load-packages: ("webserver" "site")
-- End:
