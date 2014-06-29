(ns net.andrewbruce-test
  (:require [clojure.test :refer :all]
            [ring.mock.request :refer :all]
            [net.andrewbruce :refer :all]
            [clojure.tools.namespace.repl :refer [refresh]]))

(comment (refresh))

(deftest homepage
  (testing "has content"
    (is (re-find #"Andrew Bruce"
                 (:body (app (request :get "/"))))))

  (testing "404s with bogus path"
    (is (= 404
           (:status (app (request :get "/non-existent")))))))

(deftest cv
  (testing "has link to linkedin resume"
    (is (re-find #"<a href=\"http://resume.linkedinlabs.com/dd7nxad1s\">"
                 (:body (app (request :get "/cv")))))))

(deftest contact
  (testing "gives out my address"
    (is (re-find #"<a href=\"mailto:website-spamtastic@andrewbruce.net"
                 (:body (app (request :get "/contact")))))))
