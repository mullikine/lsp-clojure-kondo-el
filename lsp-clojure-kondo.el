;;; lsp-clojure-kondo.el --- Clojure Kondo support for lsp-mode -*- lexical-binding: t -*-
(require 'lsp-mode)

(defcustom lsp-clojure-kondo-executable-path "clojure-kondo-lsp"
  "Path to Clojure Kondo executable."
  :group 'lsp-clojure-kondo
  :type 'string)

(defcustom lsp-clojure-kondo-server-args '()
  "Extra arguments for the Clojure Kondo language server."
  :group 'lsp-clojure-kondo
  :type '(repeat string))

(defun lsp-clojure-kondo--server-command ()
  "Generate the language server startup command."
  `(,lsp-clojure-kondo-executable-path
    ;; "--lib"
    ;; "clojure-kondo-langserver"
    ,@lsp-clojure-kondo-server-args))

(defvar lsp-clojure-kondo--config-options `())

(lsp-register-client
 (make-lsp-client :new-connection
                  (lsp-stdio-connection 'lsp-clojure-kondo--server-command)
                  :major-modes '(clojure-kondo-mode)
                  :server-id 'clojure-kondo
                  :initialized-fn (lambda (workspace)
                                    (with-lsp-workspace workspace
                                      (lsp--set-configuration
                                       `(:clojure-kondo ,lsp-clojure-kondo--config-options))))))

(provide 'lsp-clojure-kondo)
;;; lsp-clojure-kondo.el ends here