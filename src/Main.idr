module Main

import WebServer
import WebServer.Routes
import Site
import Index
import CV
import Contact
import Classes

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

routes : Routes
routes =
  [ get "/" $ \req =>
    MkResponse 200 $
    html (assemblePage index menu)
  ]

handler : Routes -> Request -> Response
handler routes req = fromMaybe notFound (handle req routes)

main : JS_IO ()
main = do
  putStrLn' "Server starting"
  startServer 8080
              (putStrLn' "Serving on http://0.0.0.0:8080")
              (handler routes)

-- Local Variables:
-- idris-load-packages: ("webserver" "site")
-- End:
