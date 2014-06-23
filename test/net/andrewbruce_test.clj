(ns net.andrewbruce-test
  (:require [clojure.test :refer :all]
            [net.andrewbruce :refer :all]))

(deftest homepage

  (testing "has content"
    (is (re-find #"Andrew Bruce" (:body (app {:uri "/"})))))

  (testing "404s with bogus path"
    (is (= 404 (:status (app {:uri "/non-existent"}))))))
