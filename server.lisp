(in-package :zek-blog)

(defvar *blog-server* (make-instance 'standard-server 
				     :backend (ucw::make-backend :httpd
								 :host "0.0.0.0"
								 :port 8080)))

(defun start-blog-server ()
  (ucw::startup-server *blog-server*))

(defun stop-blog-server ()
  (ucw::shutdown-server *blog-server*))

(defclass blog-app (standard-application cookie-session-application-mixin)
  ()
  (:default-initargs :url-prefix "/blog/"))

(defparameter *blog-app* (make-instance 'blog-app))

(ucw::register-application *blog-server* *blog-app*)

(ucw::defcomponent zek-window (standard-window-component)
  ()
  (:default-initargs :body (make-instance 'summary)))

(ucw::defentry-point "index.zek" (:application *blog-app*)
    ()
  (call 'zek-window))