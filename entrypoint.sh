#!/bin/sh
if !(test -f /dependencies/orca/otool_xtb); then
 ln -s /dependencies/xtb/bin/xtb /dependencies/orca/otool_xtb
fi
bash
