#!/bin/bash

# Maps HTTP server 8888 to 80 externally
# Makes work directory appear in /project
docker run \
-p 80:8888 \
-v ~/Testing:/project \
-ti chrisramsay/pydock \
/bin/bash
