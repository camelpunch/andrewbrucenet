module CVGenerator

import Data.Vect

import Site

public export
data Month = January | February | March
           | April   | May      | June
           | July    | August   | September
           | October | November | December
%name Month month

public export
data Date = MkDate Month Integer

Show Date where
  show (MkDate January year) = "Jan " ++ show year
  show (MkDate February year) = "Feb " ++ show year
  show (MkDate March year) = "Mar " ++ show year
  show (MkDate April year) = "Apr " ++ show year
  show (MkDate May year) = "May " ++ show year
  show (MkDate June year) = "Jun " ++ show year
  show (MkDate July year) = "Jul " ++ show year
  show (MkDate August year) = "Aug " ++ show year
  show (MkDate September year) = "Sep " ++ show year
  show (MkDate October year) = "Oct " ++ show year
  show (MkDate November year) = "Nov " ++ show year
  show (MkDate December year) = "Dec " ++ show year

public export
data ToDate = Just Date | Present

Show ToDate where
  show (Just d) = show d
  show Present = "Present"

export
record Position where
  constructor MkPosition
  title : String
  company : String
  location : String
  from : Date
  to : ToDate

%name Position position, position1

export
record Course where
  constructor MkCourse
  school : String
  qualification : String
  field : String
  grade : String
  from : Date
  to : Maybe Date

%name Course course, course1

export
record Document where
  constructor MkDocument
  experience : Vect (S n) Position
  education : Vect (S n) Course

%name Document doc

experienceLis : Vect (S n) Position -> Vect (S n) (Element InList)
experienceLis (position :: []) =
  Li noClass
     [ H3 $ title position
     , H4 $ company position
     , P [ Text $ show (from position) ++ " - " ++ show (to position)
         ]
     ] :: []
experienceLis (x :: x' :: xs) = experienceLis [x] ++ experienceLis (x' :: xs)

educationLis : Vect (S n) Course -> Vect (S n) (Element InList)
educationLis (course :: []) =
  Li noClass
     [ H3 $ qualification course ++ " " ++ field course ++ " at " ++ school course
     ] :: []
educationLis (x :: x' :: xs) = educationLis [x] ++ educationLis (x' :: xs)

export
cv : Document -> Element General
cv (MkDocument experience education) =
  Div noClass [ H2 "Experience"
              , Ul noClass $ experienceLis experience
              , H2 "Education"
              , Ul noClass $ educationLis education
              ]
