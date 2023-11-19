# Data Science project template

This is a template for data science projects. It is based on the [copier template system](https://copier.readthedocs.io/en/stable/)

## Features

- [x] [Poetry](https://python-poetry.org/) for dependency management
- [x] [pre-commit](https://pre-commit.com/) for code formatting and linting
- [x] [pytest](https://docs.pytest.org/en/stable/) for testing
- [x] [tox](https://tox.readthedocs.io/en/latest/) for automated testing
- [x] [black](https://black.readthedocs.io/en/stable/) for code formatting
- [x] [ruff](https://docs.astral.sh/ruff/) for linting

## Dependencies

- [copier](https://copier.readthedocs.io/en/stable/)
- [make](https://www.gnu.org/software/make/)
- [poetry](https://python-poetry.org/)

## Usage

1. Install copier: `pipx install copier`
2. Copy this template: `copier gh:matteospanio/data-science-template <your-project-name>`
3. Install the dependencies: `make install`