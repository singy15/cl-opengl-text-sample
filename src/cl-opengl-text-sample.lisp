
(in-package :cl-opengl-text-sample)

(defparameter *width* 400)
(defparameter *height* 400)

;; Variables for GLisph.
(defparameter *font-en* nil)
(defparameter *glyph-table-en* nil)
(defparameter *text-en* #("text drawing sample"))

(defclass main-window (glut:window) 
  ()
	(:default-initargs 
    :title "cl-opengl-text-sample" 
    :mode '(:double :rgb :depth 
						;; Set mode for text drawing.
						:stencil :multisample) 
    :width *width* 
    :height *height*))


(defmethod glut:idle ((window main-window))
  (glut:post-redisplay))

(defmethod glut:reshape ((w main-window) width height)
  (gl:viewport 0 0 width height)
  (gl:load-identity)
  (glu:ortho-2d 0.0 *width* *height* 0.0))

(defmethod glut:display ((window main-window))
  (gl:shade-model :flat)
  (gl:normal 0 0 1)

	;; Draw text
  (gl:clear-stencil 0)
  (gl:clear :color-buffer-bit :stencil-buffer-bit)
  (gli:gcolor 1.0 1.0 1.0 1.0)
  (gli:render *text-en*)

  (glut:swap-buffers))

(defmethod glut:display-window :before ((window main-window))
	;; Initialize GLisph.
  (gli:init *width* *height*)
  (setf *font-en* (gli:open-font-loader #p"./font/Ubuntu-R.ttf"))
  (setf *glyph-table-en* (gli:make-glyph-table *font-en*))
  (loop for text across *text-en*
        do (gli:regist-glyphs *glyph-table-en* text))
  (setf *text-en*
        (gli:draw *glyph-table-en*
                  '(:size 20 :x 0 :y 0 :text (aref *text-en* 0)))))

(defmethod glut:close ((w main-window))
	;; Delete glyph table and finalize GLisph.
  (gli:delete-glyph-table *glyph-table-en*)
  (gli:finalize))

(defun main ()
  (glut:display-window (make-instance 'main-window)))

(in-package :cl-user)

