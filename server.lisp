(in-package :zek-blog)

(defvar *blog-server* (make-instance 'standard-server 
				     :backend (make-backend :httpd
							    :host "0.0.0.0"
							    :port 8080)))

(defun start-blog-server ()
  (startup-server *blog-server*))

(defun stop-blog-server ()
  (shutdown-server *blog-server*))

(defclass blog-app (standard-application cookie-session-application-mixin)
  ()
  (:default-initargs :url-prefix "/blog/"))

(defparameter *blog-app* (make-instance 'blog-app))

(register-application *blog-server* *blog-app*)

(defcomponent zek-window (standard-window-component)
  ()
  (:default-initargs :body (make-instance 'summary)))

(defentry-point "index.zek" (:application *blog-app*)
    ()
  (call 'zek-window))