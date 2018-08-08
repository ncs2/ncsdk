#! /bin/bash

mvcmd_dir=./mvnc
mvcmd_file=MvNCAPI.mvcmd
mvcmd_full_path=${mvcmd_dir}/${mvcmd_file}

echo "get_mvcmd looking for firmware file:  ${mvcmd_full_path} "


if [ -e ${mvcmd_full_path} ]
then
    # fw file already exists, nothing to do
    echo "File ${mvcmd_full_path} already exists"
    exit 0
else 
    # no fw file will try to download tar file and extract it.
    echo "File ${mvcmd_full_path} not there will attempt to download"
fi

download_filename=NCSDK-1.12.tar.gz

# ncsdk_link is the url
ncsdk_link=https://software.intel.com/sites/default/files/managed/33/1b/NCSDK-1.12.00.01.tar.gz

# download the payload from the redirector link
# and save it the download_filename no matter what the original filename was
wget --no-cache -O ${download_filename} $ncsdk_link

# Get the filenames, ncsdk_archive is just the download filename
# and ncsdk_pkg is the filename without the .tar.gz
#ncsdk_archive=$(echo "$ncsdk_link" | grep -o '[^/]*$')
ncsdk_archive=${download_filename}
ncsdk_pkg=${ncsdk_archive%%.tar.gz}

# create mvnc directory if its not there
mkdir -p ${mvcmd_dir}

# untar the new install and run the install script
tar -xvf ${download_filename} --strip-components=3 -C ${mvcmd_dir} NCSDK-1.12.00.01/ncsdk-x86_64/fw/MvNCAPI.mvcmd

# remove the tar file
rm -rf ${download_filename}
