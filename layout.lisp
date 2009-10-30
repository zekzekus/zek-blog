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
    (<:hr)))

