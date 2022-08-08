.PHONY:

TMP_DIR=/tmp/otp-labs
TPLS_DIR=$(TMP_DIR)/mix_templates
GEN_DIR=$(TMP_DIR)/mix_generator
ELIXIR_VER=`asdf current elixir | sed -r 's/\s+/ /g' | cut -d ' ' -f 2`
MIX_ARC_DIR=${ASDF_DIR}/installs/elixir/$(ELIXIR_VER)/.mix/archives/

help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clone_pragdave_repos: ## Clone template system from pragdave repo
	gh repo clone pragdave/mix_generator $(TPLS_DIR) && \
	gh repo clone pragdave/mix_templates $(GEN_DIR)

install_template_system: ## Install locally Dave Thomas template system
	cd $(TMP_DIR) && mix archive.install hex mix_generator && \
	mix archive.install hex mix_templates

remove_template_system: ## Delete template system
	rm -rf $(MIX_ARC_DIR)/mix_generator* && \
	rm -rf $(MIX_ARC_DIR)/mix_templates*

install_otp_libcluster_horde_template: ## Install OTP, libcluster, horde project template
	cd .. && mix template.install template

remove_otp_libcluster_horde_template: ## Delete OTP, libcluster, horde projecect template
	rm -rf $(MIX_ARC_DIR)/otp_libcluster_horde*

