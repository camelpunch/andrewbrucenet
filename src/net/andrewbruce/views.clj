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
           (rest content)]]))

(defn home []
  (page "Andrew Bruce: London Software Developer"
        [:h1 "A software person in London"]
        [:p "Andrew is a full-stack software developer."]
        [:img {:src "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"}]
        [:p "Andrew eating breakfast outside, San Francisco, circa 2013."]
        [:h2 "Primary skills"]
        [:ul
         [:li "Test Driven Development (TDD)"]
         [:li "Pair programming and mentoring"]
         [:li "Ruby"]
         [:li "iOS, Objective-C and a bit of Swift."]
         [:li "Clojure / ClojureScript"]
         [:li "Elm"]
         [:li "Haskell"]
         [:li "Go"]
         [:li "JavaScript"]]
        [:h2 "Current role"]
        [:p "I'm employed as a part-time software engineer for "
         [:a {:href "http://pivotal.io/"} "Pivotal"]
         ", currently on the CloudOps team."]
        [:p "This site (except the blog) is "
         [:a {:href "https://github.com/camelpunch/andrewbrucenet/"} "open-source"] " and written in Clojure."]
        [:p "I live on a narrowboat in Hackney, London."]
        [:p "Interested in pro-bono work for a good cause."]
        menu))

(defn cv []
  (page "Andrew Bruce: CV"
        [:h1 "CV"]
        [:p "I've ditched the traditional Word document in favour of "
         [:a {:href "https://uk.linkedin.com/in/andrew-bruce-96098682"} "Linkedin"] "."]))

(defn contact []
  (page "Andrew Bruce: Contact"
        [:h1 "Contact Andrew"]
        [:p [:a {:href "https://twitter.com/bruciemoose"} "Twitter"]]
        [:p [:a {:href "https://uk.linkedin.com/in/andrew-bruce-96098682"} "LinkedIn"]]
        [:p [:a {:href "https://github.com/camelpunch"} "GitHub"]]
        [:p [:a {:href "mailto:website-spamtastic@andrewbruce.net"} "website-spamtastic@andrewbruce.net"]]))
