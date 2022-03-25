#!/bin/zsh

path_info=(${(@s:/:)PATH_INFO})
dominios=(${(@s:.:)SERVER_NAME})
user=$dominios[2]
full_name=$(getent passwd $user | cut -d: -f5 | cut -d, -f1)
MD="/tmp/modelo-${user_name}.md"
sed "s/NOME/${full_name}/" modelo.md > "${MD}"

output=$path_info[1]
case $output in
    docx)
        echo "Content-type: application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        echo "Content-disposition: attachment; filename=\"${user}.${output}\""
        echo
        pandoc -f markdown -t docx ${MD}
        ;;
    odt)
        echo "Content-type: application/vnd.oasis.opendocument.text"
        echo "Content-disposition: attachment; filename=\"${user}.${output}\""
        echo
        pandoc -f markdown -t odt ${MD}                            
        ;;
    md)
        echo "Content-type: text/markdown; charset=\"utf-8\""
        echo "Content-disposition: attachment; filename=\"${user}.${output}\""
        echo
        cat ${MD}                                                        
        ;;
    *)
        echo "Content-type: text/html; charset=\"utf-8\""
        echo
        pandoc -f markdown -t html ${MD}                            
        ;;
esac
