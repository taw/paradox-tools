paradox-tools
=============

Utilities for formats found in various Paradox games (Europa Universalis, Crusader Kings etc.)

Contents
--------

Tools:

* `bin/diff_paradox` - normalize two Paradox mod files (or directories of them) and diff them
* `bin/find_redundant_files` - check for files in mod directory which are same as in vanilla and can be removed
* `bin/recreate_baseline` - for each mod file, copy corresponding base game file into baseline directory (usually to compare and fix your mod with newly released game patch)
* `bin/validate_syntax` - validate syntax of Paradox mod file

Analysis scripts (EU4):

* `analysis/analyze_idea_group` - score idea groups by value
* `analysis/analyze_missions` - print some statistics about available missions
* `analysis/analyze_policies` - print bonuses by policy
* `analysis/analyze_static_modifier` - print bonuses by static modifier
* `analysis/analyze_unit_pips` - analyze unit pips by tech group and tech level and save to CSV files
* `analysis/country_cultures` - print primary country tag for each culture

Analysis scripts (CK2):

* `analysis_ck2/province_tech` - print tech by province from (uncompressed) CK2 save game
* `analysis_ck2/tribal_development` - report how far feudalization has gone so far

Debugging helper scripts:

* `bin/compare_province_traits` - compare province traits between two mods
* `bin/mission_debugger` - create trigerred modifier for every mission so you can easily see which are in the pool
* `bin/parse_paradox` - parse and print Paradox mod file as Ruby object

Other:

* `lib/` - public API
* `test/` - tests
* `fun_and_balance/` - Fun & Balance mod automatic build system
* `ck2tweaks/` - Small tweaks for Crusader Kings 2 (not even a coherent minimod)
* `save_game_scripts/` - various script for analyzing and editing save game files not ported to new API

Links
-----

* Extended Timeline mod: http://steamcommunity.com/sharedfiles/filedetails/?id=217416366
* Shattered Europe mod: http://steamcommunity.com/sharedfiles/filedetails/?id=305682089

