# Musl toolchains in a docker image

Because musl.cc blocks Microsoft IP ranges from curling the toolchains (see https://github.com/orgs/community/discussions/27906) and GH actions run on MS infra, it's handy to have a docker image that contains the toolchains.
