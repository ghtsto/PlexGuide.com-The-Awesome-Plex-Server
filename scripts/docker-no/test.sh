##date +"%Y-%m-%d-%T"


d=$(date +%Y-%m-%d-%T)
echo "$d"

mfolder="/mnt/gdrive/plexguide/backup.old/backup-"
mpath="$mfolder$d"

mkdir /mnt/gdrive/plexguide/backup.old/
mkdir $mpath
mv /mnt/gdrive/plexguide/backup/* $mpath

docker ps -a --format "{{.Names}}"  > /opt/appdata/plexguide/running

while read p; do
  echo $p > /tmp/program_var
  ansible-playbook /opt/plexguide/pg.yml --tags backup
done </opt/appdata/plexguide/running
