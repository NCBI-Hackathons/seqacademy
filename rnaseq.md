# SeqAcademy RNA-Seq Tutorial

# Contents
## 1. Alignment
### A. HISAT 
### B. Samtools
### C. dupRadar
## 2. Downstream analysis
### A. Differential expression analysis
### B. MultiQC

# 1. Alignment

## 1A. HISAT (Hierarchical Indexing for Spliced Alignment of Transcripts)

In this tutorial, we'll use HISAT to align the sample reads to a reference genome. Hisat automatically downloads and preprocesses the reads so they're ready to be aligned. HISAT is a highly efficient system for aligning reads from RNA sequencing experiments. HISAT uses an indexing scheme based on the Burrows-Wheeler transform and the Ferragina-Manzini (FM) index, employing two types of indexes for alignment: a whole-genome FM index to anchor each alignment and numerous local FM indexes for very rapid extensions of these alignments. HISAT’s hierarchical index for the human genome contains 48,000 local FM indexes, each representing a genomic region of ~64,000 bp.

The RNA-Seq data we'll use is from https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP106028

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

`less scripts/rnaseq/setuprnaseq.py`

Run the code using:

`python scripts/rnaseq/setuprnaseq.py`

Then run the following command to create the yeast index. The next cell is a bash script. When run, the script downloads sequences for the latest Yeast release from Ensembl. By default, it builds and index for just the base files, since alignments to those sequences are the most useful.  To change which categories are built by this script, edit the CHRS_TO_INDEX variable in the following cell. 

Our next step is to download the sequences for release 84 of the Saccharomyces cerevisiae genome.  We will only download the top-level sequence in order to save time.

Run the following code by typing the following line into the command line
and pressing enter:

`bash scripts/rnaseq/index.sh`

Align the RNA-Seq samples using Hisat.

This step would normally take several hours, but the `-u 2500` part of the command tells HISAT to only align the first 2500 reads.

Run the followning:

`python scripts/rnaseq/runrnaseq.py`

If you want to align all reads, run `scripts/rnaseq/runrnaseqall.py` instead. Keep in mind this would take several hours so it may be beneficial to run it as:

`nohup python scripts/rnaseq/runrnaseqall.py &`

Nohup runs a command in the background so that you may close your computer or command line interface.

## 1B. Samtools 

We'll use samtools to sort the output files and convert them to bam files.

Sort the output files and convert them to bam files.

`python scripts/rnaseq/samtools.py`

## 1C. dupRadar

We'll use dupRadar to detect duplicates and count of each gene. This script is written in python, but it calls a script written in R `dupRadar.R`.

Run:

`python scripts/rnaseq/dupRadar.py`

# 2. Downstream analysis

## 2A. Differential expression analysis

We want to quantify genetic expression over the yeast genome. We use DESeq (Differential Expression Sequencing) is used to estimate variance-mean dependence in count data from high-throughput sequencing assays and test for differential expression based on a model using the negative binomial distribution.

However, based on how we ran the program (using  `-u 2500`) there won't be enough of a difference to perform differential analysis.

Before performing this step, we need to re-do our RNA-Seq experiment with alll the reads by running:

`nohup python scripts/rnaseq/runrnaseqall.py &`

As noted in 1A, `nohup` lets us run the command in the background.

Then run the python script to count the genes and plot the results:

`python scripts/rnaseq/diffexp.py`


## 2B. MultiQC

This section details quality control checks on the read data from either RNAseq or ChIPseq data using MultiQC. MultiQC takes all output and log files from an alignment software program and aggregates the information from all samples into one convenient report (html by default).

MultiQC was installed earlier in the tutorial, so all we need to do is run it on the data.

MultiQC is configured to run the same no matter what type of sequencing data is available, therefore the same command can be used to analyze either our RNAseq data or our ChIPseq data.  We include the option 'hisat_output' since we are aligning using the HISAT2 program.  See http://multiqc.info/docs/ for more information.

We use the 'hisat_output' option because we are analyzing data downloaded and aligned using the HISAT2 program.  We use the '--force' option to overwrite any previous versions of the multiqc_report.  '--quiet' only shows log warnings.

`multiqc test`
