# Git Releaser

**Git Releaser**. Helps correctly enumerate your projects releases.

## Installation

In Your project, root folder, execute command:

```bash
wget -O - https://gitlab.com/felixd/git-releaser/install/release.sh | bash
```

For security reasons check [release.sh](https://gitlab.com/felixd/git-releaser/install/release.sh) file before executing command.

Command will:
* Create `release.sh` file in your project folder which will be used for releases
* Create `VERSION` file if it does not exist with initial 0.0.0 version number
* Create `git-release/` folder + add it to `.gitignore` (You don't need it in Your project, `release.sh` will always check if it's there for You)

## Git branches names

`You are always doing releases from $DEVELOP_BRANCH`

```bash
DEVELOP_BRANCH = "develop"
MASTER_BRANCH  = "master"
RELEASE_PREFIX = "release/"
```

## Author

Paweł 'felixd' Wojciechowski - [Outsourcing IT - Konopnickiej.Com](http://konopnickiej.com)

**First relased**: 10 Jan 2017
