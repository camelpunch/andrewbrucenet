(ns net.andrewbruce-test
  (:require [clojure.test :refer :all]
            [ring.mock.request :refer :all]
            [net.andrewbruce :refer :all]))

(deftest homepage
  (testing "has content"
    (is (re-find #"Andrew Bruce"
                 (:body (app (request :get "/"))))))

  (testing "404s with bogus path"
    (is (= 404 (:status (app (request :get "/non-existent")))))))

(deftest cv-html
  (testing "has link to Word format"
    (is (re-find #"<a href=\"/cv.doc\">"
                 (:body (app (request :get "/cv")))))))

(deftest redirect-to-www
  (testing "preserves path"
    (is (= "http://www.andrewbruce.net/someplace"
           ((:headers (app (assoc (request :get "/someplace")
                             :server-name "andrewbruce.net")))
            "Location"))))
  (testing "uses 301 code"
    (is (= 301
           (:status (app (assoc (request :get "/someplace")
                           :server-name "andrewbruce.net")))))))
