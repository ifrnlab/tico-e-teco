#!/bin/zsh


info=(${(@s:/:)PATH_INFO})

if (( ${+info[1]} ))
    then
        user_name=${info[1]}
        user_fn=$(getent passwd $user_name | cut -d: -f5 | cut -d, -f1)
        if (( ${+user_fn} )) 
            then
                MD="/tmp/modelo-${user_name}.md"
                sed "s/NOME/${user_fn}/" modelo.md > "${MD}"

                if (( ${+info[2]} ))
                    then
                        output="${info[2]}"
                        case $output in
                            docx)
                                echo "Content-type: application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                echo "Content-disposition: attachment; filename=\"${user_name}.${output}\""
                                echo
                                pandoc -f markdown -t docx ${MD}
                                ;;
                            odt)
                                echo "Content-type: application/vnd.oasis.opendocument.text"
                                echo "Content-disposition: attachment; filename=\"${user_name}.${output}\""
                                echo
                                pandoc -f markdown -t odt ${MD}                            
                                ;;
                            md)
                                echo "Content-type: text/markdown; charset=\"utf-8\""
                                echo "Content-disposition: attachment; filename=\"${user_name}.${output}\""
                                echo
                                cat ${MD}                                                        
                                ;;
                            *)
                                echo "Content-type: text/html; charset=\"utf-8\""
                                echo
                                pandoc -f markdown -t html ${MD}                            
                                ;;
                        esac
                    else
                        echo "Content-type: text/html; charset=\"utf-8\""
                        echo
                        pandoc -f markdown -t html ${MD}
                fi
            fi

    fi
