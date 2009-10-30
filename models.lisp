(in-package :zek-blog)

(defun init-store ()
  (open-store '(:clsql (:sqlite3 "/home/zekus/devel/zek-blog/data2.db"))))

(defclass blog-post ()
  ((title :accessor blog-post.title
	  :initarg :title
	  :initform nil
	  :type string
	  :index t)
   (body :accessor blog-post.body
	 :initarg :body
	 :initform nil
	 :type string
	 :index t))
  (:metaclass persistent-metaclass))

(defun add-post (title body)
  (with-transaction ()
    (unless (post-existp title)
      (make-instance 'blog-post :title title :body body))))

(defun get-post-by-title (title)
  (get-instance-by-value 'blog-post 'title title))

(defun post-existp (title)
  (get-post-by-title title))
