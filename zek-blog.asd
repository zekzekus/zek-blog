(defpackage :zek-blog-system
  (:use :asdf :common-lisp))

(in-package :zek-blog-system)

(defsystem zek-blog
  :serial t
  :name "zek-blog"
  :depends-on (:ucw :elephant :clsql)
  :components ((:file "packages")
	       (:file "comment" :depends-on ("packages"))
	       (:file "blog-post" :depends-on ("comment"))
	       (:file "models" :depends-on ("blog-post"))
	       (:file "server" :depends-on ("models"))
	       (:file "layout" :depends-on ("server")))) 