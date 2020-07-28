This program generates data for [Hearts of Iron IV Online Division Designer](https://taw.github.io/hoi4/).

You will need to install ruby.

To run it for your mod:

```
ruby bin/import_data your_mod_name "path/to/hoi4/game" "path/to/your/mod"
```

If it works, it will generate `data/your_mod_name.json`.

If it doesn't work, it should give you error message, usually listing file that caused problems.

The importer tries to figure out everything from game files, but it might need some help.
