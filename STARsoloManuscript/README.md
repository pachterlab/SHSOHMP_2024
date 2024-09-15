# STARSolo simulation

On tolva, everything is downloaded into: /home/dsullivan/HSSHMP_2024/STARsoloManuscript/

## Download and run simulation (March 28, 2023)

<pre>cd ..
rm -rf STARsoloManuscript
git clone https://github.com/dobinlab/STARsoloManuscript
cd STARsoloManuscript
git checkout d5cfb6bf80861ccf9d19ccd99026d131c476d095 # (May 25, 2021 commit)

make -C samples

make -C exe # Gives errors: "make: *** [Makefile:26: kbpy_0.25.0] Error 1" but oh well

make -C exe gffread # Make sure we don't skip over installing gffread

cat genomes/Makefile|sed 's/Genomes/genomes/' > genomes/Makefile2
mv genomes/Makefile2 genomes/Makefile
make -C genomes # Needed to edit Makefile (to make Genomes lower-case) above otherwise the files can't be found

# The above command still has error "make: *** [Makefile:23: human_CR_3.0.0/refdata-cellranger-GRCh38-3.0.0] Error 8", so do the following:

mv genomes/human_CR_3.0.0/labshare.cshl.edu/shares/dobin/dobin/STARsolo/Preprint/genomes/refdata-cellranger-GRCh38-3.0.0/fasta/genome.fa genomes/human_CR_3.0.0/
mv genomes/human_CR_3.0.0/labshare.cshl.edu/shares/dobin/dobin/STARsolo/Preprint/genomes/refdata-cellranger-GRCh38-3.0.0/genes/genes.gtf genomes/human_CR_3.0.0/annotations.gtf

samtools faidx genomes/human_CR_3.0.0/genome.fa

./exe/gffread -w genomes/human_CR_3.0.0/transcripts.fa -g genomes/human_CR_3.0.0/genome.fa genomes/human_CR_3.0.0/annotations.gtf

awk '$3=="transcript" {gene=$0; gsub(/.*gene_id "/,"",gene); gsub(/".*/,"",gene); tr=$0; gsub(/.*transcript_id "/,"",tr); gsub(/".*/,"",tr); print tr "\t" gene }' \
	    genomes/human_CR_3.0.0/annotations.gtf > genomes/human_CR_3.0.0/transcript_to_gene.txt && \
	awk '{print $1 "\t" $2}' genomes/human_CR_3.0.0/transcript_to_gene.txt > genomes/human_CR_3.0.0/transcript_to_gene.2col.txt
awk '{if (!($2 in G)) print $2; G[$2]=0}'  genomes/human_CR_3.0.0/transcript_to_gene.txt > genomes/human_CR_3.0.0/genes.tsv

aa=$(pwd|sed 's/\//\\\//g') && cat Mf.common|sed 's/\/scratch\/dobin\/STAR\/STARsoloManuscript\//'"$aa"'\//' > Mf.common2
mv Mf.common2 Mf.common

cat data/Makefile|sed 's/Data/data/' > data/Makefile2
mv data/Makefile2 data/Makefile

make -C data

rm -f ./genomes/human_CR_3.0.0/genome_transcripts*

make -C sims
cd ..
</pre>

## Download simulations that were already run

<pre>cd ..
rm -rf STARsoloManuscript
curl -s https://api.github.com/repos/pachterlab/SHSOHMP_2024/releases/latest \
| grep "browser_download_url" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
cat STARsoloManuscript_* > STARsoloManuscript.tar.gz
tar -xzvf STARsoloManuscript.tar.gz
</pre>

# Create symlinks to executables

<pre>ln -sf $(pwd)/../kallisto_0.48.0/kallisto exe/kallisto_0.48.0
ln -sf $(pwd)/../kallisto_0.50.0/kallisto exe/kallisto_0.50.0
ln -sf $(pwd)/../kallisto_0.50.1/kallisto exe/kallisto_0.50.1
ln -sf $(pwd)/../bustools/build/src/bustools exe/bustools_0.43.2
ln -sf $(pwd)/../cellranger/cellranger-7.0.1/cellranger exe/CellRanger_7.0.1
ln -sf $(pwd)/../salmon-latest_linux_x86_64/bin/salmon exe/salmon_1.10.0
ln -sf $(pwd)/../.cargo/bin/alevin-fry exe/alevin-fry_0.8.2
ln -sf $(pwd)/../.cargo/bin/alevin-fry exe/simpleaf_0.15.1</pre>

