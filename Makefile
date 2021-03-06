include common.mk

.PHONY: check
check: unit_test integration_test

.PHONY: unit_test
unit_test: style style_check test_check asciidoctor_check \
           web_check template_check preview_check conf_check

.PHONY: style
style: build_docs
	$(DOCKER) py_test pycodestyle build_docs

.PHONY: style_check
style_check:
	$(MAKE) -C resources/style

.PHONY: test_check
test_check:
	$(MAKE) -C resources/test

.PHONY: asciidoctor_check
asciidoctor_check:
	$(MAKE) -C resources/asciidoctor

.PHONY: web_check
web_check:
	$(MAKE) -C resources/web

.PHONY: template_check
template_check:
	$(MAKE) -C template

.PHONY: preview_check
preview_check:
	$(MAKE) -C preview

.PHONY: integration_test
integration_test:
	$(MAKE) -C integtest

.PHONY: conf_check
conf_check: conf.yaml
	$(DOCKER) py_test yamale -s schema.yaml conf.yaml --no-strict
