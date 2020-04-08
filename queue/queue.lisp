;;;; queue.lisp
;;; Queue
(defclass queue ()
  ((queue-elems :accessor elems :initform '()))
  )

(defmethod push-to-open ((q queue) &rest args)
  "This pushes any number of arguments to the queue."
  (dolist (arg args)
   (setf (elems q) (nconc (elems q ) (list arg)))))

(DEFMETHOD peek-open ((q queue))
  (first (elems q)))

(DEFMETHOD pop-open ((q queue))
  (pop (elems q)))

(DEFMETHOD count-elems ((q queue))
  (list-length (elems q)))

(in-package #:queue)
