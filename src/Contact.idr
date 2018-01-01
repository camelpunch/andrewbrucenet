module Contact

import Site
import Classes

export
contact : Page
contact =
  MkPage "/contact/" "contact" "Contact" "Contact"
  [ H2 [] "Methods"
  , H3 [] "Encrypted"
  , P [] [ Text "Install "
         , A [] [ Href "https://gnupg.org/" ] "gnupg"
         , Text ", then import my "
         , A [] [ Href "/key.asc" ] "public key"
         , Text ":"
         ]
  , P [] [ Code [] "curl http://www.andrewbruce.net/key.asc | gpg --import" ]
  , P [] [ Text "Ensure it wasn't tampered with:" ]
  , P [] [ Code [] "gpg --fingerprint me@andrewbruce.net" ]
  , P [] [ Text "The output should include the fingerprint I publish on e.g. "
         , A [] [ Href "https://twitter.com/bruciemoose" ] "Twitter"
         , Text " and keyservers."
         ]
  , P [] [ Text "Write a message:" ]
  , P [] [ Code [] "gpg --encrypt --armor --recipient me@andrewbruce.net" ]
  , P [] [ Text "Hit Ctrl-D when you've finished, then send the text between and including '-----BEGIN PGP MESSAGE-----' to me as an "
         , A [] [ Href "mailto:me@andrewbruce.net" ] "email"
         , Text " or via any other means."
         ]
  , P [] [ Text "There are easier ways from e.g. "
         , A [] [ Href "https://www.thunderbird.net/" ] "Thunderbird"
         , Text " via "
         , A [] [ Href "https://enigmail.net/" ] "Enigmail"
         , Text "."
         ]
  , H3 [] "Email"
  , P [] [ A [] [Href "mailto:me@andrewbruce.net"] "me@andrewbruce.net" ]
  , H3 [] "Social media"
  , P [] [ A [] [Href "https://twitter.com/bruciemoose"] "Twitter" ]
  , P [] [ A [] [Href "https://github.com/camelpunch"] "GitHub" ]
  ]
