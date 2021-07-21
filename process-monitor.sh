#!/bin/bash

CYCLE=30
MYNAME=$0

function help() {
  echo "Usage: $0 name1 [name2 ...]"
}

function print_disk() {
  # 监控磁盘
  echo "-- system disk"
  df -iP
  echo
}

function print_memory() {
  # 监控内存
  echo "-- system menory"
  free
  echo
}

function print_slab() {
  echo "-- kernel slab"
  cat /proc/meminfo | grep Slab
  echo
}

function print_process_info() {
  PIDS=$(ps -ef | grep $1 | grep -v 'grep' | grep -v "${MYNAME}" | grep -v 'awk -f process-info.awk' | awk '{print $2}')
  OLD_IFS="$IFS"
  IFS=","
  array=($PIDS)
  IFS="$OLD_IFS"
  for pid in ${array[@]}; do
    process_info=$(ps aux | grep " $pid " | grep -v 'grep')
    # echo "-- $process_info"
    process_info=`echo $process_info | awk -f process-info.awk -v pid=$pid name=$1`
    echo "${process_info}"
  done
}

function main() {

  if [ $# -eq 0 ]; then
    help
    exit 0
  fi

  while :; do
    echo "-- $(date "+%Y-%m-%d %k:%M:%S")"
    
    # 监控进程列表
    echo "-- process list"
    for process_name in $@; do
      print_process_info ${process_name}
    done
    echo

    # print_memory
    # print_disk
    # print_slab
	break
    sleep ${CYCLE}
  done
}

main $@
