
(in-package :cl-user)
(defpackage cl-opengl-text-sample-asd
  (:use :cl :asdf))
(in-package :cl-opengl-text-sample-asd)

(defsystem cl-opengl-text-sample
  :depends-on (:cl-opengl :cl-glut :cl-glu :glisph)
  :components (
    (:module "src"
			:around-compile
				(lambda (thunk)
          ; dev
          ; (declaim (optimize (speed 0) (debug 3) (safety 3)))
          ; release
          (declaim (optimize (speed 3) (debug 0) (safety 0)))
					(funcall thunk))
      :components (
        (:file "package")
        (:file "cl-opengl-text-sample")))))

