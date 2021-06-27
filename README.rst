Sample Project
==============

This is a sample Python project that has been configured to work with Git SCM and
VSCode, optionally.

Prerequisite
------------

Python 3.x
    Pipfile.Lock and configs reference Python 3.9 and
    will need to be updated if a diffrent version is chosen. 

Git
    Git must be installed. Microsoft Windows user must have Git Bash avaliable
    and add its install location tothe users environment variable PATH.

VS Code
    Microsoft VS Code settings and task have been added to this repo. The use of
    them are not required to use any of the Python project settings. Any IDE
    will be fine, including Vim and a terminal.

VS Code Extensions
------------------

`Coverage Gutters`_
    Viewing coverage XML in the IDE.

`GitLens`_
    Better Git SCM while editing files.

`Prettier - Code formatter`_
    Auto formatting non-Python files. Why shouldn't all files look nice. ;)

`Python`_
    You know ;)

`reStructuredText`_
    Editing and previewing reStructuredText files.

`TOML Language Support`_
    Auto formatting TOML files.

.. _Coverage Gutters: https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters
.. _GitLens: https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens
.. _Prettier - Code formatter: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
.. _python: https://marketplace.visualstudio.com/items?itemName=ms-python.python
.. _reStructuredText: https://marketplace.visualstudio.com/items?itemName=lextudio.restructuredtext
.. _Toml Language Support: https://marketplace.visualstudio.com/items?itemName=be5invis.toml

Contribution Guidelines
-----------------------

All developers are welcome to contribute to this code base. Except in extremely rare
circumstances, all code must abide by the same rules and go through the same peer
review process. This section outlines the expectation of such contributions.

Style Guide
...........

Python is designed to be a multi-paradigm language. This allows for constructs of
different paradigms (e.g. functional, procedural, object oriented) be applied in a 
practical over prescriptive methodology. This is often referred to as a Pythonic
style. Although this style is hard to define with rules, software code written in
this manager almost always adheres to the guidelines in Tim Peters `The Zen of Python`_:

.. _The Zen of Python: https://www.python.org/dev/peps/pep-0020/

Code Formatting
...............

Consistency is key, to ensure this auto-formatters are used whenever possible. 
Black is used for Python, Prettier is used for all other.

Flake8 linters have been configured to enforce best practices when possible. If
a best practice needs to be violated it can be disabled with the ``noqa``
structured comment and must be accompanied by comments explaining the reason.

Docstrings must be included on all public interfaced. Software code should be 
written in a manager that it can be easily followed when reading. This can be
accomplished with using descriptive name for class, function and variables. The
`python-guide`_ offers advice on how to make code more readable. When this is not
possible line comments must be use to clarify the contents.

`Type hinting`_ must be on all functions/methods. `MyPy`_ is used to validate 
usage.

.. _python-guide: https://docs.python-guide.org/writing/style/#access-a-dictionary-element
.. _Type hinting: https://docs.python.org/3/library/typing.html
.. _MyPy: http://mypy-lang.org/

Testing and Coverage
....................

Unit test must be submitted to prove intended functional. For defect related pull
request a test case must be provided proving the defect exists and has been corrected.

Git Commit Style
................

To make revision based source code management tool useful. Time must be put into
creating proper revision history. If a proper history exists it make activity 
such as reviewing, reverting, cherry-picking, rebasing and merging become manageable
and easy. Commits should be submitted in a manager that attempt to tell as story 
about what the changes are intended to do. Repetitive commits MUST be rebased and
squashed. Rebasing history that has been merged with the main branch on GitHub is
forbidden and cannot be accepted.

Git messages can be placed into two types: meaningful and trivial. A meaningful
commit is any commit that edits logic on how the software executes. A trivial
commit is one that make does not edit logic on how the software executes (e.g.
spelling, text in literal, translation, formatting, clean merges). 

Meaningful commits must include a title and a short description at least 2 or 3 
sentences of the change.

Trivial commits only need a title. 

Titles must be limited to 50 characters followed by a blank line. The description
should be broken at 72 characters. These lengths are to accommodate formatting done
by the Git CLI command. Chris Beams have published excellent blog post `How to Write
a Git Commit Message`_. Additionally, title should not contain project ID from 
Jira except in clean merge commits. Jira number maybe include in the short
description but cannot be used to replace the description.

Block tags can be added to the title to help illustrate the intent of the change (e.g.
[Refactor], [Trivial], [Translation]).

.. _`How to Write a Git COmmit Message`: https://chris.beams.io/posts/git-commit/

Repo Utilities
--------------

A repo.sh has been created that allows simple scripting of common activities. These
scripts should limit to the POSIX commands, prerequisite required by this repo and
installed dependenies. Assuming additional commands are avaliable is unwise.

GitHooks
........
Git hooks can be used to enforce coding styles.

pre-commit
    Runs reoi.sh lint

pre-push
    Runs repo.sh test

post-checkout
    Runs repo.sh init