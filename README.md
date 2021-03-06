# Git Releaser

## Installation

In Your project, root folder, execute command:

```bash
wget https://gitlab.com/felixd/git-releaser/raw/master/install/release.sh && bash release.sh
```

For security reasons check [install/release.sh](install/release.sh) file before executing command.

Command will:
* Create `release.sh` file in your project folder which will be used for releases
* Create `VERSION` file if it does not exist with initial 0.0.0 version number
* Create `git-release/` folder + add it to `.gitignore` (You don't need it in Your project, `release.sh` will always check if it's there for You)

## About

* Helps You correctly enumerate your project releases with simple terminal tool
* Automatically marks release commit with correct **tag**
* Automagically do everything for You ;)  **Just Try It**

```bash
./git-releaser.sh

+--------------+
| Git Releaser |
+--------------+

Branch [develop] exists.
Branch [master] exists.
We are on DEVELOP branch [develop]
------------------------------------------------
Current Version: 1.2.0
------------------------------------------------
Please select Your release number:
* [1] - Major - 2.0.0
* [2] - Minor - 1.3.0
* [3] - Patch - 1.2.1
------------------------------------------------
To exit press any other key.
------------------------------------------------
[1],[2],[3]: 3
Updating 1.2.0 to 1.2.1
Switched to a new branch 'release/1.2.1'
[release/1.2.1 fbc802b] Release 1.2.1
1 file changed, 1 insertion(+), 1 deletion(-)
Release 1.2.1. Updating version file [/VERSION]
...
```

## Git branches names

`You are always doing releases from $DEVELOP_BRANCH`

```bash
DEVELOP_BRANCH = "develop"
MASTER_BRANCH  = "master"
RELEASE_PREFIX = "release/"
```

## Author

Paweł 'felixd' Wojciechowski - [Outsourcing IT - Konopnickiej.Com](http://konopnickiej.com)
