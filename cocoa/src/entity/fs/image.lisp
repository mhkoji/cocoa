(defpackage :cocoa.entity.fs.image
  (:use :cl))
(in-package :cocoa.entity.fs.image)
(cl-annot:enable-annot-syntax)

;;; A file representation based on the local file system
@export
(defclass image () ())
@export
(defgeneric image-id (image))
@export
(defgeneric image-path (image))

@export
(defgeneric make-images/paths (factory paths))

@export
(defgeneric save-images (repository images))
@export
(defgeneric list-images/ids (repository ids))
@export
(defgeneric delete-images/ids (repository ids))