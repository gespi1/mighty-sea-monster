These text maniputaion one liners are scripts based off of my experiences

## 4-1
The issue here was that the etcd certs were expired and I needed etcd to recycle the certs for me. After deleteing the certs etcd was able to generate an new set of valid certs. However after recycling the certs any service-account-tokens on kubernetes were invalid ([related issue](https://github.com/kubernetes/kops/issues/8959#issuecomment-763977091)). So i took all the service-account-token type secrets on the cluster and removed them all at once with this oneliner. The SA's were able to recreate their service-account-token secrets immediately afterwards.

## 4-2
We had a gitlab runner that was filled with tons of Exited containers and the disk was constantly being filled. This was years ago and do not remember why i targeted Exited containers that were older than a certain date, pretty sure i was being cautious for a reason.

some key points on that script:
- `sed 's+\".*\"++'` - needed to remove the entrypoints column from that list of containers because it was messing up what values my cut would return since its delimiter were spaces.

- `cut -d ' ' -f 1,3-4` - cut would return the container ID, an interval and a unit of time (e.g. 123456 4 hours or 45345345 5 months). By default the list returned would also be sorted by the latest date thanks to docker.

- `grep -A10000 "7 weeks"` - wanted to choose and remove any Exited containers older than 7 weeks. `grep -A10000` would grab the next 10000 lines following the finding of `7 weeks`. 

- `cut -d ' ' -f 1 | while read line; do echo "deleting ${line}"; docker rm  $line; done` - lastly i took the container IDs and looped through them line by line while also docker rm'ing them.

## 4-3 
At my current company we use Hashicorp Vault Approles. Sometimes we need to tie an Approle ID to a Approle Name. The Vault CLI nor UI help with correlating such. So i created a one liner to take care of that. It would spew out a list of approle Names and their correlating IDs. (Approle ID is not a secret key)


_______
## yes i love `while read line` :)
