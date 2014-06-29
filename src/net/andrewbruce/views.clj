(ns net.andrewbruce.views
  (require [hiccup.page :refer [html5]]))

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
  (page "Andrew Bruce: Software Developer"
        [:h1 "A software developer"]
        [:p "This is Andrew's personal web site. It contains boring information about Andrew."]
        [:img {:src "http://airpair-blog.s3.amazonaws.com/wp-content/uploads/2013/12/pivot-andrew-bruce.jpg"}]
        [:p "This is what Andrew looks like when he eats."]
        [:h2 "Computers"]
        [:p "I like computers. I got into computers, and later the web, at an early age ("
         [:a {:href "http://en.wikipedia.org/wiki/Amiga"} "Amiga"] " generation). "
         "Naturally, this led me to apply to study Philosophy at "
         [:a {:href "http://www.corpus.cam.ac.uk"} "university"] "."]
        [:p "Instead of studying that, however, I spent most of my 'self-study' time making hate sites about my friends in PHP."]
        [:p "But don't worry: I got out. "
         "After a short stint as a PHP developer, I began "
         [:a {:href "http://en.wikipedia.org/wiki/Test-driven_development"} "test-driving"]
         " Ruby applications in an "
         [:a {:href "http://en.wikipedia.org/wiki/Extreme_programming"} "XP"] " environment in 2006 at "
         [:a {:href "http://www.serverchoice.com"} "ServerChoice"] "."]
        [:p "Since then I've put in over four years of test-driven, "
         [:a {:href "http://en.wikipedia.org/wiki/Pair_programming"} "pair-programmed"]
         " work and another four years as a solo, TDD" "ing contractor."]
        [:p "I worked on and off for BBC radio on their "
         [:a {:href "http://www.bbc.co.uk/music/introducing/uploader"} "Introducing Uploader project"]
         ". Alas, some of that involved PHP."]
        [:p "I worked as a consultant for two and a half years at "
         [:a {:href "http://pivotallabs.com/author/abruce/"} "Pivotal Labs"]
         " in San Francisco, working on seven projects. I anchored, or led, three of these teams."]
        [:p "I wrote some Objective-C for iOS there, but mostly Ruby, JavaScript and CSS."]
        [:p "In 2014, our family returned to the UK for various reasons, not least of which was the US immigration system, which is stupid."]
        [:h2 "What's next"]
        [:p "I've become very interested in working with functional languages, and "
         [:a {:href "http://clojure.org"} "Clojure"] " in particular."]
        [:p "This site (except the blog) is "
         [:a {:href "https://github.com/camelpunch/andrewbrucenet/"} "open-source"] " and written in Clojure."]
        [:p "I'd be interested in "
         [:a {:href "/contact"} "hearing about"] " contract and freelance work, especially if it's remote or part-time."]
        [:p "In case you're wondering, the websites I get paid for don't look like this."]
        menu))

(defn cv []
  (page "Andrew Bruce: CV"
        [:h1 "CV"]
        [:p "I've ditched the traditional Word document in favour of a "
         [:a {:href "http://resume.linkedinlabs.com/dd7nxad1s"} "Linkedin-generated resume"] "."]))

(defn contact []
  (page "Andrew Bruce: Contact"
        [:h1 "Contact Andrew"]
        [:p "Send me an email. I can send you my number if we get along."]
        [:p [:a {:href "mailto:website-spamtastic@andrewbruce.net"} "website-spamtastic@andrewbruce.net"]]))
