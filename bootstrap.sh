#!/bin/sh

project_root=$(dirname $0) # directory containing this script
$project_root/src/mk_links.sh
$project_root/src/setup_vim.sh
