# HSSHMP_2024

Code for reproducing the figures and results in the preprint [Accurate quantification of single-nucleus and single-cell RNA-seq transcripts](https://www.biorxiv.org/content/10.1101/2022.12.02.518832v2) by Kristján Eldjárn Hjörleifsson, Delaney Sullivan, Nikhila Swarna, Guillaume Holley, Páll Melsted and Lior Pachter

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

## Runtime and memory benchmarks of kallisto

Note: kb-python already uses the 10xv3 prepackaged on-list.

Note: After the following commands are run, the analysis_dlist_performance.ipynb python notebook contains the final plots.

<pre>mkdir -p performance_comparisons/</pre>

### Human 20k pbmc

nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/human_CR_3.0.0/nac_offlist_1/c2 \
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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

### Mouse 10k neuron


nac + offlist:

<pre>cmd1="kb count --kallisto STARsoloManuscript/exe/kallisto_0.50.1 --bustools STARsoloManuscript/exe/bustools_0.43.2 -t "
cmd2=" -x 10XV3 \
    --workflow nac -i STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/index.idx \
    -g STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/g \
    -c1 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c1 \
    -c2 STARsoloManuscript/genomes/index/kallisto_0.50.1/mouse/nac_offlist_1/c2 \
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
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
    -o ./performance_comparisons/tmp/ --overwrite \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L001_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L002_R2_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R1_001.fastq.gz \
    5k_mouse_lung_CNIK_3pv3_fastqs/5k_mouse_lung_CNIK_3pv3_S4_L003_R2_001.fastq.gz"

/usr/bin/time -v $cmd1 16 $cmd2 2> performance_comparisons/16_nac-5kb_lung_1.txt
</pre>


