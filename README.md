# OmicsEdu

![Logo](images/logo.png)

# What is OmicsEdu?

OmicsEdu is an educational pipeline for RNA-Seq and epigenomics analysis. It uses jupyter notebook.

![Workflow](images/pipeline.png)

It works using HISAT2 aligner to align sample reads to a reference.

![Alignment](images/alignment.png)

Then it performs MultiQC to extract quality control information from the aligned reads.

It uses quantification methods (salmon for RNA-Seq and peak-calling for ChIP-Seq) to quantify expression and determine protein-binding. 

The output is analyzed (differential gene expression for RNA-Seq and peak analysis for ChIP-seq). 

Finally the results are visualized.

The model organism for this project is Yeast i.e. <i>Saccharomyces cerevisiae</i>.

# RNA-Seq

This is where we will put sample RNA-Seq input and output.

# ChIP-Seq

This is where we will put sample ChIP-Seq input and output. 

# To-do

+ Add Docker-level containerization

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

# Authors
+ Syed Hussain Ather (shussainather@gmail.com)
+ Olaitan Awe (laitanawe@gmail.com)
+ Tamiru Denka (tamiru.dank@nih.gov)
+ Stephen Semick (stephen.semick@libd.org)
+ Wanhu Tang (tangw2@niaid.nih.gov)
+ TJ Butler (tjbutler003@gmail.com)
