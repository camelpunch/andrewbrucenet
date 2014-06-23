(ns net.andrewbruce
  (:require [ring.adapter.jetty :as jetty]
            [ring.util.response :refer [redirect]])
  (:gen-class))

(defn html [status body]
  {:status status
   :headers {"Content-Type" "text/html"}
   :body body})

(defn non-www-host [req]
  (re-find #"^andrewbruce.net" (:server-name req)))

(defn app [req]
  (let [path (:uri req)]
    (cond
     (non-www-host req) (redirect (str "http://www.andrewbruce.net" (:uri req)))

     (= "/" path) (html 200 "<h1>Andrew Bruce</h1>")
     :else        (html 404 "<h1>Not Found</h1>"))))

(defn -main [port]
  (jetty/run-jetty app {:port (Integer. port) :join? false}))
