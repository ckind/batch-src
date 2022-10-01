# batch-src

bash script for batch converting .wav audio bit depth and sample rate

## Dependencies

[SoX](https://sox.sourceforge.net/sox.html) - install on mac with [homebrew](https://formulae.brew.sh/formula/sox)

## Usage

### Mac/Linux

Clone this repo or simply download batch-src.sh

Open a terminal and run the following commands:

<code>chmod +x {where_ever_you_saved_this}/batch-src.sh</code>

<code>cp {where_ever_you_saved_this}/batch-src.sh /usr/local/bin/batch-src.sh</code>

Run the script specifying the input directory, output directory, sample rate (optional), bit depth (optional) and volume normalization (optional).

Defaults are 48k for sample rate, 16 for bit depth and -3 for volume normalization.

Volume normalization is useful for avoiding clipping during the converstion process.

<code>batch-src.sh {input_path} {output_path} {sample_rate} {bit_depth} {volume_normalization}</code>

Example usage:

<code>batch-src.sh ~/my-files-96k-32bit ~/my-files-44.1k-24bit 44.1k 24 -3</code>

For converting large quantities of files, it may be useful to redirect all messages to a file:

<code>batch-src.sh ~/my-files-96k-32bit ~/my-files-44.1k-24bit 44.1k 24 -3 &> output.txt</code>