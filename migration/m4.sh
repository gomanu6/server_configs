#!/bin/bash






for dir in ${source}/*; do
    echo
    echo " ------ Moving ${dir} --------- "

    cp -r "${dir}" "${dest}"
    
    echo
    echo "XXXX--- Finished ---- XXXX"
    echo
done


