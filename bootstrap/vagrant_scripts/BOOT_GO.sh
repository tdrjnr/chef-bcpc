#!/bin/bash
# Exit immediately if anything goes wrong, instead of making things worse.
set -e

# set a flag to tell shared_functions.sh how to SSH to machines
export BOOTSTRAP_METHOD=vagrant
# build a converged cluster by default
export CLUSTER_TYPE=converged

echo " ____   ____ ____   ____ "
echo "| __ ) / ___|  _ \ / ___|"
echo "|  _ \| |   | |_) | |    "
echo "| |_) | |___|  __/| |___ "
echo "|____/ \____|_|    \____|"
echo
echo "BCPC Vagrant BootstrapV2 0.2"
echo "--------------------------------------------"
echo "Bootstrapping local Vagrant environment..."

# Source common bootstrap functions. This is the only place that uses a
# relative path; everything henceforth must use $REPO_ROOT.
source ../shared/shared_functions.sh
export REPO_ROOT="$REPO_ROOT"

load_configs

# Perform preflight checks to validate environment sanity as much as possible.
echo "Performing preflight environment validation..."
source "$REPO_ROOT"/bootstrap/shared/shared_validate_env.sh

# Do prerequisite work prior to starting build, downloading files and
# creating local directories. Proxy configuration is handled there as well.
echo "Downloading necessary files to local cache..."
source "$REPO_ROOT"/bootstrap/shared/shared_prereqs.sh

# Terminate existing BCPC VMs.
echo "Shutting down and unregistering VMs from VirtualBox..."
"$REPO_ROOT"/bootstrap/vagrant_scripts/vagrant_clean.sh

# Create VMs in Vagrant and start them.
echo "Starting local Vagrant cluster..."
"$REPO_ROOT"/bootstrap/vagrant_scripts/vagrant_create.sh

# Install and configure Chef on all Vagrant hosts.
echo "Installing and configuring Chef on all nodes..."
"$REPO_ROOT"/bootstrap/shared/shared_configure_chef.sh

# Dump out OpenStack information for users if a converged cluster
if [[ $CLUSTER_TYPE == 'converged' ]]; then
  "$REPO_ROOT"/bootstrap/vagrant_scripts/vagrant_print_useful_info.sh
fi

printf 'Finished in %d seconds (%dh:%dm:%ds)\n' "$SECONDS" $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))
