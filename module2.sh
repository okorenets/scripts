# BACKUP-SCRIPT

DATE=$(date +"%Y-%m-%d_%H-%M")
SRC=~/test2/module2
DST=~/backups/${DATE}
JPG=${DST}/pic/*.jpg

if
    [ ! -d "${DST}" ];then 
    mkdir -p ${DST}
    echo 'mkdir for backups'
else 
    rm -rf ${DST}/*
    echo 'backups already exist! it`s cleared'
fi
 
if [ -d "${DST}" ]; then
    mkdir -p ${DST}/txt ${DST}/pic ${DST}/mus ${DST}/compressed_img
    echo 'mkdir /txt /pic /mus /compressed_img'
fi

    echo 'Start copying data from SRC to DST with sort'

if
    find ${SRC} -name "*.txt" -exec cp -r {} ${DST}/txt \;
then
    echo 'Succes copy *.txt files'
else
    echo "txt files not found"
fi

if
    tar -zcpf ${DST}/txt/txt.tar ${DST}/txt
    echo 'Tar DST/txt'
then
    rm -rf ${DST}/txt/*.txt
    echo 'Rm txt files from DST/txt'
else
    echo 'fail tar'
fi

if
    find ${SRC} -name "*.jpg" -exec cp -R {} ${DST}/pic \;
then
    echo 'Succes copy *.jpg files'
else
    echo "jpg files not found"
fi

if
    find ${SRC} -name "*.mp3" -exec cp -R {} ${DST}/mus \;
then
    echo 'Succes copy *.mp3 files'
else
    echo "mp3 files not found"
fi

    echo 'All data has been copied' ${DATE} >> ~/backups/log.txt

for file in ${JPG}; do
    mogrify "$file" -quality 80% -path ${DST}/compressed_img "$file"
done;

    check_ini () {
        CHK=`cat backup.ini | grep to_external_server=1`
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

