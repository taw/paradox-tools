How to prepare a modpack for campaign:

* copy all mods to `steam_mods`
* adjust include/exclude lists in `Rakefile`
* `rake mods:gavelkind:fetch` to fetch github mods
* `rake mods:unpack` to generate `mods_unpacked`
* `rake mods:conflict` until list is clean

* merge modpack
* adjust tweaks
* apply tweaks to modpack
