from pandas import read_csv
import os

ChIPSeqSRARunTableFile='data/ChIPSeqSRA.tsv'
ChIPSeqSRATable = read_csv(ChIPSeqSRARunTableFile, delimiter='\t')
ChIPSeqoutrun = (ChIPSeqSRATable["Run"])
ChIPSeqoutputSortBam = "test/" + ChIPSeqoutrun + ".sorted.bam"

for run in ChIPSeqoutputSortBam:
    os.system("multiqc {0} --quiet --outdir test/multiqc_chipseq --force".format(run))
