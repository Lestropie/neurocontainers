#!/usr/bin/env bash
set -e

export toolName='qsmxt'
export toolVersion='1.0.0'

if [ "$1" != "" ]; then
    echo "Entering Debug mode"
    export debug="true"
fi

source ../main_setup.sh

# ubuntu:18.04 

neurodocker generate ${neurodocker_buildMode} \
   --base docker.pkg.github.com/neurodesk/caid/qsmxtbase_1.0.0:20210128 \
   --pkg-manager apt \
   --run="mkdir -p ${mountPointList}" \
   --workdir /opt \
   --run="conda install -c conda-forge dicomifier" \
   --run="git clone https://github.com/QSMxT/QSMxT" \
   --env PATH='$PATH':/opt/bru2 \
   --env DEPLOY_PATH=/opt/minc-1.9.17/bin/:/opt/minc-1.9.17/volgenmodel-nipype/extra-scripts:/opt/minc-1.9.17/pipeline:/opt/fsl-6.0.4/bin/:/opt/freesurfer-7.1.1/bin/ \
   --env DEPLOY_BINS=dcm2niix:bidsmapper:bidscoiner:bidseditor:bidsparticipants:bidstrainer:deface:dicomsort:pydeface:rawmapper:Bru2:Bru2Nii:tgv_qsm:julia  \
   --run="cp /opt/QSMxT/README.md /README.md" \
  > ${imageName}.Dockerfile

if [ "$debug" = "true" ]; then
   ./../main_build.sh
fi

