docker_climate
==============


Prerequisites : 
 * Install Docker>=0.8.1

For building a Docker image containing Climate, please issue:

  sudo docker build -t climate .

For running a container based on Climate docker image, please issue:
  sudo docker run -p 1234:1234 -i -t climate /bin/bash

If you want to map another host port, please see here  for further info:
http://docs.docker.io/en/latest/use/port_redirection/

