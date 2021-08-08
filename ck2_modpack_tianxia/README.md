How to prepare a modpack for campaign:

* copy all mods to `steam_mods`
* adjust include/exclude lists in `Rakefile`
* `rake gavelkind:fetch` to fetch github mods
* `rake unpack` to generate `mods_unpacked`
* `rake conflicts` until list is clean
* If this is good, then proceed
* `rake build` to build the modpack
