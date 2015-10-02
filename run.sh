#!/bin/bash

# Maps simpleHTTPServer 8000 to 80 externally
# Makes work directory appear in /project
docker run \
-p 80:8000 \
-v ~/Testing:/project \
-ti chrisramsay/pydock \
/bin/bash
