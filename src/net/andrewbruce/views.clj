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

mQENBFkU6fIBCAC0GCLqUo7BpDG55g3xmwaYUGlMfKU4FpiDPzDGkx43DLn7Mxjq
2oKbqKHlb4GHAabV+NnLF2wsnoS/8nVvWXsEQ42JInE1trYNcdEnte0n9HkLwdt7
V9AhAbhEFWo0Ka1AO9WGQahshpWawoQfaFqY+NV2a2wwMe1Yr0Aox9kRfovFOjfo
ivphvGYS11ngMdSxMFf8+ecRDIDT5wBNyo9H2elUNDE/oApZp1kdAAO55gBwTb1L
b0Ba5BWwqkCfu+a+q9F5MZHaglfLgKmqjTTT6sNe7WWfIdiiWaGXVu9xZQNGE2Vv
YcC0HgXhKdJyLEnvKADFOt7O2QeqNH7LEQM/ABEBAAG0IUFuZHJldyBCcnVjZSA8
bWVAYW5kcmV3YnJ1Y2UubmV0PokBNwQTAQgAIQUCWRTp8gIbAwULCQgHAgYVCAkK
CwIEFgIDAQIeAQIXgAAKCRBCafDgcpBHkCUpCACQJ4UxYNfrRlPSTeZ7ZeM9w5Qv
mOUxu4MG2kznbvRkbfb86FXC15rpydGWMKdG95aXvX9sQlDoOixqkXYpnqCRJloW
WbVj8e8UjxIDLDVSB+oEP3KvEJHaJw9kgfkBjS94G9O54AhGxhm8wcqRNV3uBAY8
zZNjeL4xwlbYML62WimIyY+lVQzSKK9zGObEfuLQGDhajLftyxcdP1zc5FBWt+fX
O0a9Qrnme4e4fKjbaNHS19Jv7dpjOsvvad91K3GzCVdDq6qjSN5rRble8zmuswyw
3mVXmkTnj2rqSs7vgXX7GdEOzXwp7xeMMLe2HSWReee9qGq1hymDKzUyWcI8uQEN
BFkU6fIBCAC+rnMNNq86H5UxtlhyqaLU7QCGBccBVXZpK/l8K9rq6MN6VxtARQ2F
02e8g8FFCCylG2bgQb72PvOyJBcYWZ7ZR0oSfFfH0lo+Y9g+eWAnSPQx8K9p57Lu
03Y868SGCz1FbtACUm/kybQCs2Dk1G+yex5Ua8Nod4t1XdzcG3rZKlXa+YXuKvvB
tZWArEvarz9fQlbqSO8h2iH3HrVgsge9z7nbV2UHAAudrSOKyIZ5z8BAcFkrppAu
UM5tjlw2AaoW3CXiJ9pAh/nRy+DFE4TFjp533Rpswo4ySXCFYFzt7q792NFaDB6y
tpOak07RJ/6yq8VUHirr46msOCizQEklABEBAAGJAR8EGAEIAAkFAlkU6fICGwwA
CgkQQmnw4HKQR5A3QAf/eWplbWTEmMzNnnykyBEvf5fN5krJ1yzoImx7TWplHXsA
8c6+EfSAIB1LubpRyxlxnTM9TPo/E0TJnTh0H7SN4rzwHeBY4aKx0aP4XBc5aYVj
xMZT1aCyPvWYiWX6u/QVl8qOXUqnnq86ycmQ4rqX5idgWeGOgZYNQBDy9Hw+Lo18
cAZPBxodPHV2nOX7e67AmEmD/qxScno0Kd+J6Qy7ifR2ljwz26hpH2+xftOugbcZ
d3L2M6VIIwHw5rkl19Iycu+q3uOPtpS9NOAfVj+wL80gsYLgjvGIDmC6q+9+AJHS
H2znugHdGF1Wj32htAvec2Q04x6YM9TINYm+D+OH+w==
=Jefb
-----END PGP PUBLIC KEY BLOCK-----
"])
  )
