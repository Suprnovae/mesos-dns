image:
	docker build --force-rm=true -t mesos_dns .

run:
	docker run -it --rm=true --name mesos_dns mesos_dns bash

unimage:
	docker rmi mesos_dns
	
unrun:
	docker rm mesos_dns

.PHONY: image run
