# HSSHMP_2024

Code for reproducing the figures and results in the preprint [Accurate quantification of single-nucleus and single-cell RNA-seq transcripts](https://www.biorxiv.org/content/10.1101/2022.12.02.518832v2) by Kristján Eldjárn Hjörleifsson, Delaney Sullivan, Nikhila Swarna, Guillaume Holley, Páll Melsted and Lior Pachter

(Note: In this repo, D-list is often referred to as "offlist".)

## Note about human reference genome

The human reference genome (FASTA+GTF) used in all analyses is available directly at https://github.com/pachterlab/HSSHMP_2024/releases under the filename **human_CR_3.0.0.tar.gz**.

## Introduction

Please follow the steps below in order to reproduce the results of the preprint. Set all the paths to be relative to the directory HSHMP_2022.

<pre>main_path="$(pwd)/HSSHMP_2024"
kallisto="$main_path/kallisto_0.48.0/kallisto"
kallisto="$main_path/kallisto_0.50.0/kallisto"
kallisto="$main_path/kallisto_0.50.1/kallisto"
bustools="$main_path/bustools/build/src/bustools"
cellranger7="$main_path/cellranger/cellranger-7.0.1/cellranger"
salmon="$main_path/salmon-latest_linux_x86_64/bin/salmon"
</pre>

## Download software

### kallisto

version 0.48.0

<pre>cd $main_path
wget https://github.com/pachterlab/kallisto/releases/download/v0.48.0/kallisto_linux-v0.48.0.tar.gz
tar -xzvf kallisto_linux-v0.48.0.tar.gz
mv kallisto kallisto_0.48.0
</pre>

version 0.50.0

<pre>cd $main_path
wget https://github.com/pachterlab/kallisto/releases/download/v0.50.0/kallisto_linux-v0.50.0.tar.gz
tar -xzvf kallisto_linux-v0.50.0.tar.gz
mv kallisto kallisto_0.50.0
</pre>

version 0.50.1

<pre>cd $main_path
wget https://github.com/pachterlab/kallisto/releases/download/v0.50.1/kallisto_linux-v0.50.1.tar.gz
tar -xzvf kallisto_linux-v0.50.1.tar.gz
mv kallisto kallisto_0.50.1
</pre>

### bustools

version 0.43.2

<pre>cd $main_path
rm -rf bustools
git clone -b v0.43.2 https://github.com/BUStools/bustools
cd bustools && mkdir -p build && cd build
cmake .. && make</pre>

### kb-python

version 0.28.0

<pre>cd $main_path
yes|python -m pip uninstall kb-python
python -m pip install kb_python==0.28.0</pre>

### Cell Ranger

Note: Cell Ranger needs to be installed manually. Version is as follows:

* Cell Ranger v7.0.1 (Released August 18, 2022. Downloaded October 7, 2022)

### salmon-alevin-fry

salmon version 1.10.0; alevin-fry version 0.8.2; pyroe 0.9.3; simpleaf 0.15.1

<pre>cd $main_path
wget https://github.com/COMBINE-lab/salmon/releases/download/v1.10.0/salmon-1.10.0_linux_x86_64.tar.gz && tar -xzvf salmon-1.10.0_linux_x86_64.tar.gz
export RUSTUP_HOME=${main_path}/.rustup/
export CARGO_HOME=${main_path}/.cargo/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
./.cargo/bin/cargo install --version 0.8.2 --force alevin-fry
./.cargo/bin/cargo install --version 0.15.1 --force simpleaf
yes|python -m pip uninstall pyroe
python -m pip install pyroe==0.9.3
</pre>

simpleaf configuration:

<pre>export ALEVIN_FRY_HOME="$main_path/af_home"
simpleaf set-paths \
--salmon $(pwd)/salmon-latest_linux_x86_64/bin/salmon

simpleaf workflow get --name 10x-chromium-3p-v3 -o af10xv3
</pre>

## cellCounts

**Open up an R session** and then run:

<pre>if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Rsubread")
</pre>

Note: Version Rsubread_2.12.3

## STARSolo simulations

Navigate to STARsoloManuscript and run the scripts there

Note: Make sure to run the STARsoloManuscript scripts first before proceeding (we use these indices and the links to the program binary files downstream). At a minimum, complete the sections "Create symlinks to executables", "Create indices", and "Mouse genome prep".

## Human datasets

### Single-cell

<pre>wget https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/6.1.0/20k_PBMC_3p_HT_nextgem_Chromium_X/20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs.tar
tar -xvf 20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs.tar</pre>

### Single-nucleus

<pre>wget https://cf.10xgenomics.com/samples/cell-exp/7.0.0/5k_human_jejunum_CNIK_3pv3/5k_human_jejunum_CNIK_3pv3_fastqs.tar
tar -xvf 5k_human_jejunum_CNIK_3pv3_fastqs.tar</pre>

## Mouse datasets

### Single-cell

<pre>wget https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/4.0.0/SC3_v3_NextGem_SI_Neuron_10K/SC3_v3_NextGem_SI_Neuron_10K_fastqs.tar
tar -xvf SC3_v3_NextGem_SI_Neuron_10K_fastqs.tar</pre>

### Single-nucleus

<pre>wget https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/7.0.0/5k_mouse_lung_CNIK_3pv3/5k_mouse_lung_CNIK_3pv3_fastqs.tar
tar -xvf 5k_mouse_lung_CNIK_3pv3_fastqs.tar</pre>

## Spatial

<pre>wget https://s3-us-west-2.amazonaws.com/10x.files/samples/spatial-exp/2.1.0/CytAssist_11mm_FFPE_Mouse_Embryo/CytAssist_11mm_FFPE_Mouse_Embryo_fastqs.tar
tar -xf CytAssist_11mm_FFPE_Mouse_Embryo_fastqs.tar && rm CytAssist_11mm_FFPE_Mouse_Embryo_fastqs.tar && mv fastqs/* ./ && rmdir fastqs</pre>

## Generate count matrix for datasets using kallisto

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./matrices_human_20k_PBMC/ --overwrite --verbose \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./matrices_human_5k_jejunum_nuclei/ --overwrite --verbose \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R2_001.fastq.gz
</pre>

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./matrices_mouse_10k_neuron/ --overwrite --verbose \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R2_001.fastq.gz
</pre>


<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./matrices_mouse_5k_lung/ --overwrite --verbose \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz
</pre>

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x VISIUM \
    --strand=unstranded --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./matrices_mouse_ffpe/ --overwrite --verbose \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R1_001.fastq.gz \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R2_001.fastq.gz
</pre>


Filtering for UMI threshold >= 500 (applies to total count matrix; the other count matrices just use the barcodes from the "total" matrix).

<pre>./filter.sh matrices_human_20k_PBMC 500
./filter.sh matrices_human_5k_jejunum_nuclei 500
./filter.sh matrices_mouse_10k_neuron 500
./filter.sh matrices_mouse_5k_lung 500
./filter.sh matrices_mouse_ffpe 500</pre>

Let's now use the script from the simulations (where we compared output matrix vs simulated truth matrix) to now compare our nascent/mature/ambiguous/etc. matrices. Everything is in the mtx_comparisons.sh file.

<pre>./mtx_comparisons.sh matrices_human_20k_PBMC
./mtx_comparisons.sh matrices_human_5k_jejunum_nuclei
./mtx_comparisons.sh matrices_mouse_10k_neuron
./mtx_comparisons.sh matrices_mouse_5k_lung
./mtx_comparisons.sh matrices_mouse_ffpe</pre>

The final analysis is produced in the matrix_comparisons.ipynb python notebook file.

## Runtime and memory benchmarks of kallisto (and mapping comparisons)

Note: kb-python already uses the 10xv3 prepackaged on-list.

Note: After the following commands are run, the analysis_dlist_performance.ipynb python notebook contains the final plots.

<pre>mkdir -p performance_comparisons/out/</pre>

### Human 20k pbmc

nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./performance_comparisons/out/nac_offlist-20kb_PBMC/ --overwrite \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac_offlist-20kb_PBMC_1.txt
</pre>

nac (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c2 \
    -o ./performance_comparisons/out/nac-20kb_PBMC/ --overwrite \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac-20kb_PBMC_1.txt
</pre>

standard + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/g \
    -o ./performance_comparisons/out/standard_offlist-20kb_PBMC/ --overwrite \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_standard_offlist-20kb_PBMC_1.txt
</pre>

standard (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_1/g \
    -o ./performance_comparisons/out/standard-20kb_PBMC/ --overwrite \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_standard-20kb_PBMC_1.txt
</pre>

### Human 5k jejunum

nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./performance_comparisons/out/nac_offlist-5kb_jejunum/ --overwrite \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac_offlist-5kb_jejunum_1.txt
</pre>

nac (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c2 \
    -o ./performance_comparisons/out/nac-5kb_jejunum/ --overwrite \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac-5kb_jejunum_1.txt
</pre>

standard + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_offlist_1/g \
    -o ./performance_comparisons/out/standard_offlist-5kb_jejunum/ --overwrite \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2

</pre>

standard (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/standard_1/g \
    -o ./performance_comparisons/out/standard-5kb_jejunum/ --overwrite \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L001_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L002_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L003_R2_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R1_001.fastq.gz \
    5k_human_jejunum_CNIK_3pv3_fastqs/5k_human_jejunum_CNIK_3pv3_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

### Mouse 10k neuron


nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./performance_comparisons/out/nac_offlist-10kb_neuron/ --overwrite \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac_offlist-10kb_neuron_1.txt
</pre>

nac (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c2 \
    -o ./performance_comparisons/out/nac-10kb_neuron/ --overwrite \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac-10kb_neuron_1.txt
</pre>

standard + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/g \
    -o ./performance_comparisons/out/standard_offlist-10kb_neuron/ --overwrite \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_standard_offlist-10kb_neuron_1.txt
</pre>

standard (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/g \
    -o ./performance_comparisons/out/standard-10kb_neuron/ --overwrite \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L002_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L003_R2_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R1_001.fastq.gz \
    SC3_v3_NextGem_SI_Neuron_10K_fastqs/SC3_v3_NextGem_SI_Neuron_10K_S1_L004_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_standard-10kb_neuron_1.txt
</pre>

### Mouse 5k lung

nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./performance_comparisons/out/nac_offlist-5kb_lung/ --overwrite \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac_offlist-5kb_lung_1.txt
</pre>

nac (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c2 \
    -o ./performance_comparisons/out/nac-5kb_lung/ --overwrite \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac-5kb_lung_1.txt
</pre>

standard + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/g \
    -o ./performance_comparisons/out/standard_offlist-5kb_lung/ --overwrite \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz"

$cmd1 16 $cmd2

</pre>

standard (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/g \
    -o ./performance_comparisons/out/standard-5kb_lung/ --overwrite \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

### Spatial (mouse FFPE)

nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 --strand=unstranded \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./performance_comparisons/out/nac_offlist-mouse_ffpe/ --overwrite \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R1_001.fastq.gz \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

nac (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 --strand=unstranded \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_1/c2 \
    -o ./performance_comparisons/out/nac-mouse_ffpe/ --overwrite \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R1_001.fastq.gz \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

standard + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 --strand=unstranded \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_offlist_1/g \
    -o ./performance_comparisons/out/standard_offlist-mouse_ffpe/ --overwrite \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R1_001.fastq.gz \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

standard (no offlist):

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 --strand=unstranded \
    --workflow standard -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/standard_1/g \
    -o ./performance_comparisons/out/standard-mouse_ffpe/ --overwrite \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R1_001.fastq.gz \
    CytAssist_11mm_FFPE_Mouse_Embryo_fastqs/CytAssist_11mm_FFPE_Mouse_Embryo_S1_L004_R2_001.fastq.gz"

$cmd1 16 $cmd2
</pre>

## Reprocess PBMC data (for cluster-level analysis)

### Obtain data

Get clusters 1 and 2:

<pre>wget --continue https://cf.10xgenomics.com/samples/cell-exp/6.1.0/20k_PBMC_3p_HT_nextgem_Chromium_X/20k_PBMC_3p_HT_nextgem_Chromium_X_analysis.tar.gz
tar -xzvf 20k_PBMC_3p_HT_nextgem_Chromium_X_analysis.tar.gz
cat analysis/clustering/graphclust/clusters.csv|grep ",1$\|,2$"|cut -d"-" -f1 > barcodes_10x_human.txt
cat analysis/clustering/graphclust/clusters.csv|grep ",1$\|,2$"|tr '-' '\t' > barcodes_10x_human.clusters.txt
cat analysis/clustering/graphclust/clusters.csv|grep ",1$"|cut -d"-" -f1 > barcodes_10x_human.cluster.1.txt
cat analysis/clustering/graphclust/clusters.csv|grep ",2$"|cut -d"-" -f1 > barcodes_10x_human.cluster.2.txt
</pre>

### Process using kallisto

#### NAC plus offlist

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./reprocess_human_20k_PBMC/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>

#### NAC no offlist

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_1/c2 \
    -o ./reprocess_human_20k_PBMC_no_offlist/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>

#### Subset index

<pre>awk '$3 == "gene" { for(i=1;i<=NF;i++) if($i ~ /gene_id/) { gsub(/"|;|gene_id/, "", $(i+1)); print $(i+1) } }'  STARsoloManuscript/genomes/human_CR_3.0.0/annotations.gtf|sort -u > gene_subset_list.txt
python kallisto_paper_analysis/select_random_lines.py gene_subset_list.txt gene_subset_list.randomized.txt 8385 42
grep -f gene_subset_list.randomized.txt STARsoloManuscript/genomes/human_CR_3.0.0/annotations.gtf|awk '$0 ~ /gene_id/ { match($0, /gene_id "([^"]+)"/, arr); print; }' > subset.gtf</pre>

<pre>kb ref -t 16 --workflow=nac --d-list=None -g t2g.subset.no_offlist.txt --verbose \
    -f1 f1.subset.no_offlist.txt -f2 f2.subset.no_offlist.txt \
    -c1 c1.subset.no_offlist.txt -c2 c2.subset.no_offlist.txt -i subset.no_offlist.idx  \
    STARsoloManuscript/genomes/human_CR_3.0.0/genome.fa subset.gtf</pre>


<pre>kb ref -t 16 --workflow=nac -g t2g.subset.txt --verbose \
    -f1 f1.subset.txt -f2 f2.subset.txt \
    -c1 c1.subset.txt -c2 c2.subset.txt -i subset.idx  \
    STARsoloManuscript/genomes/human_CR_3.0.0/genome.fa subset.gtf</pre>


<pre>kb ref -t 16 --workflow=standard --d-list=None -g t2g.standard.subset.no_offlist.txt --verbose \
    -f1 f1.standard.subset.no_offlist.txt -i standard.subset.no_offlist.idx  \
    STARsoloManuscript/genomes/human_CR_3.0.0/genome.fa subset.gtf</pre>


<pre>kb ref -t 16 --workflow=standard -g t2g.standard.subset.txt --verbose \
    -f1 f1.standard.subset.txt -i standard.subset.idx  \
    STARsoloManuscript/genomes/human_CR_3.0.0/genome.fa subset.gtf</pre>

#### NAC plus offlist (subset)

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i subset.idx \
    -g t2g.subset.txt \
    -c1 c1.subset.txt \
    -c2 c2.subset.txt \
    -o ./reprocess_human_20k_PBMC_subset/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>

#### NAC no offlist (subset)

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow nac --sum=total -i subset.no_offlist.idx \
    -g t2g.subset.no_offlist.txt \
    -c1 c1.subset.no_offlist.txt \
    -c2 c2.subset.no_offlist.txt \
    -o ./reprocess_human_20k_PBMC_no_offlist_subset/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>


#### standard plus offlist (subset)

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow standard -i standard.subset.idx \
    -g t2g.standard.subset.txt \
    -o ./reprocess_human_20k_PBMC_standard_subset/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>

#### standard no offlist (subset)

<pre>kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t 20 -x 10XV3 \
    --workflow standard -i standard.subset.no_offlist.idx \
    -g t2g.standard.subset.no_offlist.txt \
    -o ./reprocess_human_20k_PBMC_no_offlist_standard_subset/ --overwrite --verbose \
    -w barcodes_10x_human.txt -t 48 \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>


#### Obtain TCCs (OPTIONAL; NOT USED):

<pre>STARsoloManuscript/exe/bustools_0.43.2 count -o ./reprocess_human_20k_PBMC/counts_unfiltered/cells_x_tcc -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g -e ./reprocess_human_20k_PBMC/matrix.ec -t ./reprocess_human_20k_PBMC/transcripts.txt --umi-gene ./reprocess_human_20k_PBMC/output.unfiltered.bus
</pre>


### Format reads for STAR alignment

Note: Please install splitcode (version 0.30.0) to preprocess this data - https://github.com/pachterlab/splitcode

Now, let's look at cluster 1 vs. cluster 2. First let's get their barcodes:

<pre>cat analysis/clustering/graphclust/clusters.csv|grep ",1$"|cut -d"-" -f1 > barcodes_10x_human.cluster1.txt
cat analysis/clustering/graphclust/clusters.csv|grep ",2$"|cut -d"-" -f1 > barcodes_10x_human.cluster2.txt</pre>

Now, let's run splitcode twice to extract the reads specific to cluster 1 cells and the reads specific to cluster 2 cells (note: with the proper config file, splitcode could, in theory, do this in one step rather than two).

<pre>splitcode -t 16 -c 10x_pbmc_splitcode_config_cluster1_cells.txt --nFastqs=2 --gzip --x-only \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz

splitcode -t 16 -c 10x_pbmc_splitcode_config_cluster2_cells.txt --nFastqs=2 --gzip --x-only \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L001_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L002_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L003_R2_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R1_001.fastq.gz \
    20k_PBMC_3p_HT_nextgem_Chromium_X_fastqs/20k_PBMC_3p_HT_nextgem_Chromium_X_S3_L004_R2_001.fastq.gz
</pre>


## SPLiT-seq c2c12 for TCCs

### Download sequencing reads

<pre>wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/065/SRR13948565/SRR13948565_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/065/SRR13948565/SRR13948565_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/066/SRR13948566/SRR13948566_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/066/SRR13948566/SRR13948566_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/071/SRR13948571/SRR13948571_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/071/SRR13948571/SRR13948571_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/068/SRR13948568/SRR13948568_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/068/SRR13948568/SRR13948568_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/069/SRR13948569/SRR13948569_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/069/SRR13948569/SRR13948569_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/070/SRR13948570/SRR13948570_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/070/SRR13948570/SRR13948570_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/067/SRR13948567/SRR13948567_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR139/067/SRR13948567/SRR13948567_2.fastq.gz</pre>

### Download metadata

<pre>wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169184/suppl/GSM5169184%5FC2C12%5Fshort%5F1k%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169185/suppl/GSM5169185%5FC2C12%5Fshort%5F9kA%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169186/suppl/GSM5169186%5FC2C12%5Fshort%5F9kB%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169187/suppl/GSM5169187%5FC2C12%5Fshort%5F9kC%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169188/suppl/GSM5169188%5FC2C12%5Fshort%5F9kD%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169189/suppl/GSM5169189%5FC2C12%5Fshort%5F9kE%5Fcell%5Fmetadata.csv.gz
wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM5169nnn/GSM5169190/suppl/GSM5169190%5FC2C12%5Fshort%5F9kF%5Fcell%5Fmetadata.csv.gz
wget https://raw.githubusercontent.com/pachterlab/splitcode-tutorial/main/uploads/splitseq/r2_r3.txt
wget https://raw.githubusercontent.com/fairliereese/LR-splitpipe/859279ed3fec859248fb4fdaee17280e6103b9f9/barcodes/bc_data_v2.csv</pre>

### Format metadata

<pre>cat bc_data_v2.csv|grep "A1\|A2\|A3\|A4\|A5\|A6\|A7\|A8\|A9\|A10\|A11\|A12"|grep R$|cut -d, -f2 > r1_R_Awells.txt
cat bc_data_v2.csv|grep "A1\|A2\|A3\|A4\|A5\|A6\|A7\|A8\|A9\|A10\|A11\|A12"|grep T$|cut -d, -f2 > r1_T_Awells.txt</pre>

### Format sequencing reads

<pre>rm splitseq_batch.txt
./prep_splitseq.sh SRR13948565 GSM5169184_C2C12_short_1k
./prep_splitseq.sh SRR13948566 GSM5169185_C2C12_short_9kA
./prep_splitseq.sh SRR13948567 GSM5169186_C2C12_short_9kB
./prep_splitseq.sh SRR13948568 GSM5169187_C2C12_short_9kC
./prep_splitseq.sh SRR13948569 GSM5169188_C2C12_short_9kD
./prep_splitseq.sh SRR13948570 GSM5169189_C2C12_short_9kE
./prep_splitseq.sh SRR13948571 GSM5169190_C2C12_short_9kF</pre>

### Discard rRNA reads

Need bowtie2 (version 2.5.3), seqkit (v2.8.0), samtools (version 1.19.2)

<pre>bowtie2-build "mm10_ncRNA.fa" "exclusion_index"
cat splitseq_batch.txt|cut -d' ' -f2 > splitseq_batch.r1.txt
cat splitseq_batch.txt|cut -d' ' -f3 > splitseq_batch.r2.txt

xargs -I {} sh -c 'bowtie2 -q -p 20 \
--no-unal \
--quiet \
--local \
-x "exclusion_index" \
-U "{}" | samtools view -S | cut -f1 > "{}.filter.txt"' < splitseq_batch.r1.txt
</pre>

<pre>cat *.filter.txt > final.filter.txt

xargs -I {} sh -c 'seqkit \
grep -j 20 -v -n \
-f "final.filter.txt" "{}" \
-o "{}.filtered.fastq.gz"' < splitseq_batch.r1.txt

xargs -I {} sh -c 'seqkit \
grep -j 20 -v -n \
-f "final.filter.txt" "{}" \
-o "{}.filtered.fastq.gz"' < splitseq_batch.r2.txt</pre>

<pre>cat splitseq_batch.txt | sed 's/\.fastq\.gz/.fastq.gz.filtered.fastq.gz/g' > splitseq_batch_final.txt</pre>
</pre>

### Get TCCs with kallisto

<pre>rm -rf splitseq_out

kb count --strand=forward -w None --overwrite --keep-tmp --verbose \
--workflow=nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
-c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 -x 1,10,18,1,48,56,1,78,86:1,0,10:0,0,0 \
--sum=total -o splitseq_out --batch-barcodes splitseq_batch_final.txt

STARsoloManuscript/exe/bustools_0.43.2 count -o splitseq_out/counts_unfiltered/cells_x_tcc -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g -e splitseq_out/matrix.ec -t splitseq_out/transcripts.txt --multimapping --umi-gene splitseq_out/tmp/output.s.bus

STARsoloManuscript/exe/kallisto_0.50.1 quant-tcc -o splitseq_out/quant_unfiltered/ -t 24 --matrix-to-files --plaintext -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g -e splitseq_out/counts_unfiltered/cells_x_tcc.ec.txt splitseq_out/counts_unfiltered/cells_x_tcc.mtx</pre>

Now, look in the splitseq_analysis.ipynb notebook for further analysis.

### Get STAR alignment

<pre>zcat splitseq_R_SRR13948565_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948566_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948567_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948568_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948569_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948570_R1.fastq.gz.filtered.fastq.gz splitseq_R_SRR13948571_R1.fastq.gz.filtered.fastq.gz | gzip > splitseq_R_merged.fastq.gz
zcat splitseq_T_SRR13948565_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948566_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948567_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948568_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948569_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948570_R1.fastq.gz.filtered.fastq.gz splitseq_T_SRR13948571_R1.fastq.gz.filtered.fastq.gz | gzip > splitseq_T_merged.fastq.gz


mkdir -p splitseq_c2c12_R
STARsoloManuscript/exe/STAR_2.7.9a \
--genomeDir "STARsoloManuscript/genomes/index/STAR_2.7.9a/mouse/fullSA" \
--runThreadN 16 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
--outFilterType BySJout \
--outFileNamePrefix "splitseq_c2c12_R/" \
--readFilesIn splitseq_R_merged.fastq.gz


mkdir -p splitseq_c2c12_T
STARsoloManuscript/exe/STAR_2.7.9a \
--genomeDir "STARsoloManuscript/genomes/index/STAR_2.7.9a/mouse/fullSA" \
--runThreadN 16 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
--outFilterType BySJout \
--outFileNamePrefix "splitseq_c2c12_T/" \
--readFilesIn splitseq_T_merged.fastq.gz</pre>


We can index the BAM files with samtools then view them in IGV.


## RSEM analysis

Simply go to kallisto_paper_analysis and follow the instructions there.

