# SeqAcademy RNA-Seq Tutorial

# Contents
1. Alignment
    A. HISAT 
    B. Samtools
    C. Gene counts
2. Downstream analysis
    A. High-throughput sequencing
    B. Differential Expression Sequencing
    C. Visualization
    D. MultiQC

# 1. Alignment
## 1A. HISAT (Hierarchical Indexing for Spliced Alignment of Transcripts)

In this tutorial, we'll use Hisat to align the sample reads to a reference genome. Hisat automatically downloads and preprocesses the reads so they're ready to be aligned. Hisat (hierarchical indexing for spliced alignment of transcripts) is a highly efficient system for aligning reads from RNA sequencing experiments. HISAT uses an indexing scheme based on the Burrows-Wheeler transform and the Ferragina-Manzini (FM) index, employing two types of indexes for alignment: a whole-genome FM index to anchor each alignment and numerous local FM indexes for very rapid extensions of these alignments. HISAT’s hierarchical index for the human genome contains 48,000 local FM indexes, each representing a genomic region of ~64,000 bp.

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

Our next step is to `cd` into the new directory, yeast_index, and download the sequences for release 84 of the Saccharomyces cerevisiae genome.  We will only download the top-level sequence in order to save time.  

Run the following code by typing the following line into the command line
and pressing enter:

`bash scripts/rnaseq/index.sh`

Align the RNA-Seq samples using Hisat.

This step would normally take several hours, but the `-u 1000` part of the command tells Hisat to only align the first 1000 reads. If you want to align all reads, remove this text.

Run the followning:

`python scripts/rnaseq/runrnaseq.py`

## 1B. Samtools 

We'll use samtools to sort the output files and convert them to bam files.

Sort the output files and convert them to bam files.

`python scripts/rnaseq/samtools.py`

## 1C. Gene counts

We run a unix-based bash script `loadYeastGeneCounts.sh` to quantify genetic expression over the yeast genome.

Run:

`Rscript scripts/rnaseq/loadYeastGeneCounts.R`

# 2. Downstream analysis 
## 2A. High-throughput sequencing

HTSeq (High-throughput sequencing) is a Python library to facilitate the rapid development of RNA-Seq analysis. HTSeq offers parsers for many common data formats in HTS projects, as well as classes to represent data, such as genomic coordinates, sequences, sequencing reads, alignments, gene model information and variant calls, and provides data structures that allow for querying via genomic coordinates. In this tutorial we will use htseq-count, a tool developed with HTSeq that preprocesses RNA-Seq data for differential expression analysis by counting the overlap of reads with genes. 

## 2B. Differential Expression Sequencing

DESeq (Differential Expression Sequencing) is used to estimate variance-mean dependence in count data from high-throughput sequencing assays and test for differential expression based on a model using the negative binomial distribution.

It should take about 5-10 minutes. Run it using the following:

`Rscript scripts/rnaseq/deseq.R`

## 2C. Visualization

The following script performs principal component analysis and creates volcano plots and bar graphs of RNA-Seq expression.

`Rscript scripts/rnaseq/visualize.R`

## 2D. MultiQC

This section details quality control checks on the read data from either RNAseq or ChIPseq data using MultiQC. MultiQC takes all output and log files from an alignment software program and aggregates the information from all samples into one convenient report (html by default).

MultiQC was installed earlier in the tutorial, so all we need to do is run it on the data.

MultiQC is configured to run the same no matter what type of sequencing data is available, therefore the same command can be used to analyze either our RNAseq data or our ChIPseq data.  We include the option 'hisat_output' since we are aligning using the HISAT2 program.  See http://multiqc.info/docs/ for more information.

We use the 'hisat_output' option because we are analyzing data downloaded and aligned using the HISAT2 program.  We use the '--force' option to overwrite any previous versions of the multiqc_report.  '--quiet' only shows log warnings.

`multiqc test`
