#!/bin/bash
#------------------------------------------------------------
# Install emacs config files from this project.
#------------------------------------------------------------

DST=${HOME}/.emacs.d

if [ -d ${DST} ]; then
    mv ${DST} ${DST}.orig
    echo "existing ${DST} renamed to ${DST}.orig"
fi

mkdir -p ${DST}

cp -r ac-dict ${DST}/
cp auto-complete-config.el ${DST}/
cp auto-complete.el ${DST}/
cp fuzzy.el ${DST}/
cp init.el ${DST}/
cp popup.el ${DST}/

echo "created/replace ${HOME}/.emacs.d"

#--------------------------------------------------

echo "$0 done"

#============================================================
# done
#============================================================
