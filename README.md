# SeqAcademy
### An easy-to-use, all-in-one jupyter notebook tutorial for the RNA-Seq and ChIP-Seq pipeline
![Logo](images/seqacademy.png)

## NOTE: This notebook is in active development, use with caution!

## Contents

[What is SeqAcademy?](#what-is-seqacademy)

[Who is SeqAcademy for?](#who-is-seqacademy-for)

[What does SeqAcademy teach?](#what-does-seqacademy-teach)

[How do I use SeqAcademy?](#how-do-i-use-seqacademy)

##### We recommend at least 4 processors with at least 16 GB RAM each
##### Total disk space required (includes large SAM files): 350 GB

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1233661.svg)](https://doi.org/10.5281/zenodo.1233661)

<b>Keywords</b>:
<i>RNA-Seq, ChIP-Seq, alignment, differential gene expression, peak-calling, education, tutorial, pipeline</i>

## What is SeqAcademy?

SeqAcademy is a user-friendly jupyter notebook-based educational pipeline for RNA-Seq and epigenomic data analysis.

RNA-Seq and ChIP-Seq experiments generate large amounts of data and rely on pipelines for efficient analysis.  However, existing tools perform specific portions of the pipeline or offer a complete pipeline solution for the advanced programmer.

SeqAcademy addresses these problems by providing an easy to use tutorial that outlines the complete RNA-Seq and ChIP-Seq analysis workflow and requires no prior programming experience.  

## Who is SeqAcademy for?

SeqAcademy is for students and researchers with little to no bioinformatics experience interested in hands-on bioinformatics tutorials.  Anyone will feel comfortable analyzing epigenomic and RNA-Seq data using this simple educational tool.

## What does SeqAcademy teach?

This tutorial works using HISAT2 aligner to align sample reads to a reference.

<img src="images/alignment.png" width="700" height="300">

Then it performs MultiQC to extract quality control information from the aligned reads.

<img src="images/qc.png" width="700" height="300">

It uses quantification methods (such as salmon for RNA-Seq and peak-calling for ChIP-Seq) to quantify expression and determine protein-binding. 

<img src="images/quantify.png" width="700" height="500">

The output is analyzed (differential gene expression for RNA-Seq and peak analysis for ChIP-seq), and the results are visualized.

The model organism for this project is Yeast i.e. <i>Saccharomyces cerevisiae</i>. For RNA-Seq, yeast data between euploid and aneuoploid conditions will be compared. For ChIP-Seq, yeast data between 3AT-treated and untreated conditions will be compared.

## How do I use SeqAcademy?

1. Identify and open the terminal emulator program on your computer. Mac and Linux systems come with Terminal installed, and Windows systems come with Console. If there isn't one installed, download one online. 

<img src="images/terminal.png" width="700" height="500">

2. Type `pwd` and press enter. This command shows what your current working directory is. Typing commands and pressing enter will be the primary way of running commands in this tutorial. Type `ls` to display which directories and files are in this current directory. 

<img src="images/pwdls.png" width="700" height="500">

3. If you'd like to use the tutorial in this current working directory, skip to step 5. Otherwise, you may make a new directory or move to another one. To make a new directory, run `mkdir DIRECTORY` in which DIRECTORY is the name of the directory you'd like to make. To move to another directory, run `cd DIRECTORY` in which DIRECTORY is the name of the DIRECTORY you'd like to move to. To move up a directory, run `cd ..`. 

4. Given the disk space and RAM requirements, it's likely you'll want to use a virtual machine for this tutorial. To connect to a virtual machine, make sure you use your own domain name or IP address. 

If you know the hostname you'd like to connect to, run `ssh -L PORTNUMBER:localhost:PORTNUMBER USERNAME@HOSTNAME` in which PORTNUMBER is a chosen unique identifable number, USERNAME is your username, and HOSTNAME is your hostname. 

If you know the IP you'd like to connect to, run `ssh -L PORTNUMBER:localhost:PORTNUMBER USERNAME@IP` in which IP is the IP address of the machine you wish to connect to.

5. Download anaconda (https://www.anaconda.com/download/) and git (https://git-scm.com/downloads).

<img src="images/anaconda.png" width="700" height="400">

<img src="images/git.png" width="700" height="300"> 

6. Run `git clone https://github.com/NCBI-Hackathons/seqacademy.git` to clone the directory such that you can download the tutorial. 

<img src="images/gitclone.png" width="700">

7. Run `cd seqacademy` to switch into the seqacademy directory.

8. If you are not on a virtual machine, run `jupyter notebook` to launch jupyter notebook from your internet browser.

If you are on a virtual machine, run `jupyter notebook --no-browser --port=PORTNUMBER` to launch jupyter notebook. Then copy+paste the URL into a web browser as instructed. 

If you run into a warning about the connection's privacy, proceed anyway.

<img src="images/unsafe1.png" width="750" height="500">

<img src="images/unsafe2.png" width="600" height="500">

9. Click `tutorial.ipynb` and follow the instructions of the tutorial.

<img src="images/jupyter.png" width="400" height="500">

## RNA-Seq

The following data presents the RNA-Seq data used in this tutorial. This tutorial observes RNA-Seq data of aneuploidy in Yeast (source: https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP106028).

|              |            |        |        |            |            |             |           |           |            |            |             |             |         |                    |                    |            |                     |               |                  |                |            |                          |          |             |           |             |        | 
|--------------|------------|--------|--------|------------|------------|-------------|-----------|-----------|------------|------------|-------------|-------------|---------|--------------------|--------------------|------------|---------------------|---------------|------------------|----------------|------------|--------------------------|----------|-------------|-----------|-------------|--------| 
| BioSample    | Experiment | MBases | MBytes | Run        | SRA_Sample | Sample_Name | karyotype | replicate | Assay_Type | AvgSpotLen | BioProject  | Center_Name | Consent | DATASTORE_filetype | DATASTORE_provider | InsertSize | Instrument          | LibraryLayout | LibrarySelection | LibrarySource  | LoadDate   | Organism                 | Platform | ReleaseDate | SRA_Study | source_name | strain | 
| SAMN06859211 | SRX2775581 | 1632   | 575    | SRR5494627 | SRS2158877 | GSM2595338  | Aneuploid | First     | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 
| SAMN06859210 | SRX2775582 | 940    | 331    | SRR5494628 | SRS2158878 | GSM2595339  | Aneuploid | Second    | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 
| SAMN06859209 | SRX2775583 | 1195   | 421    | SRR5494629 | SRS2158879 | GSM2595340  | Aneuploid | Third     | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 
| SAMN06859208 | SRX2775584 | 815    | 288    | SRR5494630 | SRS2158880 | GSM2595341  | Euploid   | First     | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 
| SAMN06859207 | SRX2775585 | 946    | 333    | SRR5494631 | SRS2158881 | GSM2595342  | Euploid   | Second    | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 
| SAMN06859206 | SRX2775586 | 1152   | 407    | SRR5494632 | SRS2158882 | GSM2595343  | Euploid   | Third     | RNA-Seq    | 51         | PRJNA385090 | GEO         | public  | sra                | ncbi               | 0          | Illumina HiSeq 2500 | SINGLE        | cDNA             | TRANSCRIPTOMIC | 2017-05-02 | Saccharomyces cerevisiae | ILLUMINA | 2017-09-12  | SRP106028 | Yeast cells | S288c  | 

<img src="images/pca1.png" width="600" height="500">

<img src="images/pca2.png" width="600" height="500">

Principal component analysis (PCA) suggests gene expression for euploid yeast samples (haploid) clusters distinctly from that of the aneuploid yeast samples (diploid chromosome X).The first two PCs account for ~70% of the variance in expressed genes). Data provided by Mulla et al. (https://elifesciences.org/articles/27991). 

<img src="images/volcanoplot.png" width="500" height="400">

A volcano plot of differentially expressed genes between euploid yeast colonies versus aneuploid yeast colonies. The x-axis represents the difference in gene expression between the conditions. False discovery rate (FDR), a method for controlling for multiple testing, is along the y-axis. Each point represents a tested gene (N=3,926). Red points are those reaching genome-wide significance (at FDR<0.05, N=663), whereas grey points are genes not reaching statistical significance (FDR>0.05, N=3,263). Data provided by Mulla et al. (https://elifesciences.org/articles/27991). 

<img src="images/barplot_sig.png" width="700" height="500">

The relative enrichment of chrX for differentially expressed genes suggests the downstream results of this processing pipeline are consistent with biological expectations. The RNA-seq experiment was performed on yeast colonies with an extra chromosome X. Data provided by Mulla et al. (https://elifesciences.org/articles/27991). 

# ChIP-Seq

The following data presents the ChIP-Seq data used in this tutorial. This tutorial observes ChIP-Seq data of induction by 3-AT in Yeast (source: https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP132584).

|            |              |            |        |        |            |            |             |                                               |                        |        |            |             |             |         |                    |                    |            |             |               |                  |                |            |                          |          |             |           | 
|------------|--------------|------------|--------|--------|------------|------------|-------------|-----------------------------------------------|------------------------|--------|------------|-------------|-------------|---------|--------------------|--------------------|------------|-------------|---------------|------------------|----------------|------------|--------------------------|----------|-------------|-----------| 
| AvgSpotLen | BioSample    | Experiment | MBases | MBytes | Run        | SRA_Sample | Sample_Name | genotype                                      | source_name            | strain | Assay_Type | BioProject  | Center_Name | Consent | DATASTORE_filetype | DATASTORE_provider | InsertSize | Instrument  | LibraryLayout | LibrarySelection | LibrarySource  | LoadDate   | Organism                 | Platform | ReleaseDate | SRA_Study | 
| 148        | SAMN08513506 | SRX3677830 | 8816   | 3690   | SRR6703656 | SRS2938492 | GSM2991004  | MATa ade2-1 can1-100 leu2-3,112 trp1-1 ura3-1 | Untreated              | YDC111 | RNA-Seq    | PRJNA433659 | GEO         | public  | sra                | ncbi               | 0          | NextSeq 500 | PAIRED        | cDNA             | TRANSCRIPTOMIC | 2018-02-09 | Saccharomyces cerevisiae | ILLUMINA | 2018-02-27  | SRP132584 | 
| 148        | SAMN08513513 | SRX3677835 | 9614   | 4022   | SRR6703661 | SRS2938497 | GSM2991009  | MATa ade2-1 can1-100 leu2-3,112 trp1-1 ura3-1 | 3AT-treated for 40 min | YDC111 | RNA-Seq    | PRJNA433659 | GEO         | public  | sra                | ncbi               | 0          | NextSeq 500 | PAIRED        | cDNA             | TRANSCRIPTOMIC | 2018-02-09 | Saccharomyces cerevisiae | ILLUMINA | 2018-02-27  | SRP132584 | 
| 150        | SAMN08513512 | SRX3677836 | 6049   | 2749   | SRR6703662 | SRS2938498 | GSM2991010  | MATa ade2-1 can1-100 leu2-3,112 trp1-1 ura3-1 | Untreated              | YDC111 | RNA-Seq    | PRJNA433659 | GEO         | public  | sra                | ncbi               | 0          | NextSeq 500 | PAIRED        | cDNA             | TRANSCRIPTOMIC | 2018-02-09 | Saccharomyces cerevisiae | ILLUMINA | 2018-02-27  | SRP132584 | 
| 150        | SAMN08513511 | SRX3677837 | 6918   | 3140   | SRR6703663 | SRS2938499 | GSM2991011  | MATa ade2-1 can1-100 leu2-3,112 trp1-1 ura3-1 | 3AT-treated for 40 min | YDC111 | RNA-Seq    | PRJNA433659 | GEO         | public  | sra                | ncbi               | 0          | NextSeq 500 | PAIRED        | cDNA             | TRANSCRIPTOMIC | 2018-02-09 | Saccharomyces cerevisiae | ILLUMINA | 2018-02-27  | SRP132584 | 

<img src="images/igv1.png" width="1000" height="200">

Distribution of intersected peaks across the yeast genome. This IGV screenshot shows in the bottom row the intersected peaks between the two treatment conditions of the yeast samples. The matching genes with each intersected peak can be analyzed. 

# Authors
+ Syed Hussain Ather (shussainather@gmail.com) (http://hussainather.com)
+ Olaitan Awe (laitanawe@gmail.com)
+ TJ Butler (tjbutler003@gmail.com)
+ Tamiru Denka (tamiru.dank@nih.gov)
+ Stephen Semick (stephen.semick@libd.org)
+ Wanhu Tang (tangw2@niaid.nih.gov)
