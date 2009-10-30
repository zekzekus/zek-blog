(in-package :zek-blog)

(defun init-store ()
  (open-store '(:clsql (:sqlite3 "/home/zekus/devel/zek-blog/data2.db"))))
