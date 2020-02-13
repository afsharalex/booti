;;; package --- Summary:

;;; Commentary:
;;; This package is used to "bootstrap" various project scaffolds.

;;; Code:

(defvar *known-frameworks*              ; Frameworks that booti knows how to scaffold.
  '(rails spring-boot))

;;; TODO: It may be smarter to use a macro to actually generate the function
;;; storing some logic, or parameters in a assoc list.
(defvar *framework-scaffold-commands*
  '((rails #'scaffold-rails)
    (spring-boot #'scaffold-spring-boot)))

(defun scaffold-rails (dir name)
  "Create the scaffolding for Rails project in DIR with NAME."
  (if  (executable-find "rails")
      ;; TODO: Run command async.
      (shell-command (concat "rails new " dir name))
      (message "rails command not found.")))

(defun scaffold-spring-boot (dir name)
  "Create the scaffolding for Spring Boot project in DIR with NAME."
  (message "Creating a new Spring Boot project in %s for %s." dir name))

(defmacro generate-scaffold-function (name)
  "Takes NAME for framework or language. If exists, will return its corresponding scaffold function."
  `(intern (concat "scaffold-" (symbol-name ,name))))

(defun validate-framework (framework)
  "Used for validation.
This will take in the FRAMEWORK name as a string,
downcase the string and return as a symbol."
  (intern (downcase framework)))

(defun booti (framework dir proj)
  "This is the 'top-level' function.
It will be used to start the bootstrap process.
It takes in FRAMEWORK, DIR, and PROJ in order to create the project scaffold."
  ;; Get the framework name, directory, and project name.
  (interactive "sWhat framework would you like to Bootstrap? \nDIn which directory? \nsWhat will the project be called? ")
  ;; Validate the framework name.
  (setq framework (validate-framework framework))
  ;; Check if the framework is known.
  (let ((fn (cdr (assoc framework *framework-scaffold-commands*))))
    (if fn
  ;; if known, call its scaffold function.
        (funcall (generate-scaffold-function framework) dir proj)
      (message "Framework %s not found." framework))))


(provide 'booti)
;;; booti.el ends here
