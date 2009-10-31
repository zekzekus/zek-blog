(in-package :zek-blog)

(ucw::defcomponent summary ()
  ((posts :accessor summary.posts
	  :initarg :posts
	  :initform (get-instances-by-class 'blog-post))))

(defmethod ucw::render ((self summary))
  (<:h1 "Summary of posts")
  (dolist (post (summary.posts self))
    (<:h2 (<:as-html (blog-post.title post)))
    (<:p (<:as-html (blog-post.body post)))
    (<:as-html "Yorum: " (comment-count post)) (<:br)
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
  (<:h3 "Yorumlar:")
  (dolist (comment (comments-as-list (detail.post self)))
    (<:strong (<:as-html (comment.email comment)))
    (<:p (<:as-html (comment.body comment)))
    (<:hr)))