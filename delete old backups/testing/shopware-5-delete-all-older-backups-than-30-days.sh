#!/usr/bin/env bash
# Deletes Backups that are older than 30 days
days=30
find_and_sort_backups=$(find ./dummy -iname '*.tar.gz' -execdir basename {} ';' | sort -n)

array_backups=( ${find_and_sort_backups} )

echo "${#array_backups[@]} Backup Files were found."


#NOCH NEWEST FILE FIXEN
echo "Newest File: ${array_backups[1]}"
echo "Oldest File: ${array_backups[0]}"



echo "Removing following Backups: "
for ((i=$((${#array_backups[@]}-days)); i>=0; i--))
do
  rm -rf "./dummy/${array_backups[$i]}"
  echo "${array_backups[$i]}"
done

echo $((${#array_backups[@]}-days))
echo "rechnung: $((${#array_backups[@]}+1))"
