# batch-src

bash batch script for converting audio bit depth and sample rate

## Dependencies

[SoX](https://sox.sourceforge.net/sox.html) - install on mac with [homebrew](https://formulae.brew.sh/formula/sox)

## Usage

### Mac

Clone this repo or simply download batch-src.sh

Open a terminal and run the following commands:

<code>chmod +x {where_ever_you_saved_this}/batch-src.sh</code>

<code>cp {where_ever_you_saved_this}/batch-src.sh /usr/local/bin/batch-src.sh</code>

Run the script specifying the root directory of the files to be converted and the directory where the results should be stored.

<code>batch-src.sh /path/to/my/files /path/to/my/files_converted</code>