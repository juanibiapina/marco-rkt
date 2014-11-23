#lang marco

(def :filter (function [:list :predicate] {
  (if (nil? list) { nil }
    { (if (predicate (head list))
        { (cons (head list) (filter (tail list) predicate)) }
        { (filter (tail list) predicate) }) })
}))

(def :any (function [:list :f] {
  (if (nil? list) { false } {
    (if (f (head list)) { true } {
      (recurse (tail list) f)
    })
  })
}))

(export [:filter :any])
