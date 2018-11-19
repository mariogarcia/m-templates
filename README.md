## M-TEMPLATES

This package looks for an existent template to create a new file. It's
triggered whenever the user tries to find a non existen file with `C-x
C-f`. Then the user will be prompted to allow create a new buffer with
the correspondant template.

### Installation

First clone the repository:

```
git clone https://github.com/mariogarcia/elisp-playground.git /path/of/elisp-playground
```

Then as it's a simple package, you can install it with:

```elisp
package-install-file /path/of/elisp-playground/packages/m-templates/m-templates.el
```

Then you can load it manually with `load-library` or loading it
through `init.el`

### Configuration

You can customize the directory where to find the templates by setting
the 'm-templates-dir' variable. The following code loading and
configuring the installed package using
[use-package](https://github.com/jwiegley/use-package)

```elisp
(use-package m-templates
  :ensure t
  :init
  (setq m-templates-dir "/home/mario/Repositories/elisp-playground/packages/m-templates/tmpl/")
  (add-hook 'template-file-not-found-hook find-file-not-found-functions))
```

In this configuration the templates directory has been changed by
changing the value of the `m-template-dir` custom variable.
