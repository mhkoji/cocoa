(defpackage :cocoa.use-case.folder.images
  (:use :cl :cocoa.entity.folder))
(in-package :cocoa.use-case.folder.images)
(cl-annot:enable-annot-syntax)

(defun safe-subseq (seq from size)
  (let* ((start (or from 0))
         (end (when (numberp size)
                (min (length seq) (+ size start)))))
    (subseq seq start end)))

(defmacro ensure-integer! (var default)
  `(progn
     (when (stringp ,var)
       (setq ,var (parse-integer ,var :junk-allowed t)))
     (when (null ,var)
       (setq ,var ,default))))

(defun content->image-dto (content)
  (list :id (cocoa.use-case.folder.content:content->image-id content)))

;;; folder images
@export
(defun list-images (folder-id &key from size folder-repository)
  ;@type! folder-id !integer
  ;@type! from integer 0
  ;@type! size integer 100
  ;@type! folder-repository !folder-repository
  (ensure-integer! from 0)
  (ensure-integer! size 100)
  (let* ((folder (car (list-folders/ids folder-repository
                                        (make-list-spec)
                                        (list folder-id))))
         (contents (safe-subseq (folder-contents folder) from size)))
    (mapcar #'content->image-dto contents)))