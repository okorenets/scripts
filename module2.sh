# BACKUP-SCRIPT

DATE=$(date +"%Y-%m-%d_%H-%M")
SRC=~/test2/module2
DST=~/backups/${DATE}
FIND_TXT=`find ${SRC} -name "*.txt"`
FIND_JPG=`find ${SRC} -name "*.jpg"`
FIND_MP3=`find ${SRC} -name "*.mp3"`
JPG=${DST}/pic/*.jpg

if
    [ ! -d "${DST}" ];then 
    mkdir -p ${DST}
    echo "Создание директории ${DST}" >> ~/backups/log_${DATE}.txt
else 
    rm -rf ${DST}/*
    echo 'backups already exist! it`s cleared' >> ~/backups/log_${DATE}.txt
fi
 
if [ -d "${DST}" ]; then
    mkdir -p ${DST}/txt ${DST}/pic ${DST}/mus ${DST}/compressed_img
    echo -e "Создание поддиректорий \n${DST}/txt \n${DST}/pic \n${DST}/mus \n${DST}/compressed_img" >> ~/backups/log_${DATE}.txt
fi

    echo "Start copying data from ${SRC} to ${DST} with sort" >> ~/backups/log_${DATE}.txt

if [[ -z ${FIND_TXT} ]]; then
    echo ".txt files not found" >> ~/backups/log_${DATE}.txt
else
    cp -R ${FIND_TXT} ${DST}/txt
    echo 'Succes copy *.txt files' >> ~/backups/log_${DATE}.txt
fi

# if
#     tar -zcpf ${DST}/txt/txt.tar ${DST}/txt
#     echo 'Tar DST/txt'
# then
#     rm -rf ${DST}/txt/*.txt
#     echo 'Rm txt files from DST/txt'
# else
#     echo 'fail tar'
# fi

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
    cat ~/backups/log_${DATE}.txt
    
    check_ini () {
        CHK=`cat backup.ini | grep to_external_server=1 | grep -v grep`
    }
    # servers () {
    #     SRV=`cat backup.ini | `
    # }
while check_ini
    do
        if [ -n "$CHK" ]
        then
            echo 'Need backup to ext serv'
            break
        else
            echo 'ini not found'
            break
        fi
    done

