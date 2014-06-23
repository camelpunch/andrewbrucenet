(ns net.andrewbruce-test
  (:require [clojure.test :refer :all]
            [ring.mock.request :refer :all]
            [net.andrewbruce :refer :all]))

(deftest homepage
  (testing "has content"
    (is (re-find #"Andrew Bruce" (:body (app (request :get "/"))))))

  (testing "404s with bogus path"
    (is (= 404 (:status (app (request :get "/non-existent")))))))

(deftest redirect-to-www
  (is (= "http://www.andrewbruce.net/someplace"
         ((:headers (app (assoc (request :get "/someplace")
                           :server-name "andrewbruce.net")))
          "Location"))))
