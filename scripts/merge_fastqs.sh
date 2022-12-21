# This script should merge all files from a given sample (the sample id is
# provided in the third argument ($3)) into a single file, which should be
# stored in the output directory specified by the second argument ($2).
#
# The directory containing the samples is indicated by the first argument ($1).


mkdir out/merged
cat "C57BL_6NJ_1s.trimmed.fastq.gz C57BL_6NJ_2s.trimmed.fastq.gz > C57BL_6NJ.trimmed.fastq.gz" 
cat "SPRET_EiJ_1s.trimmed.fastq.gz SPRET_EiJ_2s.trimmed.fastq.gz > SPRET_EiJ.trimmed.fastq.gz"
