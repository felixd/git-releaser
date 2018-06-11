#!/bin/bash
# File: release.sh
# (c) 2018 Paweł 'felixd' Wojciechowski
# Outsourcing IT - Konopnickiej.Com
# Source: https://gitlab.com/felixd/git-releaser

if [ -d "git-releaser/" ]; then
 git-releaser/git-releaser.sh
else

 git clone https://gitlab.com/felixd/git-releaser.git

 if [ -f "release.sh" ]; then
  chmod +x release.sh
 fi

 if [ ! -f ".gitignore" ]; then
   echo "git-releaser/" >> .gitignore
 fi

 if [ ! -f "VERSION" ]; then
   echo "Creating VERSION file"
   echo "0.0.0" > VERSION
 fi

fi
