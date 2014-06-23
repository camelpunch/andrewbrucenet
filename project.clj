(defproject net.andrewbruce "0.1.0-SNAPSHOT"
  :description "Andrew Bruce's personal website"
  :url "http://www.andrewbruce.net"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [ring/ring-jetty-adapter "1.3.0"]]
  :uberjar-name "andrewbruce-standalone.jar"
  :min-lein-version "2.0.0"
  :main net.andrewbruce
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