# Create indices

## Human (already packaged)

<pre>genome_name="human_CR_3.0.0"
genome_file="genomes/$genome_name/genome.fa"
transcripts_file="genomes/$genome_name/transcripts.fa"
gtf_file="genomes/$genome_name/annotations.gtf"
n_threads="20"</pre>

## kallisto (kb-python) - Human

Note: For kallisto 0.48.0, multithreading not supported so need to supply -t 1 (in order to prevent the -t option from appearing the into kallisto index command).

### No D-list (standard)

<pre>out_dir="genomes/index/kallisto_0.48.0/$genome_name/standard_1"
mkdir -p $out_dir
kb ref -t 1 --overwrite --d-list="" -i $out_dir/index.idx --kallisto exe/kallisto_0.48.0 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.0/$genome_name/standard_1"
mkdir -p $out_dir
kb ref --overwrite --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.0 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_1"
mkdir -p $out_dir
kb ref --overwrite --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### D-list (standard)

<pre>out_dir="genomes/index/kallisto_0.50.0/$genome_name/standard_offlist_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.0 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlist_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

#### Overhangs

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlistoverhang2_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file --d-list-overhang=2 -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlistoverhang3_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file --d-list-overhang=3 -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlistoverhang4_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file --d-list-overhang=4 -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlistoverhang5_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file --d-list-overhang=5 -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlistoverhang6_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file --d-list-overhang=6 -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### No D-list (nac)


<pre>out_dir="genomes/index/kallisto_0.48.0/$genome_name/nac_1"
mkdir -p $out_dir
kb ref -t 1 --d-list="" -i $out_dir/index.idx --kallisto exe/kallisto_0.48.0 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.0/$genome_name/nac_1"
mkdir -p $out_dir
kb ref --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.0 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_1"
mkdir -p $out_dir
kb ref --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### D-list (nac)


<pre>out_dir="genomes/index/kallisto_0.50.0/$genome_name/nac_offlist_1"
mkdir -p $out_dir
kb ref -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.0 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlist_1"
mkdir -p $out_dir
kb ref -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


#### Overhangs

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlistoverhang2_1"
mkdir -p $out_dir
kb ref -t $n_threads --d-list-overhang=2 -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlistoverhang3_1"
mkdir -p $out_dir
kb ref -t $n_threads --d-list-overhang=3 -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlistoverhang4_1"
mkdir -p $out_dir
kb ref -t $n_threads --d-list-overhang=4 -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlistoverhang5_1"
mkdir -p $out_dir
kb ref -t $n_threads --d-list-overhang=5 -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlistoverhang6_1"
mkdir -p $out_dir
kb ref -t $n_threads --d-list-overhang=6 -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>


## STAR

<pre>out_dir="genomes/index/STAR_2.7.9a/$genome_name"
mkdir -p $out_dir/fullSA
exe/STAR_2.7.9a --runMode genomeGenerate --runThreadN $n_threads --genomeDir $out_dir/fullSA --genomeFastaFiles $genome_file --sjdbGTFfile $gtf_file > $out_dir/fullSA/log.txt 2>&1
mkdir -p $out_dir/sparseSA3
exe/STAR_2.7.9a --runMode genomeGenerate --runThreadN $n_threads --genomeDir $out_dir/sparseSA3 --genomeSAsparseD 3 --genomeFastaFiles $genome_file --sjdbGTFfile $gtf_file > $out_dir/sparseSA3/log.txt 2>&1</pre>

## salmon

### standard

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/standard
runCommand="exe/salmon_1.10.0 index -t $transcripts_file --gencode -i $out_dir/standard/index -p $n_threads"
echo "$runCommand" > $out_dir/standard/log && $runCommand &>> $out_dir/standard/log</pre>

### splici (dense+sparse; for read length 91)

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/splici
pyroe make-splici "$genome_file" "$gtf_file" 91 $out_dir/splici/salmon_splici_91 --flank-trim-length 5 --filename-prefix splici
runCommand="exe/salmon_1.10.0 index -t $out_dir/splici/salmon_splici_91/splici_fl86.fa --gencode -i $out_dir/splici/index -p $n_threads"
echo "$runCommand" > $out_dir/splici/log && $runCommand &>> $out_dir/splici/log
# Make sparse variant:
mkdir -p $out_dir/splici_sparse
cp -R $out_dir/splici/salmon_splici_91/ $out_dir/splici_sparse/salmon_splici_91/
runCommand="exe/salmon_1.10.0 index -t $out_dir/splici_sparse/salmon_splici_91/splici_fl86.fa --gencode -i $out_dir/splici_sparse/index -p $n_threads --sparse"
echo "$runCommand" > $out_dir/splici_sparse/log && $runCommand &>> $out_dir/splici_sparse/log</pre>


