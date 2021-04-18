# Dataset: Wikimedia Dumps / Cirrus

Downloading [Wikipedia database dumps](http://download.wikimedia.org/) or
using a [fork](https://github.com/jchwenger/wikiextractor) of [Wikiextractor](https://github.com/attardi/wikiextractor).

Wikipedia archives are found in two formats, the Wikimedia dumps, that contain
templates that need to be expanded, and already expanded Cirrus dumps that can
be downloaded and used directly (recommended option). Because the Cirrus dumps
seem relatively clean, and because the wikiextractor.py is somewhat difficult
to improve on, the recommended method is to just use the Cirrus dumps.

Wikiextractor is present as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules), activate it like so:

```bash
$ git submodule init
$ git submodule update
```
### Cirrus

```bash
$ ./get-links.sh [language-code] # downloads to [language-code].cirrus-links.txt
$ ./download-cirrus.sh [file] # uses [language-code].cirrus-links.txt, downloads to cirrus/
$ ./extract-cirrus.sh
```

The script `download-cirrus.sh` will create a directory `cirrus` containing the
`.gz` files. Then, the script `extract-cirrus.sh` will create a directory for
each archive ([lang]wiki-[date], [lang]wikibooks-[date], etc.) containing the articles in
separate files.

### Wikimedia (perilous!)

```bash
$ ./download-wikimedia.sh [language-code]
$ ./extract-wikimedia.sh
```

The language code can be 'fr', 'en', etc. For a list of language codes run
`./get-links.sh` without options.

The script `download-wikimedia.sh` will create a folder `wikimedia` and extract
archives in there. The script `extract-wikimedia.sh` will process all data
found in `wikimedia/` and create the appropriate folders as above.


