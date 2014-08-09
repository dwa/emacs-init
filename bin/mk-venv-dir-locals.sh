#!/usr/bin/env bash

venv=$(basename $VIRTUAL_ENV)

[[ ! -e ${VIRTUAL_ENV}/.project ]] && exit 1
proj=$(cat ${VIRTUAL_ENV}/.project)

cat > ${proj}.dir-locals.el <<EOF
((python-mode . ((python-shell-interpreter . "python")
                 (python-shell-interpreter-args . "-m IPython.terminal.ipapp")
                 (python-shell-prompt-regexp . "In \\[[0-9]+\\]: ")
                 (python-shell-prompt-output-regexp . "Out\\[[0-9]+\\]: ")
                 (python-shell-completion-setup-code . "from IPython.core.completerlib import module_completion")
                 (python-shell-completion-module-string-code . "';'.join(module_completion('''%s'''))\n")
                 (python-shell-completion-string-code . "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
                 (python-shell-virtualenv-path . "${VIRTUAL_ENV}")
                 (python-shell-buffer-name . "[iPy] ${venv}"))))
EOF
