from pandas import read_csv

import glob
import os

"""
Python script for calling each HTSeq count file and running diffexp.R on it.
"""

RNASeqSRARunTableFile = "data/RNASeqSRA.tsv"
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSam = "test/" + RNASeqoutrun + ".sam"
RNASeqoutputAlignmentSummary = "test/" + RNASeqoutrun + ".txt"
RNASeqoutputMetrics = "test/" + RNASeqoutrun + ".metrics"
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

os.chdir("test")
for file in glob.glob("*genecount.txt"):
     samplename = file.replace(".sorted.bam.genecount.txt", "") 
     os.system("Rscript ../scripts/rnaseq/diffexp.R %s" % file)
