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
                 (From (January 2012) Present)
    ]
    [ MkCourse   "University of Cambridge"
                 "BA"
                 "Philosophy"
                 "2:2"
                 (From (October 2002) (To $ July 2005))
    , MkCourse   "Ysgol Emrys ap Iwan"
                 "A Level"
                 "Computing"
                 "A"
                 (From (September 1995) (To $ July 2001))
    ]
  ]
