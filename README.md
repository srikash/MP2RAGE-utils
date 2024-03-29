# MP2RAGE-utils [![DOI](https://zenodo.org/badge/307662544.svg)](https://zenodo.org/badge/latestdoi/307662544)

## Usage
Setup all parameters and paths in the `config.yml` file  
and then run  
`mp2rage_main('config.yml')`

### MP2RAGE functions
MP2RAGE Scripts from José Marques : https://github.com/JosePMarques/MP2RAGE-related-scripts  
* Background noise removal by using a "robust"/regularized version of the combination of the two inversion time images.
* T1 map estimation using the MP2RAGE sequence  
* T1 map correction using an additional B1 map (Sa2RAGE/TFL) 

### Nifti I/O functions
NIfTI tools from Jimmy Shen : https://nl.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image

### YAML functionality
ReadYAML from Lloyd Russell : https://github.com/llerussell/ReadYAML

