# Compression Project

## Algorithms Tested
### Generic Methods
* gzip
* bzip2/pbzip2
* xz
* pigz

### Specialized Methods for Genetic Data (w/o Reference)
* Gtz (Reference: https://gtz.io/GCF_000001405.37_GRCh38.p11_genomic.fna.gz)

## Results
| Algorithm  | Compression Ratio | Compression Rate (bytes/ms) | Decompression Rate (bytes/ms)  | CPU (%)* | MEM*    |
| ---------- | ----------------- | --------------------------- | ------------------------------ | -------- | ------- | 
| gzip       |  0.148109515      | 4.531499815                 | 232.2678697                    | 100      | 624K    |
| bzip2      |  0.121644789      | 21.33268808                 | 74.58135692                    | 100      | 6816K   |
| pbzip2     |  0.121633493      | 145.0682678                 | 168.8976657                    | 1500     | 22M+    |
| xz         |  0.11765507       | 1.021228651                 | 103.1093882                    | 100      | 360M+   |
| pigz       |  0.148111774      | 36.03876129                 | 345.1920643                    | 1500     | 11M     |
| gtz        |  0.091490816      | 1519.525808                 | 108.5826744                    | 200      | 1.49G+  |

\* Approximation taken from ```top``` while the algo was running. 

## Install 
### MAC
Gtz requires a linux machine so only the generic algorithms can be installed.
FqzComp Download - https://sourceforge.net/p/fqzcomp/home/Home/
* BioConda Installation: https://bioconda.github.io/recipes/fqzcomp/README.html
```
$ brew install gzip
$ brew install pbzip2
$ brew install bzip2
$ brew install xz
$ brew install pigz
```

### Linux

Gtz Download - https://github.com/Genetalks/gtz
* Requires 64-bit Linux system
* Documentation: https://github.com/Genetalks/gtz
* LICENSING NOTE - If you're using gtz, you must agree to a licensing agreement where you can't decompile or reverse engineer the software at all. You also must agree to participate "in the User Experience Improvement Program". This requires that users
update to the latest version every 6 months and that GeneTalks will be allowed to collect "software operating parameters through the HTTPS protocol, including CPU usage, memory usage, compressed file size, output file, size, compression ratio, etc". Not sure what is included in "etc". See ```supplemental/gtz_license.md```

### Run
While running, creates two directories to output compressed & decompressed files 
```
$ ./fastq_download.sh                       # Downloads all fastq files
$ ./compression_test.sh > compress.log      # Runs compression test 
$ tail -f ./compress.log                      # Shows logging
```

## Implementation
For the generic options, the best compression (slowest time) option was selected. 

## Data
All files were taken from the 1000 Genomes Project
* HG00096: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/



