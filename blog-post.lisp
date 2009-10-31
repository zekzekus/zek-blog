(in-package :zek-blog)

(defclass blog-post ()
  ((title :accessor blog-post.title
	  :initarg :title
	  :type string
	  :index t)u
   (body :accessor blog-post.body
	 :initarg :body
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

(defmethod have-comments? ((self blog-post))
  (slot-boundp self 'comments))

(defmethod map-comments (fn (self blog-post))
  (when (have-comments? self)
    (map-pset fn (blog-post.comments self))))

(defmethod comments-as-list ((self blog-post))
  (if (have-comments? self)
      (pset-list (blog-post.comments self))
      '()))

(defun comment-count (blog-post)
  (if (have-comments? blog-post)
      (length (comments-as-list blog-post))
      0))

(defun add-post (title body)
  (with-transaction ()
    (unless (post-existp title)
      (make-instance 'blog-post :title title :body body))))

(defun add-post-with-comment (title body email comment)
  (with-transaction ()
    (unless (post-existp title)
      (let ((tmp-post (make-instance 'blog-post :title title :body body)))
	(add-comment tmp-post (make-instance 'comment :email email :body comment))))))

(defun get-post-by-title (title)
  (get-instance-by-value 'blog-post 'title title))

(defun post-existp (title)
  (get-post-by-title title))