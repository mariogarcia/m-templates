;;; unit-test.el --- Unit testing

;;; Commentary:
;;; Code:
(require 'm-templates)

;; TESTS
(ert-deftest test-template-insert-package ()
  (should (equal (template-insert-package "/home/x/A.java") ""))
  (should (equal (template-insert-package "/home/x/A.groovy") ""))
  (should (equal (template-insert-package "/home/x/src/main/java/io/xxx/A.java") "package io.xxx"))
  (should (equal (template-insert-package "/home/x/src/main/groovy/io/xxx/A.groovy") "package io.xxx")))

(ert-deftest test-resolve-jvm-package ()
  (should (equal (resolve-jvm-package "java" "/a/b/c/src/main/java/io/xxx/core") "package io.xxx.core"))
  (should (equal (resolve-jvm-package "java" "/a/b/c/src/main/java/io/xxx/core/") "package io.xxx.core")))

(provide 'unit-test)
;;; unit-test.el ends here
