# docker-cmk
Simple Check_MK Remote Site

# To build:
docker build --tag mrworta:CMK .

# To run:
docker run -d -it -p 6557:6557 -p 8080:5000 mrworta:CMK /bin/bash

# Default credentials are:
# User omdadmin / Pass omd