### spliceu (dense+sparse)

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/spliceu
pyroe make-spliceu "$genome_file" "$gtf_file" $out_dir/spliceu/salmon_spliceu --filename-prefix spliceu
runCommand="exe/salmon_1.10.0 index -t $out_dir/spliceu/salmon_spliceu/spliceu.fa --gencode -i $out_dir/spliceu/index -p $n_threads"
echo "$runCommand" > $out_dir/spliceu/log && $runCommand &>> $out_dir/spliceu/log
# Make sparse variant:
mkdir -p $out_dir/spliceu_sparse
cp -R $out_dir/spliceu/salmon_spliceu/ $out_dir/spliceu_sparse/salmon_spliceu/
runCommand="exe/salmon_1.10.0 index -t $out_dir/spliceu_sparse/salmon_spliceu/spliceu.fa --gencode -i $out_dir/spliceu_sparse/index -p $n_threads --sparse"
echo "$runCommand" > $out_dir/spliceu_sparse/log && $runCommand &>> $out_dir/spliceu_sparse/log</pre>

#### Additional splici (for read length 150)

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/splici
pyroe make-splici "$genome_file" "$gtf_file" 150 $out_dir/splici/salmon_splici_150 --flank-trim-length 5 --filename-prefix splici
runCommand="exe/salmon_1.10.0 index -t $out_dir/splici/salmon_splici_150/splici_fl145.fa --gencode -i $out_dir/splici/i150 -p $n_threads"
echo "$runCommand" > $out_dir/splici/log150 && $runCommand &>> $out_dir/splici/log150
# Make sparse variant:
mkdir -p $out_dir/splici_sparse
cp -R $out_dir/splici/salmon_splici_150/ $out_dir/splici_sparse/salmon_splici_150/
runCommand="exe/salmon_1.10.0 index -t $out_dir/splici_sparse/salmon_splici_150/splici_fl145.fa --gencode -i $out_dir/splici_sparse/i150 -p $n_threads --sparse"
echo "$runCommand" > $out_dir/splici_sparse/log150 && $runCommand &>> $out_dir/splici_sparse/log150</pre>


## Cell Ranger
Cell ranger apparently always deposits the index into the directory from which it is run. Hence, we generate the indices and then `mv` them to the desired location.
<pre>out_dir="genomes/index"
exe/CellRanger_7.0.1 mkref --genes=$gtf_file --fasta=$genome_file --genome=$genome_name --nthreads=$n_threads
mkdir -p $out_dir/cellranger7/$genome_name
mv $genome_name $out_dir/cellranger7/$genome_name
</pre>

## cellCounts

<pre>out_dir="genomes/index/cellCounts/$genome_name"
mkdir -p $out_dir
Rscript ./cellCounts_index.R $out_dir $genome_file
</pre>



# Makefiles

Replace the Makefile and Mf* files in the STARsoloManuscript directory with the ones here

## Make sure Mf.common references the correct path to the STARSoloManuscript directory

<pre>sed -i 's?dd:=.*?dd:='`pwd`'/?' Mf.common</pre>

## Make sure links to sim FASTQ files are correct

<pre>ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/CBUMI.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R1_.fq
ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/cDNA.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq
ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneYes/CBUMI.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/_R1_.fq
ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneYes/cDNA.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/_R2_.fq
</pre>

# Run simulations

Clear simulations:

<pre>rm -rf count/</pre>

Run on simulated data:

<pre>export PATH=$(pwd)/../.cargo//bin:$PATH
export ALEVIN_FRY_HOME=$(pwd)/../af_home
make sims_run</pre>

# CellRanger simulations

First generate the CellRanger indices as described previously

CellRanger requires its inputs to adhere to a very specific format

<pre>

# For CellRanger v7, we need to make FASTQ headers consistent between R1 and R2
# Also need to format the files to be Sample_S1_L00X_R1_001.fastq.gz, which is what CellRanger requires

