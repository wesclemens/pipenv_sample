#/bin/bash
#
# Helper scirpt for repo. This script contains common commands/processes that
#  developers use in this software repo.
#
# Usage:
#   $0 [-h] [COMMANDS ...]
#
# Sub-Command:
#   init: Creates/Updates virtual environment and githooks
#   format: Auto-format code
#   lint: Check code for common errors
#   test: Exeuctes unittest and typechecks
#   package: Builds package
#   publish: Pushes package to PyPI repo
set -euo pipefail # strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/

PIPENV_CMD=pipenv

# We should never need software from the internet
unset https_proxy http_proxy


function usage {
    # Prints usage and forces exit with return code 1

    # Wills magic usage. This line parses the block comment at the top of the script
    # and prints it as usage.
    sed -e '1d' -e '/^[^#]/,$d' -e 's/^#//' -e "s/\\\$0/$(basename $0)/" $0
    exit 1
}


function parse_args() {
    # Parses optional arguments and prints new argument string with options removed
    local opt OPTIND OPTARG
    while getopts ":h" opt
    do
        case "$opt" in
            h) 2>&2 usage ;;
            :)
                1>&2 echo "ERROR: Option -$OPTARG requires an argument."
                usage
                ;;
            \?)
                1>&2 echo "ERROR: Invalid option -$OPTARG"
                usage
                ;;
        esac
        shift $((OPTIND - 1))
    done

    if [[ -z "$@" ]]; then
        usage
    fi
    echo $@
}


function bootstrap {
    # Checks for required commands. Attempts to install if missing.
    # Git assume as repo was closed somehow.
    if ! command -v pipenv &>/dev/null && ! python -m pipenv &>/dev/null; then
        echo "Could not find pipenv attempting to install"
        pyhton -m pip install pipenv --user
    fi
    PIPENV_CMD=$(command -v pipenv || echo "python -m pipenv")
}


function main {
    # Main logic flow
    local REPO_ROOT=$(git rev-parse --show-toplevel)

    # Check for required commands
    bootstrap

    for positional_arg in $(parse_args $@); do
        case $positional_arg in
            init)
                $PIPENV_CMD install --dev
                $PIPENV_CMD run githooks
                ;;
            format)
                $PIPENV_CMD run black $REPO_ROOT
                $PIPENV_CMD run isort $REPO_ROOT
                ;;
            test)
                $PIPENV_CMD run coverage run
                $PIPENV_CMD run coverage report
                $PIPENV_CMD run coverage xml
                ;;
            lint)
                local CHECK_ERR=0
                $PIPENV_CMD run flake8 || CHECK_ERR=$((CHECK_ERR + 1))
                $PIPENV_CMD run mypy || CHECK_ERR$((CHECK_ERR + 1))
                return $CHECK_ERR
                ;;
            package)
                $PIPENV_CMD run python setup.py bdist_wheel
                ;;
            publish)
                ;;
                #$PIPENV_CMD run twine stuff
            *)
                1>&2 echo "ERROR: Unknown sub-command '$positional_arg'."
                usage
                ;;
        esac
    done
}


main $@
