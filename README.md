# OmicsEdu

![Logo](images/logo.png)

# What is OmicsEdu?

OmicsEdu is an educational pipeline for RNA-Seq and ChIP-Seq analysis intended for scientists and science enthusiasts. No prior background in programming or biology is required. 

![Workflow](images/pipeline.png)

This tutorial works using HISAT2 aligner to align sample reads to a reference.

![Alignment](images/alignment.png)

Then it performs MultiQC to extract quality control information from the aligned reads.

It uses quantification methods (salmon for RNA-Seq and peak-calling for ChIP-Seq) to quantify expression and determine protein-binding. 

The output is analyzed (differential gene expression for RNA-Seq and peak analysis for ChIP-seq). 

Finally the results are visualized.

The model organism for this project is Yeast i.e. <i>Saccharomyces cerevisiae</i>. For RNA-Seq, yeast data between euploid and aneuoploid conditions will be compared. For ChIP-SEq, yeast data between 3AT-treated and untreated conditions will be compared.

# RNA-Seq

This is where we will put sample RNA-Seq input and output.

# ChIP-Seq

This is where we will put sample ChIP-Seq input and output. 

# To-do

+ Add Docker-level containerization

+ Add images and explanations

+ Create visualizations of output 

# Abstract
Quantification of gene expression and characterization of gene transcript structures are central problems in molecular biology. RNA Sequencing (RNA-Seq) and Chromatin Immuno-Precipitation Sequencing (ChIP-seq) experiments generate large amounts of data that necessitate pipelines to analyze these data in an efficient manner and therefore gain insight.
<br />
Existing tools target specific tasks in the analysis pipeline such as quality control or mapping, while others offer an all-in-one solution but these tools are more geared towards the advanced users.
<br />
In this project, we present OmicsEdu, a user-friendly jupyter notebook-based educational pipeline for RNA-Seq and epigenomic data analysis and our goal was to build a tool which is easy to use even with no programming experience.
<br />
With this tool, we hope that researchers of all categories of experience level will be able to easily analyse their epigenomic and RNA-Seq data.

<b>Keywords</b>:
<i>RNA-Seq, ChIP-Seq, education, alignment, assembly</i>

## Requirements

### Terminal emulator

Mac and Linux systems come with Terminal installed, and Windows systems come with Console.  

### Jupyter notebook

Installation instructions: http://jupyter.readthedocs.io/en/latest/install.html

# How do I use this tutorial?

1. Identify the terminal emulator program on your computer. Mac and Linux systems come with Terminal installed, and Windows systems come with Console. If there isn't one installed, download one online. 

2. Open a command line program (such as Terminal).

3. Type `pwd` and press enter. This command shows what your current working directory is. Typing commands and pressing enter will be the primary way of running commands in this tutorial. Type `ls` to display which directories and files are in this current directory.

4. If you'd like to use the tutorial in this current working directory, skip to step 5. Otherwise, you may make a new directory or move to another one. To make a new directory, run `mkdir DIRECTORY` in which DIRECTORY is the name of the directory you'd like to make. To move to another directory, run `cd DIRECTORY` in which DIRECTORY is the name of the DIRETORY you'd like to move to. To move up a directory, run `cd ..`. 

5. Run `git clone https://github.com/NCBI-Hackathons/omicsedu.git`

6. Run `cd omicsedu`.

7. Run `jupyter notebook` to launch jupyter notebook.

8. Click `jupyter`, then `tutorial.ipynb` and follow the instructions of the tutorial.

# Authors
+ Syed Hussain Ather (shussainather@gmail.com)
+ Olaitan Awe (laitanawe@gmail.com)
+ TJ Butler (tjbutler003@gmail.com)
+ Tamiru Denka (tamiru.dank@nih.gov)
+ Stephen Semick (stephen.semick@libd.org)
+ Wanhu Tang (tangw2@niaid.nih.gov)