mkdir -p CR7_10xV3_format
mkdir -p CR7_10xV3_format_multigene
mkdir -p CR7_10xV3_format_exononly
	
cp samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R1_.fq CR7_10xV3_format/5k_pbmc_sims_v3_S1_L001_R1_001.fastq
cat samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq|awk '{ if ($0 ~ "^@") gsub(/_[^_]*$/, ""); print }' >  CR7_10xV3_format/5k_pbmc_sims_v3_S1_L001_R2_001.fastq
gzip -v CR7_10xV3_format/5k_pbmc_sims_v3_S1_L001_R1_001.fastq CR7_10xV3_format/5k_pbmc_sims_v3_S1_L001_R2_001.fastq

cp samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/_R1_.fq CR7_10xV3_format_multigene/5k_pbmc_sims_v3_S1_L001_R1_001.fastq
cat samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/_R2_.fq|awk '{ if ($0 ~ "^@") gsub(/_[^_]*$/, ""); print }' >  CR7_10xV3_format_multigene/5k_pbmc_sims_v3_S1_L001_R2_001.fastq
gzip -v CR7_10xV3_format_multigene/5k_pbmc_sims_v3_S1_L001_R1_001.fastq CR7_10xV3_format_multigene/5k_pbmc_sims_v3_S1_L001_R2_001.fastq

cp samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/_R1_.fq CR7_10xV3_format_exononly/5k_pbmc_sims_v3_S1_L001_R1_001.fastq
cat samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/_R2_.fq|awk '{ if ($0 ~ "^@") gsub(/_[^_]*$/, ""); print }' >  CR7_10xV3_format_exononly/5k_pbmc_sims_v3_S1_L001_R2_001.fastq
gzip -v CR7_10xV3_format_exononly/5k_pbmc_sims_v3_S1_L001_R1_001.fastq CR7_10xV3_format_exononly/5k_pbmc_sims_v3_S1_L001_R2_001.fastq

# Now process for CellRanger 7
	
index="genomes/index/cellranger7/$genome_name/$genome_name"
exe/CellRanger_7.0.1 count --include-introns=false --id=output_cellranger_7 --fastqs=CR7_10xV3_format --sample=5k_pbmc_sims_v3 --lanes=1 --transcriptome=$index --localcores=$n_threads
exe/CellRanger_7.0.1 count --include-introns=false --id=output_cellranger_7_multigene --fastqs=CR7_10xV3_format_multigene --sample=5k_pbmc_sims_v3 --lanes=1 --transcriptome=$index --localcores=$n_threads
exe/CellRanger_7.0.1 count --include-introns=false --id=output_cellranger_7_exononly --fastqs=CR7_10xV3_format_exononly --sample=5k_pbmc_sims_v3 --lanes=1 --transcriptome=$index --localcores=$n_threads
</pre>

# cellCounts simulations

<pre>mkdir -p output_cellCounts
Rscript cellCounts_run.R CR7_10xV3_format genomes/index/cellCounts/$genome_name/default $gtf_file ./data/whitelists/10Xv3 UNIQUE output_cellCounts
mkdir -p output_cellCounts_mult
Rscript cellCounts_run.R CR7_10xV3_format_multigene genomes/index/cellCounts/$genome_name/default $gtf_file ./data/whitelists/10Xv3 MULT output_cellCounts_mult
mkdir -p output_cellCounts_exon
Rscript cellCounts_run.R CR7_10xV3_format_exononly genomes/index/cellCounts/$genome_name/default $gtf_file ./data/whitelists/10Xv3 UNIQUE output_cellCounts_exon
</pre>

# Make truth MatrixMarket files

The original truth.mtx files (gene-by-cell matrices) from the simulation don't contain the metadata headers, so we need to reformat those files:

<pre>mkdir -p truth_pbmc_5k_sims</pre>

<pre>./makemtx.sh samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 truth_pbmc_5k_sims/truth.mtx</pre>
<pre>./makemtx.sh samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 truth_pbmc_5k_sims/truth_multigene.mtx</pre>
<pre>./makemtx.sh samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads/truth.mtx genomes/human_CR_3.0.0/genes.tsv data/whitelists/10Xv3 truth_pbmc_5k_sims/truth_exononly.mtx</pre>

# Filter for relevant barcodes

See **knee.ipynb**

5000 cells is the threshold (which occurs at mininimum of 667 UMIs). This is done on the default simulated data (pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo) and these cell barcodes are used for all further analysis.

