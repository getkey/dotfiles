#!/bin/sh

project_root=$(dirname $0) # directory containing this script
$project_root/mk_links.sh
$project_root/setup_nvim.sh
