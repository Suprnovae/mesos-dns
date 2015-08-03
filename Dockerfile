FROM phusion/baseimage
MAINTAINER David Asabina <david@supr.nu>

RUN sudo apt-get update
RUN sudo apt-get install -y make binutils gcc git

#COPY glibc-2.21 /tmp/glibc-2.21
#RUN cd /tmp/glibc-2.21
#RUN make check

ENV GOPATH /home/go
ENV PATH=$PATH:${GOPATH}/bin

ENV GOROOT /usr/local/bin/go
ENV PATH=$PATH:${GOROOT}/bin

COPY go ${GOROOT}

RUN go get github.com/tools/godep

ENV MESOS_PATH=/usr/local/mesos

RUN mkdir $MESOS_PATH
RUN pwd
RUN go get -d github.com/mesosphere/mesos-dns
RUN cd $GOPATH/src/github.com/mesosphere/mesos-dns/; make all; cp $GOPATH/src/github.com/mesosphere/mesos-dns/mesos-dns $MESOS_PATH/.

ENV PATH=$PATH:$MESOS_PATH

CMD mesos-dns --config=config.json
#ENV GOROOT=/usr
#RUN which wget
#RUN ls -la /usr/bin
#RUN wget --help
#RUN wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
#RUN tar -xf go1.4.2.linux-amd64.tar.gz
#RUN ls -la
#RUN touch hereo
