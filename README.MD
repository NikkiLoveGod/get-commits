# Get commits

A simple bash script that goes through your Git repositories and prints out the commits that you or others have made during a given timespan. 

It's meant to answer the question "What did I do two days ago?" based on Git commits.

## Installation

* Clone this repo into somewhere in your filesystem.
* Optionally copy the `git-commits.sh` script somewhere under your $PATHS, fe. `cp git-commits.sh /usr/local/bin/get-commits`

## Usage
```bash
$ ./get-commits.sh -h

Usage: ./get-commits.sh [...opts] -p "/paths/to /git/repos /separated/by/spaces"
Example: ./get-commits -a me@domain.com -p "/usr/repos/my-project /usr/repos/my-another-project" --update

  -a | --author   Limit commits to a given author.
  -s | --since    Include commits only after given timeframe. See git log --help for formatting options.
  -u | --update   Fetches latest commits before printing them.
  -h | --help     Print this help.
  -p | --paths    Space separated list of absolute paths into Git repositories.

```

## Output
```bash
$ ./get-commits.sh -p /Users/nlg/dev/commitfinder                                                                             [10:42:23]

## /Users/nlg/dev/commitfinder:

Sami Kurvinen (10):
      2020-05-17 10:34:04 +0300  (HEAD -> master) Tweaks options
      2020-05-17 09:49:07 +0300  Updates repo in its own function
      2020-05-17 09:45:49 +0300  Updates repos if its set as a param
      2020-05-17 09:45:38 +0300  Fixes default value syntax
      2020-05-17 09:28:25 +0300  Takes all arguments as params
      2020-05-17 09:21:25 +0300  Uses shortlog author instead of base logs author for limiting results
      2020-05-17 09:17:02 +0300  Supports targetting single user or viewing others
      2020-05-17 09:11:18 +0300  Uses git shortlog instead of simple log
      2020-05-17 08:45:16 +0300  Some codd formatting things
      2020-05-17 08:38:47 +0300  Gets commits from repos
```
