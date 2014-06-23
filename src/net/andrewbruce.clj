(ns net.andrewbruce
  (:require [ring.adapter.jetty :as jetty])
  (:gen-class))

(defn app [req]
  {:status 200
   :headers {"Content-Type" "text/html"}
   :body "<h1>Andrew Bruce</h1>"})

(defn -main [port]
  (jetty/run-jetty app {:port (Integer. port) :join? false}))

(comment
  (-main 3000)
  )
