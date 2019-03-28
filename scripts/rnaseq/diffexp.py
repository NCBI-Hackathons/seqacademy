from pandas import read_csv

import glob
import os

"""
Python script for calling each HTSeq count file and running diffexp.R on it.
"""

f = "data/RNASeqSRA.tsv"
df = read_csv(f, delimiter='\t')
condition = df["karyotype"]

os.chdir("test")
count = 0
for file in glob.glob("*genecount.txt"):
     samplename = file.replace(".sorted.bam.genecount.txt", "")
     samplecondition = condition[count] 
     os.system("Rscript ../scripts/rnaseq/diffexp.R %s %s %s" % (file, samplename, samplecondition))
     count += 1
