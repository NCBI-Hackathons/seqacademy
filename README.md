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

+ Write-up 

+ Create Jupyter notebook overview

+ Test

# Authors

+ Syed Hussain Ather (shussainather@gmail.com)

+ Olaitan Awe (laitanawe@gmail.com)

+ Tamiru Denka (tamiru.dank@nih.gov)

+ Stephen Semick (stephen.semick@libd.org)

+ Wanhu Tang (tangw2@niaid.nih.gov)

+ TJ Butler (tjbutler003@gmail.com)
