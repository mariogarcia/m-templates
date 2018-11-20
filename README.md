## M-TEMPLATES

This package looks for an existent template to create a new file. It's
triggered whenever the user tries to find a non existen file with `C-x
C-f`. Then the user will be prompted to allow create a new buffer with
the correspondant template.

### Installation

First clone the repository:

```
git clone https://github.com/mariogarcia/m-templates.git /path/of/m-templates
```

Then execute:

```elisp
cask package
```

The move the `m-templates-0.0.1.tar` file into your `elpa` directory and execute

```shell
tar xf m-templates-0.0.1.tar
```

Then you can load it manually with `load-library` or loading it
through `init.el`. You can also customize the directory where to find
the templates by setting the 'm-templates-dir' variable. The following
code loads and configures the installed package using
[use-package](https://github.com/jwiegley/use-package)

```elisp
(use-package m-templates
  :ensure t
  :init
  (setq m-templates-dir "/home/mario/Repositories/m-templates/tmpl/")
  (add-hook 'template-file-not-found-hook find-file-not-found-functions))
```

In this configuration the templates directory has been changed by
changing the value of the `m-template-dir` custom variable.

### Usage

Any time you look for an inexistent file using `C-x C-f` Emacs will
check if there's a template matching the end of the full file name
(including extension). If there's a template, then it will use it
to create a new buffer applying that template.

For example, if I'm looking for `HelloWorld.test.js` *m-templates*
will look for a matching template. Because there's `test.js`,
*m-templates* will make use of that template and will create a buffer
called `HelloWord.test.js` with the following content.

### Template variables

At the moment, templates can access the following variables:

- *filename*: the name of the file we want to create
- *classname*: The name of the file without extension
- *package*: in a Java/Groovy project it will try to resolve the
  directory after src/main/[groovy|java] following the maven
  convention
- *author*: system user name
