;;; -*- Gerbil -*-
;;; © ober 2022
;;; Supergenpass client binary


(import :std/format
        :ober/oberlib
        :std/pregexp
        :std/text/base64
        :std/crypto/digest
        :std/generic
        :std/generic/dispatch
        :std/sugar
        :std/iter
        :ober/supergenpass/client
        )

(export main)

(def program-name "supergenpass")

(def (usage)
  (displayln "supergenpass <domain>")
  (exit 2))

(def (main . args)
  (if (null? args)
    (usage))
  (let (argc (length args))
    (if (= argc 1)
      (sgp-prompt-pass (car args))
      (usage))))


