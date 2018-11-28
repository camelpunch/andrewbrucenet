module Contact

import Mrk

import Classes
import Layout

export
contact : Document Root
contact = page "Andrew Bruce: Contact" "Contact" $ do
  h2 "Methods"
  h3 "Encrypted"
  p $ do
    a (Just "/encrypt/") "Create an encrypted message"
    text ", then send it to me however you like. Only I will be able to read it."
  h3 "Email"
  p $ a (Just "mailto:me@andrewbruce.net") "me@andrewbruce.net"
  h3 "Social Media"
  p $ a (Just "https://twitter.com/bruciemoose") "Twitter"
  p $ a (Just "https://github.com/camelpunch") "GitHub"
  p $ a (Just "https://www.linkedin.com/in/andrew-bruce-96098682/") "LinkedIn"

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
