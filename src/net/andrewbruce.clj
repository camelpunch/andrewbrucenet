(ns net.andrewbruce
  (:require [ring.adapter.jetty :as jetty])
  (:gen-class))

(defn html [status body]
  {:status status
   :headers {"Content-Type" "text/html"}
   :body body})

(defn app [req]
  (let [path (:uri req)]
    (cond
     (= "/" path) (html 200 "<h1>Andrew Bruce</h1>")
     :else        (html 404 "<h1>Not Found</h1>"))))

(defn -main [port]
  (jetty/run-jetty app {:port (Integer. port) :join? false}))

(comment
  (-main 3000)
  )
