paradox-tools
=============

Utilities for formats found in various Paradox games (Europa Universalis 3/4, Crusader Kings 2, Hearts of Iron 4 etc.)

There are also source files for some of my mods including Modern Times for CK2, Fun and Balance for EU4.

If you have any questions, feel free to create a github issue.

Script usage
------------

There are over 160 scripts in this repository.

You need ruby installed to run them.

If you're not sure how to run a script just run it without any arguments, and it should print you usage instructions. If it doesn't

On OSX you can just run them with:

```
$ folder/scriptname
```

On Windows depending on how you installed ruby, you'll need to use:

```
$ ruby folder/scriptname
$ jruby folder/scriptname
```

Most scripts follow similar order of arguments, like:

```
$ folder/scriptname path/to/save/file path/to/game
$ folder/scriptname path/to/save/file path/to/game path/to/mod1 path/to/mod2 ...
$ folder/scriptname path/to/game
$ folder/scriptname path/to/game path/to/mod1 path/to/mod2 ...
```

Save files must be text-based (not ironman), and not compressed.

`bin/unpack_save` script can remove compression, but for removing ironman you'll need third party tools.

Contents overview
-----------------

* `analysis_ck2` - script for analyses of CK2 game data and CK2 save games
* `analysis_eu4` - script for analyses of EU4 game data
* `analysis_eu4_save` - script for analyses of EU4 save games
* `analysis_hoi4` - script for analyses of HOI4 game data and HOI4 save games
* `bin` - various utilites that work with all games
* `ck2` - some CK2-specific code
* `ck2_hacks` - some code snippets for CK2 that can go into mods to help with debugging
* `ck2_modpack` - code to help me prepare CK2 modpack from many mods, and detect and fix issues
* `ck2_mods` - [source files for my various CK2 mods](https://steamcommunity.com/id/t_a_w/myworkshopfiles/?appid=203770)
* `data` - some graphics data needed by my mods
* `debug` - some debugging scripts
* `eu4` - some EU4-specific code
* `eu4_idea_explorer` - data exporter for [EU4 idea explorer](https://taw.github.io/eu4-ideas-explorer/)
* `eu4_minimods` - tiny EU4 mods
* `eu4_trade_graph` - scripts to edit EU4 trade map
* `fun_and_balance` - source code for my [Fun and Balance EU4 mod](https://steamcommunity.com/sharedfiles/filedetails/?id=444759856)
* `hoi4` - some HOI4-specific code
* `hoi4_division_designer` - data exporter for [online HOI4 Division Designer](https://taw.github.io/hoi4/)
* `lib` - code for parsing Paradox data formats, shared between games
* `mod_tutorials` - source file for my "mission modding tutorial" blog post series (that never got finished)
* `pictures` - thumbnails for my various mods
* `save_game_scripts` - some very old EU4 save game analysis and modification scripts
* `save_modification_ck2` - CK2 broken save game fixing scripts
* `source` - empty folder for dropping links to game sources and mods
* `sublime_text_syntax` - Paradox .txt syntax highlighting for Sublime Text
* `test` - some tests for this code
* `visualization_ck2` - map visualization scripts for CK2
* `visualization_eu4` - map visualization scripts for EU4
* `visualization_hoi4` - map visualization scripts for HOI4

Links
-----

* Extended Timeline mod: http://steamcommunity.com/sharedfiles/filedetails/?id=217416366
* Shattered Europe mod: http://steamcommunity.com/sharedfiles/filedetails/?id=305682089
* Fun and Balance logo based on "Not now, please, I'm busy (Explored)" by hehaden from flickr (CC-NC)
