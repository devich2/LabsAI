;;;; stack.lisp
;;; Stack
(DEFCLASS STACK ()
  ((STACK-ELEMS :ACCESSOR ELEMS
		:initarg :elems
		:INITFORM '()))
  )

(DEFMETHOD push-to-open ((ST STACK) &REST ARGS)
  "THIS PUSHES ANY NUMBER OF ARGUMENTS TO THE STACK."
  (DOLIST (ARG ARGS)
    (PUSH ARG (ELEMS ST))))

(DEFMETHOD peek-open ((ST STACK))
  (FIRST (ELEMS ST)))

(DEFMETHOD pop-open ((ST STACK))
  (POP (ELEMS ST)))

(DEFMETHOD count-elems ((ST STACK))
  (list-length (elems st)))

(in-package #:stack)
