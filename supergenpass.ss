#!/usr/bin/env gxi

(import :std/format
        :ober/oberlib
        :std/pregexp
        :std/text/base64
        :std/crypto/digest
        :std/generic
        :std/generic/dispatch
        :std/sugar
        :std/iter
        )

(def replacements [
                   [ "=" "A" ]
                   [ "+" "9" ]
                   [ "/" "8" ]
                   ])

(def (b64-md5 pickle)
  (let (results (base64-encode (md5 pickle)))
    (for (replacement replacements)
      (set! results (pregexp-replace* (car replacement) results (cadr replacement))))
      results))

(def (sgp-prompt-pass domain)
  "Interactive function to prompt for domain and password and populate paste buffer"
  (display "Master password: ")
  (sgp-generate (read-password ##console-port) domain))

(def (secure-enough results len)
  "Ensure the password we have is sufficiently secure"
  (let ((sub (substring results 0 len)))
    (and
      (> (string-length results) len)
      (pregexp-match "[0-9]" sub)
      (pregexp-match "[A-Z]" sub)
      (pregexp-match "^[a-z]" sub))))

(def (sgp-generate password domain)
  "Create a unique password for a given domain and master password"
  (let ((i 0)
        (results (b64-md5 (format "~a:~a" password domain))))
    (let lp ((results results))
      (set! i (+ 1 i))
      (if (and (> i 9)
               (secure-enough results 10))
        (displayln (substring results 0 10))
        (lp (b64-md5 results))))))

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


