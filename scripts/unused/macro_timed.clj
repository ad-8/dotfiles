(ns macro-timed)

(defmacro timed 
  "Like the time macro, but also prints the name of the measured function."
  [expr]
  (let [sym (= (type expr) clojure.lang.Symbol)]
    `(let [start# (. System (nanoTime))
           return# ~expr
           res# (if ~sym  
                    (resolve '~expr)  
                    (resolve (first '~expr)))]
       (prn (str "Timed "
           (:name (meta res#))
           ": " (/ (double (- (. System (nanoTime)) start#)) 1000000.0) " msecs"))
       return#)))

(defmacro get-funtion-name
  [expr]
  (prn (:name (meta (resolve expr)))))

(defmacro better-get-funtion-name
  [expr]
  (let [sym (= (type expr) clojure.lang.Symbol)]
    (prn (:name (meta (if sym
                        (resolve expr)
                        (resolve (first expr))))))))

(defn foo [x]
  (Thread/sleep 1000)
  (identity x))

(comment
  (get-funtion-name /)
  ; doesnt work because we’re passing a list into our macro rather than just a single symbol
  (get-funtion-name (/ 3 4))
  
  (better-get-funtion-name /)
  (better-get-funtion-name (/ 3 4))

  (timed (+ 1 2))
  (timed (foo "bar"))
  (time (foo "bar"))
  ;;
  )

