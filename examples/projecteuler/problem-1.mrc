(def :io (require "io"))
(def :string-conv (require "string-conv"))
(def :integers (require "integers"))
(def :lists (require "lists"))

(def :n (string-conv.parse-int (io.read-line io.stdin) 10))

(def :sum (function [:list] {
  (if (nil? list) { 0 }
    { (+ (head list) (recurse (tail list))) })
}))

(def :include? (function [:n] {
  (if (= (% n 3) 0)
    { true }
    { (if (= (% n 5) 0)
        { true }
        { false }
      ) }
  )
}))

(def :result (sum (lists.filter (integers.range 1 n) include?)))

(print result)
