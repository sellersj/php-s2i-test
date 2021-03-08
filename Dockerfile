FROM registry.redhat.io/rhel8/php-74
#FROM registry.access.redhat.com/ubi8/php-73

USER root

# Update the image with the latest packages (recommended), then
# Install php-xmlrpc module from RHSCL repo, remove override_install_langs so all locales can be installed, install glibc-common for all locales (locale -a)
RUN yum update -y && \
yum list installed langpacks* && \
    yum install -y glibc-all-langpacks.x86_64  && \
    yum clean all

#yum list all && \
    #yum install -y langpacks-fr  && \

# Might want to refine this (something more specific than $APP_DATA)
RUN chgrp -Rf root $APP_DATA && \
    chmod -Rf g+w $APP_DATA && \
    cd $APP_DATA && \
    umask 002

USER 1001
