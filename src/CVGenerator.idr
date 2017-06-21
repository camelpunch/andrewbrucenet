module CVGenerator

import Data.Vect

import Site

data Month = January | February | March
           | April   | May      | June
           | July    | August   | September
           | October | November | December

data Date = MkDate Month Integer

record Position where
  constructor MkPosition
  title : String
  company : String
  location : String
  from : Date
  to : Maybe Date

%name Position position, position1

record Course where
  constructor MkCourse
  school : String
  qualification : String
  field : String
  grade : String
  from : Date
  to : Maybe Date

%name Course course, course1

record Document where
  constructor MkDocument
  experience : Vect (S n) Position
  education : Vect (S n) Course

%name Document doc

experienceLis : Vect (S n) Position -> Vect (S n) (Element InList)
experienceLis (position :: []) =
  Li noClass
     [ H2 $ title position ++ " at " ++ company position
     ] :: []
experienceLis (x :: x' :: xs) = experienceLis [x] ++ experienceLis (x' :: xs)

educationLis : Vect (S n) Course -> Vect (S n) (Element InList)
educationLis (course :: []) =
  Li noClass
     [ H2 $ qualification course ++ " at " ++ school course
     ] :: []
educationLis (x :: x' :: xs) = educationLis [x] ++ educationLis (x' :: xs)

cv : Document -> Element General
cv (MkDocument experience education) =
  Div noClass [ H2 "Experience"
              , Ul noClass $ experienceLis experience
              , H2 "Education"
              , Ul noClass $ educationLis education
              ]