The outputted 5000 barcodes are stored in **sim_barcodes.txt**

# Generate results from simulations

Run python script (comparisons.py) with 7 arguments: 1) truth matrix, 2) truth genes list, 3) truth barcode list, 4) program matrix, 5) program genes list, 6) program barcodes list, 7) output file name.

## kallisto comparisons against truth matrix

<pre>mkdir -p results</pre>

<pre>
./kallisto_comparisons.sh
</pre>

## Other programs' comparisons against truth matrix

<pre>./af_comparisons.sh</pre>
<pre>./star_comparisons.sh</pre>
<pre>./cellranger_cellcounts_comparisons.sh</pre>

These scripts run the python comparisons.py code. See Supplementary Note about the truth matrix comparisons for further details on what the comparisons output looks like.

# Get kallisto index results (i.e. number of k-mers)

<pre>mkdir -p results/indices</pre>

<pre>
for dir in "genomes/index/kallisto_0.50.1/human_CR_3.0.0/"*/; do
    if [[ -f "$dir/index.idx" ]]; then
	idxname=$(basename ${dir})
        exe/kallisto_0.50.1 inspect -t 20 "$dir/index.idx" &> results/indices/${idxname}.txt
    fi
done
</pre>

# Analyze results

See analysis_kallisto.ipynb Jupyter notebook.

See analysis_other.ipynb Jupyter notebook.


# Getting performance differences between kallisto versions on real data

We'll use lane 001 of the 5k_pbmc_v3 data from 10X genomics (96,285,389 reads)

<pre>mkdir -p results_kallisto_version_performances/temp/</pre>

## kallisto calls

### Version 0.50.1 (with d-list)

