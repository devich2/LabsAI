;;;; solver.lisp
;;; State functions
(defun build-record (state parent move) (list state parent move))

(defun get-state (state-tuple)
  (nth 0 state-tuple))

(defun get-parent (state-tuple) (nth 1 state-tuple))

;;Get record by state
(defun retrieve-by-state (state list)
  (cond ((null list) nil)
        ((equal state (get-state (first list))) (first list))
        (t (retrieve-by-state state (rest list)))))


;;; Vessel
(DEFUN is-tranz (from to)
  (and (not ( = (first from) 0))
       (not ( = (first to) (second to)))))

(DEFUN tranz (from to)
  (let* ((temp (first from))
	 (ALLOWED (- (SECOND TO) (FIRST TO)))
	 (ADDED (MIN TEMP ALLOWED )))
    (INCF (first to) ADDED)
    (DECF (first from) ADDED)	  
    ))

;;; Main code

(defparameter *open* nil)
(defparameter *closed* nil)
(defparameter *goal* nil)

(defun solve (start goal struct)
  (setf *open* struct)
  (push-to-open *open* (build-record start nil "no move"))
  (setf *closed* nil)            ;not to recompile, nullify everything
  (setf *goal* goal)
  (solver)                 
  )
  
(defun solver ()
  (cond
    ; open set is empty
    ((= (count-elems *open*) 0) (print "Empty") nil)
    ; else do some...
    (t (let ( (state (pop-open *open*) ))
	     (format T "first node on open = ~s~%" state)
	     ; reassign closed set
	     (push state *closed*)
	     
	     (cond
	     ; if found solution, report
	       ((equal (get-state state) *goal*)
		(format T "length of closed = ~s~%length of open = ~s~%"
			(list-length *closed*) (count-elems *open*))
		(format T "solution path = ~s~%" (build-solution *goal*)))
	       (t
	     ; else generate-states, enqueue them 
		(collect-states state)
	     ; recursive continuation
		(solver))
	       )))))

(DEFUN collect-states (record)
  (let ((parent (get-state record)))
    (alexandria:map-permutations
   (lambda(group) (process-state group parent))
   (range  0 (- (list-length parent) 1))
   :length 2 :copy t )))


(DEFUN process-state(group parent)
  (let* ((copy-state (copy-tree parent))
	 (from-index (first group))
	 (to-index (second group))
	 (from (nth from-index copy-state))
	 (to (nth to-index copy-state)))
    (when (is-tranz from to)	 
	 (tranz from to)
	 (when (not (retrieve-by-state copy-state *closed* ))
	 (push-to-open *open* (build-record copy-state parent "f"))))))


(defun build-solution (state)
  (cond ((null state) nil)
      (t (list state (build-solution
        (get-parent
   (retrieve-by-state state *closed*)))))))

(defun range (ini fim)
    (if (> ini fim)
        (if (eql ini fim)
            (cons fim nil)
            (cons ini (range (- ini 1) fim)))
        
        (if (eql ini fim)
            (cons fim nil)
            (cons ini (range (+ ini 1) fim)))))


(defparameter test-data  '((12 12) (0 5) (0 7)) '( (6 12)  (0 5) ( 6 7)) )

(defun test-stack()
  (solve  test-data (make-instance 'stack)))

(defun test-queue ()
  (solve  test-data (make-instance 'queue)))

(defun test()
  (test-stack)
  (test-queue))
(in-package #:solver)
