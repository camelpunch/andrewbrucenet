module CVGenerator

import Data.Vect

import Site

public export
data Date
  = January Integer
  | February Integer
  | March Integer
  | April Integer
  | May Integer
  | June Integer
  | July Integer
  | August Integer
  | September Integer
  | October Integer
  | November Integer
  | December Integer

Show Date where
  show (January year) = "Jan " ++ show year
  show (February year) = "Feb " ++ show year
  show (March year) = "Mar " ++ show year
  show (April year) = "Apr " ++ show year
  show (May year) = "May " ++ show year
  show (June year) = "Jun " ++ show year
  show (July year) = "Jul " ++ show year
  show (August year) = "Aug " ++ show year
  show (September year) = "Sep " ++ show year
  show (October year) = "Oct " ++ show year
  show (November year) = "Nov " ++ show year
  show (December year) = "Dec " ++ show year

public export
data ToDate = To Date | Present

Show ToDate where
  show (To d) = show d
  show Present = "Present"

public export
data DateRange = From Date ToDate

Show DateRange where
  show (From from to) = show from ++ " to " ++ show to

export
record Position where
  constructor MkPosition
  title : String
  company : String
  location : String
  period : DateRange
  description : String

%name Position position, position1

export
record Course where
  constructor MkCourse
  school : String
  qualification : String
  field : String
  grade : String
  period : DateRange
  description : String

%name Course course, course1

export
record Document where
  constructor MkDocument
  experience : Vect (S n) Position
  education : Vect (S m) Course

%name Document doc

strPara : String -> Element General
strPara str = P [] [ Text $ str ]

showPara : Show a => a -> Element General
showPara = strPara . show

toParas : String -> List (Element General)
toParas text = map strPara $ filter (/= "") (lines text)

data CVClass
  = NoBullet
  | NoListIndent

Show CVClass where
  show NoBullet = "cv-item"
  show NoListIndent = "cv-section"

experienceLis : Vect (S n) Position -> Vect (S n) (Element InList)
experienceLis (position :: []) =
  [ Li [Classes [NoBullet]] $
    [ H3 $ title position
    , H4 $ company position ++ " (" ++ location position ++ ", " ++ show (period position) ++ ")"
    ] ++ (toParas (description position))
  ]
experienceLis (x :: x' :: xs) = experienceLis [x] ++ experienceLis (x' :: xs)

educationLis : Vect (S n) Course -> Vect (S n) (Element InList)
educationLis (course :: []) =
  [ Li [Classes [NoBullet]]
    [ H3 $ school course
    , H4 $ qualification course ++ ", " ++ field course ++ ", " ++ grade course
    , showPara $ period course
    ]
  ]
educationLis (x :: x' :: xs) = educationLis [x] ++ educationLis (x' :: xs)

export
cv : Document -> Element General
cv (MkDocument experience education) =
  Div [] [ H2 "Experience"
         , Ul [Classes [NoListIndent]] $ experienceLis experience
         , H2 "Education"
         , Ul [Classes [NoListIndent]] $ educationLis education
         ]
