#!/bin/bash
# Copyright: Paweł 'felixd' Wojciechowski - Outsourcing IT - Konopnickiej.Com
# Year: 2017

DEVELOP_BRANCH="develop"
MASTER_BRANCH="master"
RELEASE_PREFIX="release/"
VERSION_FILE="VERSION"
LINE='--------------------------------------------------------------------------------'

if [ "`git branch --list $DEVELOP_BRANCH`" ]
then
   echo "Branch [$DEVELOP_BRANCH] exists."
else
  echo "I'm not able to find DEVELOP branch. [Looking for: $DEVELOP_BRANCH]"
  exit -1
fi

if [ "`git branch --list $MASTER_BRANCH`" ]
then
   echo "Branch [$MASTER_BRANCH] exists."
else
  echo "I'm not able to find MASTER branch. [Looking for: $MASTER_BRANCH]"
  exit -1
fi

if [[ `git status --porcelain` ]]; then
  echo $LINE
  echo "Changes detected. Pleas commit them first!!!"
  echo $LINE
  git status
  echo $LINE
  echo "Changes detected. Pleas commit them first!!!"
  echo $LINE
  exit -1
fi

if [ $DEVELOP_BRANCH = $(git rev-parse --symbolic-full-name --abbrev-ref HEAD) ]; then
  echo "We are on DEVELOP branch [$DEVELOP_BRANCH]"
else
  echo "We are not on DEVELOP branch [$DEVELOP_BRANCH]. Should I checkout?"
  echo "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) -> $DEVELOP_BRANCH"
  read -n1 -p "[y/n]" RESPONSE
  case $RESPONSE in
    y) git checkout $DEVELOP_BRANCH ;;
    n)
     echo "Please come back when You are ready. Exiting..."
     exit -1
     ;;
    *)
     echo "Wrong answer. Please run application again."
     exit -1
     ;;
  esac
fi

echo $LINE
VERSION=`git describe --abbrev=0 --tags`
if [ -z $VERSION ]; then
  echo "Looks like this is Your first release."
  VNUM1=0 ; VNUM2=0 ; VNUM3=0
else
  echo "Current Version: $VERSION"
  VERSION_BITS=(${VERSION//./ })
  VNUM1=${VERSION_BITS[0]}
  VNUM2=${VERSION_BITS[1]}
  VNUM3=${VERSION_BITS[2]}
fi

echo $LINE
echo "Please select Your relese number:"
echo " * [1] - Major - $((VNUM1+1)).0.0"
echo " * [2] - Minor - $VNUM1.$((VNUM2+1)).0"
echo " * [3] - Patch - $VNUM1.$VNUM2.$((VNUM3+1))"
echo $LINE

read -n1 -p "[1],[2],[3]: " LEVEL
case $LEVEL in
  1) VNUM1=$((VNUM1+1)) ; VNUM2=0 ; VNUM3=0 ;;
  2) VNUM2=$((VNUM2+1)) ; VNUM3=0 ;;
  3) VNUM3=$((VNUM3+1)) ;;
  *)
   echo "Please run application again."
   exit -1 ;;
esac

NEW_VERSION="$VNUM1.$VNUM2.$VNUM3"
RELEASE_BRANCH=$RELEASE_PREFIX$NEW_VERSION

echo ''
echo "Updating $VERSION to $NEW_VERSION"

git checkout -b $RELEASE_BRANCH $DEVELOP_BRANCH
echo $NEW_VERSION > $VERSION_FILE

git commit -am "Release $NEW_VERSION"
echo "Release $NEW_VERSION. Updating version file [/$VERSION_FILE]"
git tag $NEW_VERSION

echo $LINE
git checkout $MASTER_BRANCH
git merge --no-ff --no-edit $RELEASE_BRANCH

echo $LINE
git checkout $DEVELOP_BRANCH
echo "TAG before: $(git describe --abbrev=0 --tags)"
git merge --no-ff --no-edit $RELEASE_BRANCH
echo "TAG after: $(git describe --abbrev=0 --tags)"
git branch -d $RELEASE_BRANCH
echo "TAG after removing $RELEASE_BRANCH: $(git describe --abbrev=0 --tags)"
echo $LINE

if [ $NEW_VERSION = $(git describe --abbrev=0 --tags) ]; then
  echo "New release completed. Pushing new TAGs and new release on $MASTER_BRANCH branch."
  git push --tags
  git push origin master
  echo $LINE
  echo "Version change: $VERSION -> $NEW_VERSION"
  echo $LINE
  echo "Git Status:"
  git status
else
  echo "New version tag [$NEW_VERSION] was not found in current branch"
  git status
fi