<pre>kversion="kallisto_0.50.1"
rm -rf results_kallisto_version_performances/temp/*
/usr/bin/time -v kb count --kallisto exe/$kversion --bustools exe/bustools_0.43.2 \
-t 8 -x 10XV3 --workflow nac -i genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1/index.idx \
-g genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//g \
-c1 genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//c1 -c2 genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//c2 \
-o ./results_kallisto_version_performances/temp/ \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R1_001.fastq.gz \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R2_001.fastq.gz 2> results_kallisto_version_performances/${kversion}_offlist.txt</pre>

### Version 0.50.0 (with d-list)

<pre>kversion="kallisto_0.50.0"
rm -rf results_kallisto_version_performances/temp/*
/usr/bin/time -v kb count --kallisto exe/$kversion --bustools exe/bustools_0.43.2 \
-t 8 -x 10XV3 --workflow nac -i genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1/index.idx \
-g genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//g \
-c1 genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//c1 -c2 genomes/index/$kversion/human_CR_3.0.0/nac_offlist_1//c2 \
-o ./results_kallisto_version_performances/temp/ \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R1_001.fastq.gz \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R2_001.fastq.gz 2> results_kallisto_version_performances/${kversion}_offlist.txt</pre>

### Version 0.50.1 (no d-list)

<pre>kversion="kallisto_0.50.1"
rm -rf results_kallisto_version_performances/temp/*
/usr/bin/time -v kb count --kallisto exe/$kversion --bustools exe/bustools_0.43.2 \
-t 8 -x 10XV3 --workflow nac -i genomes/index/$kversion/human_CR_3.0.0/nac_1/index.idx \
-g genomes/index/$kversion/human_CR_3.0.0/nac_1//g \
-c1 genomes/index/$kversion/human_CR_3.0.0/nac_1//c1 -c2 genomes/index/$kversion/human_CR_3.0.0/nac_1//c2 \
-o ./results_kallisto_version_performances/temp/ \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R1_001.fastq.gz \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R2_001.fastq.gz 2> results_kallisto_version_performances/${kversion}.txt</pre>

### Version 0.50.0 (no d-list)

<pre>kversion="kallisto_0.50.0"
rm -rf results_kallisto_version_performances/temp/*
/usr/bin/time -v kb count --kallisto exe/$kversion --bustools exe/bustools_0.43.2 \
-t 8 -x 10XV3 --workflow nac -i genomes/index/$kversion/human_CR_3.0.0/nac_1/index.idx \
-g genomes/index/$kversion/human_CR_3.0.0/nac_1//g \
-c1 genomes/index/$kversion/human_CR_3.0.0/nac_1//c1 -c2 genomes/index/$kversion/human_CR_3.0.0/nac_1//c2 \
-o ./results_kallisto_version_performances/temp/ \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R1_001.fastq.gz \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R2_001.fastq.gz 2> results_kallisto_version_performances/${kversion}.txt</pre>

### Version 0.48.0

<pre>kversion="kallisto_0.48.0"
rm -rf results_kallisto_version_performances/temp/*
/usr/bin/time -v kb count --kallisto exe/$kversion --bustools exe/bustools_0.43.2 \
-t 8 -x 10XV3 --workflow nac -i genomes/index/$kversion/human_CR_3.0.0/nac_1/index.idx \
-g genomes/index/$kversion/human_CR_3.0.0/nac_1//g \
-c1 genomes/index/$kversion/human_CR_3.0.0/nac_1//c1 -c2 genomes/index/$kversion/human_CR_3.0.0/nac_1//c2 \
-o ./results_kallisto_version_performances/temp/ \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R1_001.fastq.gz \
samples/10X/3/pbmc_5k/5k_pbmc_v3_S1_L001_R2_001.fastq.gz 2> results_kallisto_version_performances/${kversion}.txt</pre>

## Analysis of kallisto versions performance results

See analysis_kallisto_versions.ipynb

## Mutate simulated reads

<pre>
python3 mutate.py $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/cDNA.fq 1 1 1 > _R2_1_1_1.fq
python3 mutate.py $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/cDNA.fq 4 0 0 > _R2_4_0_0.fq
python3 mutate.py $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/cDNA.fq 0 2 2 > _R2_0_2_2.fq
</pre>

Prep Makefile for simulations with the mutated reads:

<pre>cat Makefile|grep -v crlikeem|grep -v overhang[2-6]|grep -v MultiGeneYes|grep -v MultiGeneNo_OnlyExonicReads|grep -v "/standard/rad"|grep -v "/standard/sketch"|grep -v "_1/mult/"|grep -v sparseSA > Makefile_sims</pre>


### Run sims on mutated reads

Switch to mutation sims:

<pre>mv Makefile Makefile_original
mv count count_original
mkdir count
mv Makefile_sims Makefile</pre>

Run mutation sims:

<pre>export PATH=$(pwd)/../.cargo//bin:$PATH
export ALEVIN_FRY_HOME=$(pwd)/../af_home</pre>

<pre>ln -sf $(pwd)/_R2_1_1_1.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq
make sims_run
mv count count_1_1_1
mkdir count

ln -sf $(pwd)/_R2_0_2_2.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq
make sims_run
mv count count_0_2_2
mkdir count

ln -sf $(pwd)/_R2_4_0_0.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq
make sims_run
mv count count_4_0_0
mkdir count
</pre>

Revert to original:

<pre>mv Makefile Makefile_sims
mv Makefile_original Makefile
mkdir -p count
mv count count_sims
rm -rf count_sims
mv count_original count
ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/cDNA.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq
ln -sf $(pwd)/sims/bwa_map/human_CR_3.0.0/10X/3/pbmc_5k/MultiGeneNo/CBUMI.fq $(pwd)/samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R1_.fq</pre>

### Analyze mutation data

<pre>rm -rf results_mut
mkdir -p results_mut
./mut_comparisons.sh 0_2_2
./mut_comparisons.sh 1_1_1
./mut_comparisons.sh 4_0_0</pre>

For plotting, see the analysis_error_prone.ipynb python notebook.

# Mouse genome prep

<pre>genome_name="mouse"
genome_file="genomes/$genome_name/genome.fa"
transcripts_file="genomes/$genome_name/transcripts.fa"
gtf_file="genomes/$genome_name/annotations.gtf"
n_threads="20"</pre>

<pre>wget https://ftp.ensembl.org/pub/release-110/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-110/gtf/mus_musculus/Mus_musculus.GRCm39.110.gtf.gz
mkdir -p genomes/$genome_name/
gunzip -c Mus_musculus.GRCm39.dna.primary_assembly.fa.gz > $genome_file
zcat Mus_musculus.GRCm39.110.gtf.gz|grep "#!" > $gtf_file
zcat Mus_musculus.GRCm39.110.gtf.gz|grep -i "gene_biotype \"protein_coding\"" >> $gtf_file
zcat Mus_musculus.GRCm39.110.gtf.gz|grep -i "gene_biotype \"lncRNA\"" >> $gtf_file
zcat Mus_musculus.GRCm39.110.gtf.gz|grep -i "gene_biotype \"lincRNA\"" >> $gtf_file
zcat Mus_musculus.GRCm39.110.gtf.gz|grep -i "gene_biotype \"antisense\"" >> $gtf_file
</pre>

## kallisto (kb-python) index - Mouse

### No D-list (standard)

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_1"
mkdir -p $out_dir
kb ref --overwrite --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### D-list (standard)

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlist_1"
mkdir -p $out_dir
kb ref --d-list=$genome_file -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow standard --overwrite -f1 $out_dir/f1 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### No D-list (nac)

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_1"
mkdir -p $out_dir
kb ref --d-list="" -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

### D-list (nac)

<pre>out_dir="genomes/index/kallisto_0.50.1/$genome_name/nac_offlist_1"
mkdir -p $out_dir
kb ref -t $n_threads -i $out_dir/index.idx --kallisto exe/kallisto_0.50.1 --workflow nac --overwrite -f1 $out_dir/f1 -f2 $out_dir/f2 -c1 $out_dir/c1 -c2 $out_dir/c2 -g $out_dir/g $genome_file $gtf_file > $out_dir/log.txt 2>&1
</pre>

## STAR index - mouse

<pre>mkdir -p genomes/index/STAR_2.7.9a/$genome_name
exe/STAR_2.7.9a --runMode genomeGenerate --runThreadN $n_threads --genomeDir genomes/index/STAR_2.7.9a/$genome_name/fullSA --genomeFastaFiles $genome_file --sjdbGTFfile $gtf_file
exe/STAR_2.7.9a --runMode genomeGenerate --runThreadN $n_threads --genomeDir genomes/index/STAR_2.7.9a/$genome_name/sparseSA3 --genomeSAsparseD 3 --genomeFastaFiles $genome_file --sjdbGTFfile $gtf_file
</pre>

## salmon index standard - mouse

We'll use the spliced transcriptome generated from kb-python.

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/standard
runCommand="exe/salmon_1.10.0 index -t genomes/index/kallisto_0.50.1/$genome_name/nac_1/f1 --gencode -i $out_dir/standard/index -p $n_threads"
echo "$runCommand" > $out_dir/standard/log && $runCommand &>> $out_dir/standard/log</pre>

## salmon index spliceu - mouse

<pre>out_dir="genomes/index/salmon_1.10.0/$genome_name"
mkdir -p $out_dir/spliceu
pyroe make-spliceu "$genome_file" "$gtf_file" $out_dir/spliceu/salmon_spliceu --filename-prefix spliceu
runCommand="exe/salmon_1.10.0 index -t $out_dir/spliceu/salmon_spliceu/spliceu.fa -i $out_dir/spliceu/index -p $n_threads"
echo "$runCommand" > $out_dir/spliceu/log && $runCommand &>> $out_dir/spliceu/log
# Make sparse variant:
mkdir -p $out_dir/spliceu_sparse
cp -R $out_dir/spliceu/salmon_spliceu/ $out_dir/spliceu_sparse/salmon_spliceu/
runCommand="exe/salmon_1.10.0 index -t $out_dir/spliceu_sparse/salmon_spliceu/spliceu.fa -i $out_dir/spliceu_sparse/index -p $n_threads --sparse"
echo "$runCommand" > $out_dir/spliceu_sparse/log && $runCommand &>> $out_dir/spliceu_sparse/log</pre>


## cellCounts index - mouse

<pre>out_dir="genomes/index/cellCounts/$genome_name"
mkdir -p $out_dir
Rscript ./cellCounts_index.R $out_dir $genome_file</pre>

## cellRanger index - mouse

<pre>out_dir="genomes/index"
exe/CellRanger_7.0.1 mkref --genes=$gtf_file --fasta=$genome_file --genome=$genome_name --nthreads=$n_threads
mkdir -p $out_dir/cellranger7/$genome_name
mv $genome_name $out_dir/cellranger7/$genome_name</pre>

# Optional Supplementary Section

## Supplementary Note about the truth matrix comparisons: Optional

The output file (of comparisons.py) will be formatted as follows:

* First line of output file is:
* * "# num_barcodes_in_intersection num_barcodes_in_simulation,num_barcodes_in_program"
* Second line of output file is:
* * "# num_genes_in_intersection num_genes_in_simulation,num_genes_in_program"
* Rest of output file repeats as the following 5 lines:
* * Five lines: 1) barcode, 2) simulation gene counts, 3) program gene counts, 4) false positive gene names w.r.t. simulation, 5) false negative gene names w.r.t. simulation

Here's an example of the first 17 lines of the output file:

<pre># 913780 6794880,913780
# 33538 33538,33538
AAACCCAAGAAACACT
1
1


AAACCCAAGAAACCCA
1,1
1,1


AAACCCAAGAAACCCG
1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1
ENSG00000072274
ENSG00000123975</pre>

## Supplementary info: How to extract simulated reads by barcode: Optional

This section is completely optional, not used in the paper, and not thoroughly tested.

Assume we're interested in barcode AAACCCAAGCGTATGG.

<pre>barcode="AAACCCAAGCGTATGG"
out_dir="inspect_$barcode"
mkdir -p "$out_dir"
r1="samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R1_.fq"
r2="samples/10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo/_R2_.fq"
paste "$r1" "$r2"|grep -B1 -A2 ^$barcode|grep -v ^\-\-$|cut -f1 -d$'\t' > "$out_dir"/"$barcode"_r1.fq
paste "$r1" "$r2"|grep -B1 -A2 ^$barcode|grep -v ^\-\-$|cut -f2 -d$'\t' > "$out_dir"/"$barcode"_r2.fq
</pre>

Get genes that are false positives in kallisto but not STAR:

<pre>comm -23 <(zcat results/results_sim_vs_kallisto.txt.gz|grep -A3 "$barcode"|tail -1|tr , '\n'|sort) <(zcat results_other/star/results_sim_vs_star.txt.gz|grep -A3 "$barcode"|tail -1|tr , '\n'|sort) > "$out_dir"/false_positives_in_kallisto_but_not_star.txt</pre>

Run kallisto mapping on all reads associated with the given barcode, capture all reads that have a transcript associated with the genes that are false positive in kallisto but not STAR, and output a file of read numbers (zero-indexed) where those problematic reads occur.

<pre>kallisto="exe/kallisto_0.50.1"
bustools="exe/bustools_0.43.2"
genome_name="human_CR_3.0.0"
index_dir="genomes/index/kallisto_0.50.1/$genome_name/standard_offlist_1"
cdna_file="genomes/index/kallisto_0.50.1/$genome_name/standard_1/f1"
index_name="$index_dir/index.idx"
t2g_file="$index_dir/g"
$kallisto bus -n -x 10xv3 -i "$index_name" -o $out_dir/quant/ "$out_dir"/"$barcode"_r1.fq "$out_dir"/"$barcode"_r2.fq
grep -F -f "$out_dir/false_positives_in_kallisto_but_not_star.txt" "$t2g_file"|cut -f1 > $out_dir/quant/capture.txt
$bustools sort -o $out_dir/quant/output.s.bus $out_dir/quant/output.bus 
$bustools capture -o $out_dir/quant/output.s.c.bus -c $out_dir/quant/capture.txt -e $out_dir/quant/matrix.ec -t $out_dir/quant/transcripts.txt --transcripts $out_dir/quant/output.s.bus
$bustools text -pf $out_dir/quant/output.s.c.bus|cut -f5 > $out_dir/quant/read_numbers.txt
</pre>

Now extract those reads:

<pre>out_file="$out_dir/extracted_reads.fq"
touch "$out_file"
cat <(cat $out_dir/quant/read_numbers.txt|awk '{print ($1+1)*4-3,",",($1+1)*4,"p"}'|tr -d ' ') | while read pattern
do
cat "$out_dir"/"$barcode"_r2.fq|sed -n "$pattern" >> "$out_file"
done
</pre>

To inspect a particular read:

<pre>read_num=0
cat "$out_file"|head -$((4*($read_num+1)))|tail -4 > temp.fq
$kallisto quant -i "$index_name" -o temp_inspect/ --single -l 1 -s 1 --fr-stranded --single-overhang temp.fq && cat temp_inspect/abundance.tsv|grep -v 0$</pre>

* You can get the read sequence via `cat temp.fq` and blat it
* You can grep the transcripts, e.g. `cat "$t2g_file"|grep ENST00000540040` to find the gene name and location.
* You can get the transcript sequence via `grep -A1 ENST00000540040 "$cdna_file"` for blast alignment


