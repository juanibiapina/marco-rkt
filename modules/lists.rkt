#lang marco

(def :filter (function [:list :predicate] {
  (if (nil? list) { nil }
    { (if (predicate (head list))
        { (cons (head list) (filter (tail list) predicate)) }
        { (filter (tail list) predicate) }) })
}))

(export [:filter])
