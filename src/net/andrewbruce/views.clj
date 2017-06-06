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
        [:pre.gibberish "
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
sUyq1VYdgnOhJoP91xFCFA==
=25+t
-----END PGP PUBLIC KEY BLOCK-----
"])
  )
