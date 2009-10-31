(in-package :zek-blog)

(ucw::defcomponent summary ()
  ((posts :accessor summary.posts
	  :initarg :posts
	  :initform (get-instances-by-class 'blog-post))))

(defmethod ucw::render ((self summary))
  (<:h1 "All posts")
  (dolist (post (summary.posts self))
    (<:h2 (<:as-html (blog-post.title post)))
    (<:p (<:as-html (blog-post.body post)))
    (<:as-html "Comments: " (comment-count post)) (<:br)
    (<ucw:a :action (post-detail self post) "Detail")
    (<:hr)))

(defaction post-detail ((self summary) post)
  (call 'detail :post post))

(ucw::defcomponent detail ()
  ((post :accessor detail.post
	 :initarg :post)))

(defmethod ucw::render ((self detail))
  (<:a :href "/blog/index.zek" "<<Home")
  (<:h1 (<:as-html (blog-post.title (detail.post self))))
  (<:p (<:as-html (blog-post.body (detail.post self))))
  (<ucw:a :action (edit-blog self) "Edit Post")
  (when (have-comments? (detail.post self))
    (<:h3 "Comments:")
    (dolist (comment (comments-as-list (detail.post self)))
      (<:strong (<:as-html (comment.email comment)))
      (<:p (<:as-html (comment.body comment)))
      (<:hr))))

(defaction edit-blog ((self detail))
  (call 'edit-form :post (detail.post self)))

(ucw::defcomponent edit-form ()
  ((post :accessor edit-form.post
	 :initarg :post)))

(defmethod ucw::render ((self edit-form))
  (<:a :href "/blog/index.zek" "<<Home"))
