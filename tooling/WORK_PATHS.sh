#!/usr/bin/bash
declare -A WORK_PATHS=(
  # map list of directories. The key will be the name used on env name of o each item
  # All paths will be relative do $HOME
  # Example line:
  # [NAME]=path/from/home
  [test]=/home/jorb/code/JorbFreire/tooling
)