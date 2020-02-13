;;; package --- Summary:

;;; Commentary:
;;; This package is used to "bootstrap" various project scaffolds.

;;; Code:

(defvar *known-frameworks*              ; Frameworks that booti knows how to scaffold.
  '(rails spring-boot))

(defvar *framework-scaffold-commands*
  '((rails #'scaffold-rails)
    (spring-boot #'scaffold-spring-boot)))

(defun scaffold-rails (dir name)
  "Create the scaffolding for Rails project in DIR with NAME."
  (message "Running rails new in %s for %s." dir name))

(defun scaffold-spring-boot (dir name)
  "Create the scaffolding for Spring Boot project in DIR with NAME."
  (message "Creating a new Spring Boot project in %s for %s." dir name))

(defun validate-framework (framework)
  "Used for validation.
This will take in the FRAMEWORK name as a string,
downcase the string and return as a symbol."
  (intern (downcase framework)))

(defun booti (framework dir proj)
  "This is the 'top-level' function.
It will be used to start the bootstrap process.
It takes in FRAMEWORK, DIR, and PROJ in order to create the project scaffold."
  (interactive "sWhat framework would you like to Bootstrap? \nDIn which directory? \nsWhat will the project be called? ")
  (setq framework (validate-framework framework))
  (progn
    (message "The framework you entered was: %s" (symbol-name framework))
    (sit-for 2)
    (message "The directory you choose was: %s" (concat dir proj))
    (sit-for 2)
    (message "The project name was: %s" proj)))


(provide 'booti)
;;; booti.el ends here
