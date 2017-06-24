module CV

import Site
import Classes
import CVGenerator

export
cv : Page
cv =
  MkPage "/cv/" "cv" "CV" "CV"
  [ CVGenerator.cv $ MkDocument
    [ MkPosition "Senior Software Engineer"
                 "Pivotal"
                                 "London / San Francisco"
                                 (MkDate January 2012)
                                 Present
    ]
    [ MkCourse   "University of Cambridge"
                 "BA"
                 "Philosophy"
                 "2:2"
                 (MkDate October 2002)
                 (Just $ MkDate July 2005)
    ]
  ]
