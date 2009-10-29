(defpackage :zek-blog-system
  (:use :asdf :common-lisp))

(in-package :zek-blog-system)

(defsystem zek-blog
  :serial t
  :name "zek-blog"
  :depends-on (:ucw :elephant :clsql)
  :components ((:file "packages")
	       (:file "models" :depends-on ("packages")))) 