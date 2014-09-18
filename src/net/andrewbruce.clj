(ns net.andrewbruce
  (:require [ring.adapter.jetty :as jetty]
            [ring.middleware.resource :refer [wrap-resource]]
            [ring.middleware.content-type :refer [wrap-content-type]]
            [ring.middleware.not-modified :refer [wrap-not-modified]]
            [net.andrewbruce.views :as views])
  (:gen-class))

(defn- html [status body]
  {:status status
   :headers {"Content-Type" "text/html"}
   :body body})

(defn pages [req]
  (let [path (:uri req)]
    (cond
     (= "/" path)        (html 200 (views/home))
     (= "/cv" path)      (html 200 (views/cv))
     (= "/contact" path) (html 200 (views/contact))
     :else               (html 404 "<h1>Not Found</h1>"))))

(def app
  (-> pages
      (wrap-resource "public")
      (wrap-content-type)
      (wrap-not-modified)))

(defn -main []
  (jetty/run-jetty app {:port (Integer. (or (System/getenv "PORT") 3000)) :join? false}))
