import os

os.system(
    """
    bowtie2-build input params
    """
)

os.system(
    """
    bowtie2 \
    -x params \
    -U input.fastq  \
    -S output.sam \
    2> logs/bowtie-map.log && \
    samtools view -Sbh output.sam > output && \
    rm output.sam
    """)
