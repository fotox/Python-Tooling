.PHONY: init venv pre-commit update clean test test-cov re-init

VENV_NAME := venv
ACTIVATE := .\venv\Scripts\activate

init: init_venv pre-commit

init_venv:
	python -m venv $(VENV_NAME)
	echo "Virtual environment $(VENV_NAME) created."

pre-commit:
	$(ACTIVATE) & pip install pre-commit
	$(ACTIVATE) & pre-commit install
	$(ACTIVATE) & pre-commit install-hooks
	$(ACTIVATE) & pre-commit run --all-files

update:
	.\\venv\\Scripts\\activate & pip install -r function/requirements.txt
	.\\venv\\Scripts\\activate & pip install -r tests/requirements.txt

clean:
	$(SHELL) -c "rm -rf $(VENV_NAME)"

test:
	$(ACTIVATE) & pytest

test-cov:
	$(ACTIVATE) & pytest --cov function

re-init: clean init
