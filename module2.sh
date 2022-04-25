# BACKUP-SCRIPT

DATE=$(date +"%Y-%m-%d_%H-%M")
SRC=~/test2/module2     # $ source for backup
DST=~/backups/${DATE}   # $ destination for backup
FIND_TXT=`find ${SRC} -name "*.txt"`
FIND_JPG=`find ${SRC} -name "*.jpg"`
FIND_MP3=`find ${SRC} -name "*.mp3"`
JPG=${DST}/pic/*.jpg    # $ for mogrify
. ${SRC}/backup.ini     # include .ini file

if
    [ ! -d "${DST}" ];then 
    mkdir -p ${DST}
    echo "Create directory ${DST}" >> ~/backups/log_${DATE}.txt
else 
    rm -rf ${DST}/*
    echo ${DST} 'already exist! it`s cleared' >> ~/backups/log_${DATE}.txt
fi
 
if [ -d "${DST}" ]; then
    mkdir -p ${DST}/txt ${DST}/pic ${DST}/mus ${DST}/compressed_img
    echo -e "Create subdirectory \n${DST}/txt \n${DST}/pic \n${DST}/mus \n${DST}/compressed_img" >> ~/backups/log_${DATE}.txt
fi

    echo "Start copying data from ${SRC} to ${DST} with sort" >> ~/backups/log_${DATE}.txt

if [[ -z ${FIND_TXT} ]]; then
    echo ".txt files not found" >> ~/backups/log_${DATE}.txt
else
    cp -R ${FIND_TXT} ${DST}/txt
    echo 'Succes copy *.txt files' >> ~/backups/log_${DATE}.txt
fi

if  tar -czpf ${DST}/txt.tar.gz -P ${DST}/txt
    echo "Archive directory ${DST}/txt" >> ~/backups/log_${DATE}.txt; then
    rm -rf ${DST}/txt/*.txt
    echo "Remove .txt files from ${DST}/txt after tar" >> ~/backups/log_${DATE}.txt
else
    echo "Fail when create archive" >> ~/backups/log_${DATE}.txt
fi

if [[ -z ${FIND_JPG} ]]; then
    echo ".jpg files not found" >> ~/backups/log_${DATE}.txt
else
    cp -R ${FIND_JPG} ${DST}/pic
    echo 'Succes copy *.jpg files' >> ~/backups/log_${DATE}.txt
fi

if [[ -z ${FIND_MP3} ]]; then
    echo ".mp3 files not found" >> ~/backups/log_${DATE}.txt
else
    cp -R ${FIND_MP3} ${DST}/mus
    echo 'Succes copy *.mp3 files' >> ~/backups/log_${DATE}.txt
fi

    echo 'All data has been copied' ${DATE} >> ~/backups/log_${DATE}.txt

for file in ${JPG}; do
    mogrify "$file" -quality 80% -path ${DST}/compressed_img "$file"
done;
    echo "Mogrify with -quality 80% .jpg files in ${DST}/pic" >> ~/backups/log_${DATE}.txt

    
if  [ -f ${SRC}/backup.ini ]; then 
    echo 'backup.ini found, check need_backup status...'
else echo 'ini file not found' >> ~/backups/log_${DATE}.txt
fi   

if [ "${need_backup_to_external_server}" == 1 ]; then
    for IP in ${external_servers[@]}
    do scp -r ${DST} ${IP}
    done
    echo "Backup copied from ${DST} to external_servers" >> ~/backups/log_${DATE}.txt
else
    echo "No need copy to external servers" >> ~/backups/log_${DATE}.txt
fi

./remove.sh # Start remove script for old backups
    echo "Remove older then 10 day backups" >> ~/backups/log_${DATE}.txt
   
    echo "Backup script complete!!! ${DATE}" >> ~/backups/log_${DATE}.txt

cat ~/backups/log_${DATE}.txt