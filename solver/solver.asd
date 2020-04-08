;;;; solver.asd

(asdf:defsystem #:solver
  :description "Describe solver here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:queue #:stack #:alexandria)
  :components ((:file "package")
               (:file "solver")))
