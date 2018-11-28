module Main

import Mrk
import Site
import WebServer
import WebServer.Routes
import WebServer.JS

import Index
import CV
import Contact
import Classes

%lib Node "fs"

menu : Vect 3 Page
menu =
  [ indexSite
  , cvSite
  , contact
  ]

menuItem : Page -> Element InList
menuItem page = Li [Classes [MenuItem]]
                   [A [Classes [NoHist]] [Href (path page)] (menuTitle page)]

assemblePage : Vect (S n) Page -> Page -> Site.Element Root
assemblePage allPages page =
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

headers : (body : String) -> (path : String) -> List Header
headers body path =
  [ ContentLengthFor body
  , ContentTypeFor path
  ]

notFound : Response
notFound =
  let body = "Not Found\n" in
  MkResponse NotFound body (headers body "html")

serveBody : String -> Request -> Response
serveBody body req = MkResponse OK body (headers body (path req))

generate : Page -> String
generate = html . assemblePage menu

namespace MrkGenerate
  generate : Document Root -> String
  generate = show

static : List (String, String) -> Routes
static ((path, body) :: xs) =
  MkRoute Get path End (serveBody body) :: static xs

handler : Routes -> Request -> Response
handler routes req = fromMaybe notFound (handle req routes)

readFile : (path : String) -> JS_IO String
readFile = js "fs.readFileSync(%0)" (String -> JS_IO String)

syntax [path] ":" [page] = (path, generate page)
syntax [path] "!" [src] = (path, !(readFile src))

main : JS_IO ()
main = do
  putStrLn' "Server starting"
  startServer
    8080
    (putStrLn' "Serving on http://0.0.0.0:8080") $
    (handler . static)
    [ "/"                       : index
    , "/cv/"                    : cv
    , "/cv.pdf"                 ! "public/cv.pdf"
    , "/contact/"               : contact
    , "/encrypt/"               ! "public/encrypt/index.html"
    , "/jquery-3.2.1.min.js"    ! "public/jquery-3.2.1.min.js"
    , "/encrypt/openpgp.min.js" ! "public/encrypt/openpgp.min.js"
    , "/encrypt/application.js" ! "public/encrypt/application.js"
    , "/key.asc"                ! "public/key.asc"
    , "/normalize.css"          ! "public/normalize.css"
    , "/styles.css"             ! "public/styles.css"
    ]

-- Local Variables:
-- idris-load-packages: ("webserver" "site" "mrk")
-- End:
