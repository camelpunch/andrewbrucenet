module CV

import Site

export
cv : Page
cv =
  MkPage "/cv" "cv" "CV" "CV"
  [ P
    [ Text $ "I do plan to publish this incredibly interesting work myself " ++
             "one day. Until then there's "
    , A []   "https://uk.linkedin.com/in/andrew-bruce-96098682" "Linkedin"
    , Text ", which I'm about ready to quit (again)."
    ]
  ]
