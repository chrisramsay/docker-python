# docker-python

Docker machine for working on general Python projects. Has [IPython](https://ipython.org/) and [Jupyter](http://jupyter.readthedocs.io/en/latest/) installed.

## Build Script

There is a `build.sh` file packaged here. This is to help with further development of the container. One of a number of possible options must be passed at run time.

### build

Runs the standard `docker build` command with a few build arguments; tags as both verson and latest picking up build version from the `VERSION` file.

### release

Does not execute `docker build`. Instead modifies the `Dockerfile` replacing in-place values from the `Dockerfile.tmpl` with label values. This should be done prior to a tagged release.

### restore

Used in order to reinstate the normal `Dockerfile` for continuing development. Utility function only.

## Development Process

* Create a new release branch
* Change directory to the `build` directory
* Bump the version number in `build/VERSION`
* Run `$ ./build.sh restore` to set up a clean `Dockerfile`
* Make any required changes to `build/Dockerfile.tmpl`
* Run `$ ./build.sh build` to build current tag and latest
* Once all the work is complete, run `$ ./build.sh release`
* Merge and tag the release

***

[![](https://images.microbadger.com/badges/image/chrisramsay/docker-python.svg)](https://microbadger.com/images/chrisramsay/docker-python "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/chrisramsay/docker-python.svg)](https://microbadger.com/images/chrisramsay/docker-python "Get your own version badge on microbadger.com")
