(in-package :zek-blog)

(defclass comment ()
  ((email :accessor comment.email
	  :initarg :email)
   (body :accessor comment.body
	 :initarg :body))
  (:metaclass persistent-metaclass))