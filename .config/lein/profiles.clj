{:user
 {:local-repo #=(eval (str (System/getenv "XDG_CACHE_HOME") "/m2"))
  :repositories  {"local" {:url #=(eval (str "file://" (System/getenv "XDG_DATA_HOME") "/m2"))
                           :releases {:checksum :ignore}}}}
 {:dependencies [[org.clojure/tools.namespace "1.0.0"]
                 [spyscope "0.1.6"]
                 [criterium "0.4.5"]]
  :injections [(require '(clojure.tools.namespace repl find))
                     ; try/catch to workaround an issue where `lein repl` outside a project dir
                     ; will not load reader literal definitions correctly:
               (try (require 'spyscope.core)
                    (catch RuntimeException e))]
  :plugins [[lein-pprint "1.3.2"]
            [lein-clojars "0.9.1"]
            [lein-create-template "0.2.0"]
            [lein-marginalia "0.9.1"]
            [lein-exec "0.3.7"]
            [lein-midje "3.2.2"]
            [lein-kibit "0.1.8"]
            [lein-ancient "0.6.15"]]}}