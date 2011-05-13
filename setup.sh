#!/bin/bash

rvm_test=`which rvm`

if [ "$?" -eq "0" ] ; then
  rvm use system
fi

rake install

