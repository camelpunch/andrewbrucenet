module Contact

import Site
import Classes

export
contact : Page
contact =
  MkPage "/contact/" "contact" "Contact" "Contact"
  [ H2 [] "Methods"
  , H3 [] "Encrypted"
  , P [] [ A [] [ Href "/encrypt/" ] "Create an encrypted message"
         , Text ", then send it to me however you like. Only I will be able to read it."
         ]
  , H3 [] "Email"
  , P [] [ A [] [Href "mailto:me@andrewbruce.net"] "me@andrewbruce.net" ]
  , H3 [] "Social media"
  , P [] [ A [] [Href "https://twitter.com/bruciemoose"] "Twitter" ]
  , P [] [ A [] [Href "https://github.com/camelpunch"] "GitHub" ]
  , P [] [ A [] [Href "https://www.linkedin.com/in/andrew-bruce-96098682/"] "LinkedIn" ]
  ]
