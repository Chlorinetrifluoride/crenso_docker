# Docker Container to use the crenso/crest_combi script from https://github.com/grimme-lab/CRENSO:
## Overview
## Requirements
* cloned this repository
* Downloaded and extracted [orca binaries](https://orcaforum.kofo.mpg.de/app.php/dlext/
 ) ~ 40G
* Downloaded [xtb](https://github.com/grimme-lab/xtb/releases/tag/v6.7.0) (>v6.6.1), renamed folder to xtb 
* Downloaded [crenso](https://github.com/Chlorinetrifluoride/CRENSO),[crest_combi](https://github.com/Chlorinetrifluoride/CRENSO),[censo](https://github.com/grimme-lab/CENSO/releases/) and [crest](https://github.com/crest-lab/crest/releases)
* Place xtb folder, crenso and crest binaries and crenso, crest_combi scripts in dependencies folder
## Usage
### Build
* build container after the requirements are met with following command:
`sudo docker build -t crenso_docker . `:
### Run Container
2 different modes are possible:
1. Mount a directory containing coord file, allows to persist calculations over container lifetime, calculations are done in mounted directory, so maybe keep a copy of your original coord file:

    `sudo docker run -it -v <orca_files>:/dependencies/orca -v ./:/crenso/wd --shm-size=3G --ulimit stack=-1 crenso_docker`
2. Mount only the coord file, results are not persisted over container lifetime:

    `sudo docker run -it -v <orca_files>:/dependencies/orca -v ./coord:/crenso/coord --shm-size=3G --ulimit stack=-1 crenso_docker`

## Known/Fixed Problems
* without turbomole conversion in l0 mode does not work, to use openbabel instead use crenso fork from https://github.com/Chlorinetrifluoride/CRENSO
* coord files can be obtained by using openbabel to convert sdf to turbomole format:
    * `obabel -i sdf <sdffile> -o tmol -O coord`
* xtb below version 6.6.1 throws a segfault
* shared memory size in docker too low