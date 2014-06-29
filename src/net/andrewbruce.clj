(ns net.andrewbruce
  (:require [ring.adapter.jetty :as jetty]
            [ring.util.response :refer [redirect]]
            [ring.middleware.content-type :refer :all]
            [ring.middleware.not-modified :refer :all]
            [net.andrewbruce.views :as views])
  (:gen-class))

(defn- html [status body]
  {:status status
   :headers {"Content-Type" "text/html"}
   :body body})

(defn app [req]
  (let [path (:uri req)]
    (cond
     (= "/" path)        (html 200 (views/home))
     (= "/cv" path)      (html 200 (views/cv))
     (= "/contact" path) (html 200 (views/contact))
     :else               (html 404 "<h1>Not Found</h1>"))))

(defn -main [port]
  (jetty/run-jetty app {:port (Integer. port) :join? false}))
