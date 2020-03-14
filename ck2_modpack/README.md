How to prepare a modpack for campaign:

* copy all mods to `steam_mods`
* adjust include/exclude lists in `Rakefile`
* `rake mods:gavelkind:fetch` to fetch github mods
* `rake mods:unpack` to generate `mods_unpacked`
* `rake mods:conflict` until list is clean
* If this is good, then proceed
* `rake base` to create base
* `rake build` to create ck2tweaks and merge with base
