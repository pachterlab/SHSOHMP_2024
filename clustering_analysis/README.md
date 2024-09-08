# This is the repository to compare Seurat and Scanpy, count matrix generation methods, and full sized and downsampled matrices

# To run docker container:
docker run -d -p 8787:8787 -e PASSWORD=yourpassword -v /path/to/code:/workspace josephrich98/rmejlbasbmp_2024:1.0_seu5
- visit http://localhost:8787
- sign in with username rstudio, password yourpassword (set above)

Activate the appropriate conda environment
- analysis_env: Scanpy 1.9.5

### Note: The docker container needs a lot of allocated memory (we used 15GB)

# To run in conda environment: build the appropriate conda environment from yaml file
Installations needed to be performed manually (cannot be stored in yaml due to dependency conflicts or difficulty finding package upon building):
- all environments: pip install git+https://github.com/has2k1/scikit-misc.git@269f61e

To perform analysis, modify the yaml file and run the appropriate Rmd notebook from analysis/Rmd. 
