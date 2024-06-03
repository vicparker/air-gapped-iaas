#!/usr/bin/bash
#export REPO="https://wp-content.vmware.com/v2/latest/"
#export WORKINGDIR=`pwd`
#export IMAGE_LIST=${WORKINGDIR}/image.list

echo "Downloading listed TKRs."
for image in `/usr/bin/cat ${IMAGE_LIST}`
do
	if [[ ${image} == *"ubuntu"* ]] 
	   then
		echo "Downloading an Ubuntu image"
		echo ${image}
		mkdir ${WORKINGDIR}/${image} 
		cd ${WORKINGDIR}/${image}
		wget ${REPO}${image}/ubuntu-ova-disk1.vmdk
		wget ${REPO}${image}/ubuntu-ova.cert
		wget ${REPO}${image}/ubuntu-ova.mf
		wget ${REPO}${image}/ubuntu-ova.ovf
	   elif [[ ${image} == *"photon"* ]]
             then
		echo "Downloading an Photon image"
		echo ${image}
		mkdir ${WORKINGDIR}/${image} 
		cd ${WORKINGDIR}/${image}
		wget ${REPO}${image}/photon-ova-disk1.vmdk
		wget ${REPO}${image}/photon-ova.cert
		wget ${REPO}${image}/photon-ova.mf
		wget ${REPO}${image}/photon-ova.ovf
            else
		echo "Cannot determine Kubernetes Node Image."
	    fi
done
		
