module CVGenerator

import Data.Vect

import Mrk

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
  show Present = "present"

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

%name CVGenerator.Document doc

strPara : String -> Element Li
strPara str = Generic P [] (Text str)

showPara : Show a => a -> Document Li
showPara = tell . strPara . show

toParas : String -> Document Li
toParas text =
  tell $ toParas' text where
  toParas' : String -> Element Li
  toParas' t =
    foldl (\acc, elem =>
      acc <+> strPara elem
    ) neutral $
    filter (/= "") (lines t)

data CVClass
  = NoBullet
  | NoListIndent

AttributeValue CVClass where
  toAttr NoBullet = "cv-item"
  toAttr NoListIndent = "cv-section"

experienceLis : Vect (S n) Position -> Document Ul
experienceLis (position :: []) = do
  li [ClassNames [NoBullet]] $ do
    h3 $ title position
    h4 $ company position ++ " (" ++ location position ++ ", " ++ show (period position) ++ ")"
    (toParas (description position))
experienceLis (x :: x' :: xs) = do
  experienceLis [x]
  experienceLis (x' :: xs)

educationLis : Vect (S n) Course -> Document Ul
educationLis (course :: []) =
  li [ClassNames [NoBullet]] $ do
    h3 $ school course
    h4 $ qualification course ++ ", " ++ field course ++ ", " ++ grade course
    showPara $ period course
educationLis (x :: x' :: xs) = do
  educationLis [x]
  educationLis (x' :: xs)

export
cv : Document -> Document Div
cv (MkDocument experience education) = do
  div $ do
    h2 "Experience"
    ul [ClassNames [NoListIndent]] $
      experienceLis experience
    h2 "Education"
    ul [ClassNames [NoListIndent]] $
      educationLis education

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
