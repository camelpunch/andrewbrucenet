(ns net.andrewbruce.views
  (require [hiccup.core :refer :all]))

(defn cv []
  (html [:h1 "CV"]
        [:p
         [:a {:href "/cv.doc"} "Word format"]]))
