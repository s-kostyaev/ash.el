# Introduction

ash.el is simple integration [ash](https://github.com/seletskiy/ash)
into emacs.

# Setup

Clone this repo. Add path to repo directory into load path & require
into `.emacs`.

```elisp
(add-to-list 'load-path "/path/to/ash/repo")
(require 'ash)
```

# Usage

`M-x ash-inbox <RET>` - open ash inbox.

In new buffer `*ash inbox*` move cursor to pull request url. Now you
may:
- `C-c C-r` or `ash-review` for overview current PR
- `ash-approve` for approve current PR
- `ash-decline` for decline current PR
- `C-c C-l` or `ash-ls` for list of files in current PR in new buffer. In this
buffer you may:
    - `C-c C-f` or `ash-review-file` for review file at point
    - `C-c C-r` or `ash-review` for overview current PR
    - `ash-approve` for approve current PR
    - `ash-decline` for decline current PR
