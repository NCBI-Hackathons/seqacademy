# SeqAcademy ChIP-Seq Tutorial

# Contents
1. Alignment
    A. HISAT 
    B. Samtools
2. Downstream analysis
    A. Model-Based Analysis for ChIP-Seq
    C. IGV
    D. MultiQC

# 1. Alignment
## 1A. HISAT (Hierarchical Indexing for Spliced Alignment of Transcripts)

In this tutorial, we'll use Hisat to align the sample reads to a reference genome. Hisat automatically downloads and preprocesses the reads so they're ready to be aligned. Hisat (hierarchical indexing for spliced alignment of transcripts) is a highly efficient system for aligning reads from RNA sequencing experiments. HISAT uses an indexing scheme based on the Burrows-Wheeler transform and the Ferragina-Manzini (FM) index, employing two types of indexes for alignment: a whole-genome FM index to anchor each alignment and numerous local FM indexes for very rapid extensions of these alignments. HISAT’s hierarchical index for the human genome contains 48,000 local FM indexes, each representing a genomic region of ~64,000 bp.

The ChIP-Seq data is from https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP132584

The model organism for this project is Yeast i.e. Saccharomyces cerevisiae. For RNA-Seq, yeast data between euploid and aneuoploid conditions will be compared. For ChIP-SEq, yeast data between 3AT-treated and untreated conditions will be compared.

The following cell contains python code. 

The Python programming language comes with a variety of built-in functions. Among these are several common functions, including:

+ print() which prints expressions out
+ abs() which returns the absolute value of a number
+ int() which converts another data type to an integer
+ len() which returns the length of a sequence or collection

These built-in functions, however, are limited, and we can make use of modules to make more sophisticated programs.

Modules are Python .py files that consist of Python code. Any Python file can be referenced as a module. 

You may view the code by running:

`less scripts/chipseq/setupchipseq.py`

Run the code using:

`python scripts/chipseq/setupchipseq.py`

Then run the following command to create the yeast index. The next cell is a bash script. When run, the script downloads sequences for the latest Yeast release from Ensembl. By default, it builds and index for just the base files, since alignments to those sequences are the most useful.  To change which categories are built by this script, edit the CHRS_TO_INDEX variable in the following cell. 

Our next step is to `cd` into the new directory, yeast_index, and download the sequences for release 84 of the Saccharomyces cerevisiae genome.  We will only download the top-level sequence in order to save time.  

You may view the code by running:

less scripts/chipseq/index.sh

Run the following code by typing the following line into the command line
and pressing enter:

`bash scripts/chipseq/index.sh`

Align the ChIP-Seq samples using Hisat.

This step would normally take several hours, but the `-u 100` part of the command tells Hisat to only align the first 100 reads. If you want to align all reads, remove this text.

Run the code using:

`python scripts/chipseq/runchipseq.py`

## 1B. Samtools 

We'll use samtools to sort the output files and convert them to bam files.

Run:

`python scripts/chipseq/samtools.py`

# 2. Downstream analysis
## 2A. Model-Based Analysis for ChIP-Seq

Peak-calling is one of the main steps scientists use in determining the locations where protein is bound in DNA. Peak detection software, such as MACS (Model-Based Analysis for ChIP-Seq), call peaks using the aligned sequecnes as input and returns precise locations of predicted peaks as output. In this tutorial, we'll use MACS.

More information about MACS: http://liulab.dfci.harvard.edu/MACS/Download.html

Run the code using:

`python scripts/chipseq/macs.py`

For an in-depth discussion of what MACS2 does: https://github.com/taoliu/MACS/wiki/Advanced:-Call-peaks-using-MACS2-subcommands

## 1C. Bedtools

We'll use Bedtools to extract the intersecting regions of the MACS output between the experimental conditions.

`bedtools intersect -a test/SRR6703661/SRR6703661_peaks.narrowPeak -b test/SRR6703663/SRR6703663_peaks.narrowPeak -u > test/ChIPSeqintersect.bed`

### 2C. IGV
A BAM file viewer will allow you to see your reads in an interactive graphical display. There are many different viewers available such as UCSC Genome Browser, Integrative Genomics Viewer (IGV), and NCBI Genome Workbench.

To load .bam files please first do the following:

Transfer the data to your computer. Amazon provides documentation on copying files with scp (Linux, OSX) and WinSCP (Windows). 

For scp, the command will be approximately: scp ubuntu@your-instance-name-or-ip-address:/home/ubuntu/data/transcript.fa

Load annotation in IGV
File -> Load from File ... -> ChIPSeqintersect.bed

## 2D. MultiQC

This section details quality control checks on the read data from either RNAseq or ChIPseq data using MultiQC. MultiQC takes all output and log files from an alignment software program and aggregates the information from all samples into one convenient report (html by default).

MultiQC was installed earlier in the tutorial, so all we need to do is run it on the data.

MultiQC is configured to run the same no matter what type of sequencing data is available, therefore the same command can be used to analyze either our RNAseq data or our ChIPseq data.  We include the option 'hisat_output' since we are aligning using the HISAT2 program.  See http://multiqc.info/docs/ for more information.

We use the 'hisat_output' option because we are analyzing data downloaded and aligned using the HISAT2 program.  We use the '--force' option to overwrite any previous versions of the multiqc_report.  '--quiet' only shows log warnings.

Use:

`multiqc test`
