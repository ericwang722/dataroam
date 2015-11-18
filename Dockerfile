FROM centos:centos7
MAINTAINER qy

# Upgrade...
RUN yum upgrade -y
# add EPEL repo
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update

#install AWS CLI 
RUN yum -y update && \
    yum -y install python-pip && \
    pip install awscli 

#install openssh client
RUN yum install openssh-clients.x86_64 -y

#add DNS register scripts and template
ADD scripts/attach-storage.sh  ./dataroam/attach-storage.sh

RUN chmod 755 ./dataroam/attach-storage.sh

# Ignore the host key checking
RUN mkdir -p ~/.ssh; cd ~/.ssh; touch config; echo "StrictHostKeyChecking no" >> config; chmod 400 config
	
# attach-storage
CMD ["./dataroam/attach-storage.sh"]
