(ns net.andrewbruce.views
  (:require [hiccup.page :refer [html5]]))

(def menu-items
  [["/" "Home"]
   ["/cv" "CV"]
   ["/contact" "Contact"]
   ["http://blog.andrewbruce.net" "Blog"]])

(def menu
  [:ul.menu (for [[href text] menu-items]
              [:li.menu-item
               [:a.nohist {:href href} text]])])

(defn page [title & content]
  (html5
   [:head
    [:link {:rel "Stylesheet" :type "text/css" :href "/normalize.css"}]
    [:link {:rel "Stylesheet" :type "text/css" :href "/styles.css"}]
    [:title title]]
   [:body [:div.container
           (first content)
           menu
           (rest content)
           [:p [:a {:href "https://github.com/camelpunch/andrewbrucenet"} "Source"]]]]))

(defn home []
  (page "Andrew Bruce: London Software Developer"
        [:h1 "A software person in London"]
        [:p "Here is my face"]
        [:img {:src "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"}]
        [:h2 "Things people usually pay me for"]
        [:ul
         [:li "Test Driven Development (TDD)"]
         [:li "Pair programming and mentoring"]
         [:li "Complaining about what an Agile/XP team is(n't) doing"]
         [:li "Working on CloudFoundry"]
         [:li "Ruby"]
         [:li "JavaScript"]
         [:li "Objective-C"]
         [:li "Swift"]
         [:li "Go"]]
        [:h2 "Things I wish people would pay me for"]
        [:ul
         [:li "Idris"]
         [:li "Haskell"]
         [:li "Elm"]
         [:li "Clojure / ClojureScript"]
         [:li "Teaching them anything I know from the comfort of my home"]]
        [:h2 "Current role"]
        [:p "I'm employed as a software engineer for "
         [:a {:href "http://pivotal.io/"} "Pivotal"]
         ", currently on the CloudOps team."]))

(defn cv []
  (page "Andrew Bruce: CV"
        [:h1 "CV"]
        [:p "I do plan to publish this incredibly interesting work myself one day. Until then there's "
         [:a {:href "https://uk.linkedin.com/in/andrew-bruce-96098682"} "Linkedin"] ", which I'm about ready to quit (again)."]))

(defn contact []
  (page "Andrew Bruce: Contact"
        [:h1 "Contact"]
        [:h2 "Methods"]
        [:p [:a {:href "mailto:me@andrewbruce.net"} "me@andrewbruce.net"]]
        [:p [:a {:href "https://twitter.com/bruciemoose"} "Twitter"]]
        [:p [:a {:href "https://github.com/camelpunch"} "GitHub"]]
        [:h2 "GPG Key"]
        [:p "For sending me encrypted email, files etc."]
        [:pre.gibberish "-----BEGIN PGP PUBLIC KEY BLOCK-----

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
+sOh0TNOrTF5mAJYcFM8Gc3gvNR7SMI=
=Ixwj
-----END PGP PUBLIC KEY BLOCK-----
"])
  )
