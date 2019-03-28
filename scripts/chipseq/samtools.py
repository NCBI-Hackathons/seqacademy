import os
from pandas import read_csv

"""
Run samtools to sort the reads.
"""

ChIPSeqSRARunTableFile='data/ChIPSeqSRA.tsv'
ChIPSeqSRATable = read_csv(ChIPSeqSRARunTableFile, delimiter='\t')
ChIPSeqoutrun = (ChIPSeqSRATable["Run"])
ChIPSeqoutputSam = "test/" + ChIPSeqoutrun + ".sam"
ChIPSeqoutputAlignmentSummary = "test/" + ChIPSeqoutrun + ".txt"
ChIPSeqoutputMetrics = "test/" + ChIPSeqoutrun + ".metrics"
ChIPSeqoutputSortBam = "test/" + ChIPSeqoutrun + ".sorted.bam"

print("ChIP-Seq run " + ChIPSeqoutrun)

ChIPSeqControl = ChIPSeqSRATable.loc[ChIPSeqSRATable["source_name"] == "Untreated"]["Run"]
ChIPSeqTreatment = ChIPSeqSRATable.loc[ChIPSeqSRATable["source_name"] != "Untreated"]["Run"]

print("Control sample " + ChIPSeqControl)
print("Treatment sample " + ChIPSeqTreatment)

for index, individual in enumerate(ChIPSeqoutrun):
    sam = ChIPSeqoutputSam[index]
    bam = ChIPSeqoutputSortBam[index]
    os.system("samtools view -bSF4 {0} | samtools sort -o {1}".format(sam, bam))

