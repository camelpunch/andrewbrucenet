module Index

import Mrk

import Classes
import Layout

%default total

export
index : Document Root
index = page "Andrew Bruce: A software person" "A software person" $ do
  p "Here is my face."
  img "https://pbs.twimg.com/profile_images/422231524897878016/u4fu2WH-_400x400.jpeg"
      "I'm wearing silly glasses and a pink wig, in a wedding photo booth thingy."
  h2 "Blog posts"
  ul $ do
    li $ do
      a (Just "https://pivotal.io/search?utf8=%E2%9C%93&q=andrew+bruce") "Whilst at Pivotal"
    li $ do
      a (Just "https://medium.com/@andrewofbruce") "On Medium"
  h2 "Things people usually pay me for."
  ul $ do
    li "Test Driven Development (TDD)"
    li "Pair programming and mentoring"
    li "DevOpsy things like Cloud Foundry and Kubernetes"
    li "Kotlin"
    li "Ruby"
    li "JavaScript"
    li "Objective-C"
    li "Swift"
    li "Go"
  h2 "Things I wish people would pay me for, but they probably shouldn't."
  ul $ do
    li "Idris"
    li "Haskell"
    li "Elm"
    li "Clojure / ClojureScript"
  h2 "Current role"
  p $ do
    text "I do consultancy through "
    a (Just "https://code.supply/") "Code Supply"

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
