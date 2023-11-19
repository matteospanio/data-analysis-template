UNAME := $(shell uname)
POETRY := poetry run
DOCS := cd docs && $(POETRY) make clean

ifeq ($(UNAME), Linux)
	OPEN = xdg-open
endif
ifeq ($(UNAME), Darwin)
	OPEN = open
endif
ifeq ($(UNAME), Windows)
	OPEN = start
endif

define PRINT_HELP_PYSCRIPT
import re, sys

BOLD = '\033[1m'
BLUE = '\033[94m'
END = '\033[0m'

print("Usage: make <target>\n")
print(BOLD + "%-20s%s" % ("target", "description") + END)
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print( BLUE + "%-20s" % (target) + END + "%s" % (help))
endef
export PRINT_HELP_PYSCRIPT

default: help

.PHONY: help
help: ## Show this help
	@$(POETRY) python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.PHONY: clean clean-build clean-pyc clean-test
clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts
	$(POETRY) ruff clean

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -fr {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

.PHONY: activate
activate: ## activate the virtual environment
	poetry shell

.PHONY: test
test: ## run tests quickly with the default Python
	@echo "Run pytest suite"
	@$(POETRY) pytest

.PHONY: test-coverage
test-coverage: ## run tests with coverage
	$(POETRY) pytest --cov-config .coveragerc --cov-report term-missing --cov-report html --cov=src

.PHONY: format
format: ## format code
	@echo "Format docstrings"
	@$(POETRY) docformatter --config ./pyproject.toml --recursive --in-place ./src ./tests
	@echo "Format code with black"
	@$(POETRY) black .

.PHONY: lint
lint: ## check style with pylint
	$(POETRY) ruff check ./src ./tests --show-source

.PHONY: update
update: ## update dependencies
	poetry update
	$(POETRY) pre-commit autoupdate

.PHONY: install
install: ## install the package to the active Python's site-packages
	@poetry install
	@poetry run pre-commit install
