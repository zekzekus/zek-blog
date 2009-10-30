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
	 :index t)
   (comments :accessor blog-post.comments
	     :initarg :comments
	     :initform (make-pset)))
  (:metaclass persistent-metaclass))

(defmethod add-comment ((self blog-post) (comm comment))
  (insert-item comm (blog-post.comments self)))

(defmethod remove-comment ((self blog-post) (comm comment))
  (remove-item comm (blog-post.comments self)))

(defmethod map-comments (fn (self blog-post))
  (map-pset fn (blog-post.comments self)))

(defmethod comments-as-list ((self blog-post))
  (pset-list (blog-post.comments self)))

(defun add-post (title body)
  (with-transaction ()
    (unless (post-existp title)
      (make-instance 'blog-post :title title :body body))))

(defun get-post-by-title (title)
  (get-instance-by-value 'blog-post 'title title))

(defun post-existp (title)
  (get-post-by-title title))

(defclass comment ()
  ((email :accessor comment.email
	  :initarg :email)
   (body :accessor comment.body
	 :initarg :body))
  (:metaclass persistent-metaclass))

