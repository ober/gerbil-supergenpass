#!/usr/bin/env gxi
;; -*- Gerbil -*-

(import :std/build-script)

(defbuild-script
  '("supergenpass/client"
    (static-exe:
     "supergenpass/supergenpass"
     "-cc-options"
     "-I/usr/pkg/include"
     "-ld-options"
     "-lpthread -lyaml -lssl -lz -L/usr/lib64 -L/usr/pkg/lib")))
