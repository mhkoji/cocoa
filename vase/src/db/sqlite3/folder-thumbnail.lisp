(defpackage :vase.db.sqlite3.folder-thumbnail
  (:use :cl :vase.db.sqlite3
        :vase.db.folder-thumbnail)
  (:shadowing-import-from :vase.db.folder-thumbnail :delete)
  (:import-from :cl-arrows :->>))
(in-package :vase.db.sqlite3.folder-thumbnail)

(defmethod insert ((db sqlite3-db) (rows list))
  (->> (mapcar #'list
               (mapcar #'row-folder-id rows)
               (mapcar #'row-thumbnail-id rows))
       (insert-bulk db +folder-thumbnails+
                    (list +folder-id+
                          +thumbnail-id+)))
  db)

(defmethod select ((db sqlite3-db) (ids list))
  (when ids
    (->> (query db
          (join " SELECT"
                " " +folder-id+ ", " +thumbnail-id+
                " FROM"
                " "  +folder-thumbnails+
                " WHERE"
                " " +folder-id+ " in (" (placeholder ids) ")")
          ids)
         (mapcar (lambda (plist)
                   (make-row
                    :folder-id (getf plist :|folder_id|)
                    :thumbnail-id (getf plist :|thumbnail_id|)))))))

(defmethod delete ((db sqlite3-db) folder-ids)
  (delete-bulk db +folder-thumbnails+ +folder-id+ folder-ids)
  db)
