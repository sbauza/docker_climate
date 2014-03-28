FROM ubuntu
MAINTAINER Sylvain Bauza <sbauza@free.fr>

#set proxies
RUN echo 'Acquire::http::Proxy "http://10.197.217.62:3128";' | tee -a /etc/apt/apt.conf
ADD http_proxy.sh /etc/profile.d/http_proxy.sh
RUN . /etc/profile.d/http_proxy.sh
ENV http_proxy http://10.197.217.62:3128
ENV https_proxy http://10.197.217.62:3128
#end set proxies

#install base
RUN apt-get install -y --force-yes build-essential python-dev 
RUN apt-get install -y --force-yes git python-setuptools screen

#install pip
ADD get-pip.py /tmp/
RUN python /tmp/get-pip.py

#checkout climate
RUN cd /opt && git clone https://github.com/stackforge/climate 

#install deps
ENV PIP_MIRROR http://pypi.openstack.org/openstack
RUN cd /opt/climate && pip install --index-url=${PIP_MIRROR} -r requirements.txt

#install climate
RUN cd /opt/climate && python setup.py install
RUN mkdir /etc/climate/
RUN mkdir /var/log/climate/
ADD climate.conf /etc/climate/

#run climate
ADD climate-screenrc /opt/
ENTRYPOINT screen -c /opt/climate-screenrc
EXPOSE 1234
