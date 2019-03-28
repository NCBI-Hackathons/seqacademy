import glob
import os

"""
Python script for calling each HTSeq count file and running diffexp.R on it.
"""

os.chdir("test")
for file in glob.glob("*genecount.txt"):
     os.system("Rscript ../scripts/rnaseq/diffexp.R %s" % file)
