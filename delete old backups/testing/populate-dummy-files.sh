#run ./dummy/shopware-5-populate-dummy-files.sh to create Backup File Dummie
#populate 90 Backup Files for Testing
#From Today's Date to -90 days back in time.

for ((i=-1; i>=-44; i--))
do
  touch "./dummy/$(date -d "${i} day" +'%Y-%m-%d').tar.gz"
done