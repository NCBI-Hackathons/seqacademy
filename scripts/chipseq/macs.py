from pandas import read_csv
import os

"""
Run MACS to count peaks among the aligned reads.
"""

ChIPSeqSRARunTableFile='data/ChIPSeqSRA.tsv'
ChIPSeqSRATable = read_csv(ChIPSeqSRARunTableFile, delimiter='\t')
ChIPSeqoutrun = (ChIPSeqSRATable["Run"])
ChIPSeqoutputSam = "test/" + ChIPSeqoutrun + ".sam"
ChIPSeqoutputAlignmentSummary = "test/" + ChIPSeqoutrun + ".txt"
ChIPSeqoutputMetrics = "test/" + ChIPSeqoutrun + ".metrics"
ChIPSeqoutputSortBam = "test/" + ChIPSeqoutrun + ".sorted.bam"

ChIPSeqControl = ChIPSeqSRATable.loc[ChIPSeqSRATable["source_name"] == "Untreated"]["Run"]
ChIPSeqTreatment = ChIPSeqSRATable.loc[ChIPSeqSRATable["source_name"] != "Untreated"]["Run"]

for index, individual in enumerate(ChIPSeqControl):
    outputdirectory = "test/" + ChIPSeqTreatment.iloc[index]
    name = ChIPSeqTreatment.iloc[index]
    print("name " + str(name))
    immunoprecipitate = "test/" + ChIPSeqTreatment.iloc[index] + ".sorted.bam"
    print("ip " + str(immunoprecipitate))
    control = "test/" + ChIPSeqControl.iloc[index] + ".sorted.bam"
    print("control " + str(control))
    os.system("macs2 callpeak --nomodel -c {0} -t {1} -n {2} --outdir {3}".format(control, immunoprecipitate, name, outputdirectory))

