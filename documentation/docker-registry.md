## Notes

### Docker Registry version

Latest version from master is currently used (https://github.com/docker/docker-registry) because I was not successfull with tagged releases from oficial docker repository. 

### Ansible

The ansible role is doing following things which are not ideal but will suffice for POC:
- List all machines in coreos cluster and choose first one which will be used for docker registry purpose
- Create unit files
 - Install registry
  - Download master from github
  - Build docker image
  - Prepare config file
 - Run registry
  - Wait for install registry to build image
  - Run registry on same machine

## Installation

this run should be run only once because its not ensured that registry won't be run on another machine than is running after first start and no detection is currently provided. Again it should suffice for POC, maybe separate main playbook file will be provided just for this purpose.

To start registry all you should need is to run 
```
ansible-playbook playbook_install_coreos.yml -i inventory.yml  -vvv  --tags=configuration,fleet_submit_registry,fleet_start_registry
```

## TODOs
- [ ] Run registry behing nginx
 - verification
- [ ] Use permanent storage
 - S3
 - nfs mount point
 - whatever is beter than local storage as is now
- [ ] Reliably respawn or run in ha
