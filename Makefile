
.DEFAULT_GOAL := all
autoflake = poetry run autoflake --remove-all-unused-imports --recursive --remove-unused-variables --expand-star-imports --in-place docs/src/ recon tests --exclude=__init__.py
flake8 = poetry run flake8 --ignore E501,E203,W503 recon tests
isort = poetry run isort recon tests
black = poetry run black -S -l 100 --target-version py39 recon tests
mypy = poetry run mypy recon
pyright = poetry run pyright


.PHONY: install
install:
	poetry install


.PHONY: format
format:
	$(autoflake)
	$(isort)
	$(black)

.PHONY: lint
lint:
	$(flake8)
	$(isort) --check-only --df
	$(black) --check --diff


.PHONY: mypy
mypy:
	$(mypy)

.PHONY: pyright
pyright:
	$(pyright)

.PHONY: test
test:
	poetry run pytest ./tests --cov=recon --cov-report=term-missing -o console_output_style=progress

.PHONY: build-docs
build-docs:
	poetry run python -m mkdocs build
	cp ./docs/index.md ./README.md

.PHONY: deploy-docs
deploy-docs: build-docs
	poetry run python -m mkdocs gh-deploy --force

.PHONY: docs-live
docs-live:
	poetry run mkdocs serve --dev-addr 0.0.0.0:8009
