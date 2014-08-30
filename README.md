paradox-tools
=============

Utilities for formats found in various Paradox games (Europa Universalis, Crusader Kings etc.)


Contents
--------

* `bin/analyze_idea_group` - score idea groups by value
* `bin/analyze_policies` - print bonuses by policy
* `bin/analyze_unit_pips` - analyze unit pips by tech group and tech level and save to CSV files
* `bin/country_cultures` - print primary country tag for each culture
* `bin/diff_paradox` - normalize two Paradox mod files (or directories of them) and diff them
* `bin/find_redundant_files` - check for files in mod directory which are same as in vanilla and can be removed
* `bin/parse_paradox` - parse and print Paradox mod file as Ruby object
* `bin/validate_syntax` - validate syntax of Paradox mod file
* `lib/` - public API
* `test/` - tests
* `fun_and_balance/` - Fun & Balance mod automatic build system (unfinished)
* files directly in the root directory of the repository are mostly old scripts which should be ported to the snew system at some point

