#Download all the files specified in data/filenames
for url in $(cat decont/data/urls) #TODO
do
    bash scripts/download.sh $urls data
done

# Download the contaminants fasta file, uncompress it, and
# filter to remove all small nuclear RNAs
bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes #TODO

# Index the contaminants file
bash scripts/index.sh res/contaminants.fasta res/contaminants_indx

# Merge the samples into a single file
for sid in $(ls decont/data/*.fastq.gz) #TODO
do
    bash scripts/merge_fastqs.sh data out/merged $sid
done

# TODO: run cutadapt for all merged files
do
	cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
	-o /home/vant/decont/out/trimmed/C57BL_6NJ_1s.trimmed.fastq.gz \
	-p /home/vant/decont/out/trimmed/C57BL_6NJ_1s.trimmed.fastq.gz \
	/home/vant/decont/data/C57BL_6NJ-12.5dpp.1.1s_sRNA.fastq.gz /home/vant/decont/data/C57BL_6NJ-12.5dpp.1.1s_sRNA.fastq.gz > /home/vant/decont/log/cutadapt/C57BL_6NJ.log
done

do
	cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
        -o /home/vant/decont/out/trimmed/SPRET_EiJ_1s.trimmed.fastq.gz \ 
        -p /home/vant/decont/out/trimmed/SPRET_EiJ_2s.trimmed.fastq.gz \ 
        /home/vant/decont/data/SPRET_EiJ-12.5dpp.1.1s_sRNA.fastq.gz /home/vant/decont/data/SPRET_EiJ-12.5dpp.1.1s_sRNA.fastq.gz > /home/vant/decont/log/cutadapt/SPRET_EiJ.log
done

# TODO: run STAR for all trimmed files
for fname in decont/out/trimmed/*.fastq.gz
do
    # you will need to obtain the sample ID from the filename
    # sid=#TODO
	sid=$(echo $fname | sed 's:out/trimmed/::' | cut -d "." -f1)
	mkdir -p decont/out/star/${sid}
        STAR --runThreadN 4 --genomeDir decont/res/contaminants_indx \
           --outReadsUnmapped Fastx --readFilesIn $fname \
           --readFilesCommand gunzip -c --outFileNamePrefix decont/out/star/${sid}
done 

# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
# tip: use grep to filter the lines you're interested in

for sampleid in $(ls decont/data/*.fastq.gz | cut -d "-" -f1 | sed 's:data/::' | sort)
do

	echo "Cutadpat: " >> log/pipeline.log
	echo $(cat log/cutadapt | grep -i "Complete reads") >> log/pipeline.log
	echo $(cat log/cutadapt | grep -i "Total pairs") >> log/pipeline.log
  
	echo "STAR: " >> log/pipeline.log
	echo $(cat out/star | grep -e "Proportion for mapped reads") >> log/pipeline.log
	echo $(cat out/star | grep -e "Proportion for mapped reads (multiple loci)") >> log/pipeline.log>
	echo $(cat out/star | grep -e "Proportion for mapped reads (many loci)") >> log/pipeline.log>

done

