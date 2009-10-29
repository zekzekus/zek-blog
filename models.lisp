(in-package :zek-blog)

(defun init-store ()
  (open-store '(:clsql (:sqlite3 "/home/zekus/devel/zek-blog/data.db"))))

(defclass blog-post ()
  ((title :accessor blog-post.title
	  :initarg :title
	  :initform nil
	  :type string)
   (body :accessor blog-post.body
	 :initarg :body
	 :initform nil
	 :type string))
  (:metaclass persistent-metaclass))