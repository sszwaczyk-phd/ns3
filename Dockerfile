FROM ubuntu:16.04 

MAINTAINER Sebastian Szwaczyk "sszwaczyk@gmail.com"

#Install requirements
RUN apt-get update && apt-get install -y gcc g++ python python-dev mercurial python-setuptools git

#Qt5 for netanim animator
RUN apt-get install -y qt5-default

#Support for ns-3-pyviz visualizer
RUN apt-get -y install python-pygraphviz python-kiwi python-pygoocanvas libgoocanvas-dev ipython

#Support for MPI-based distributed emulation
RUN apt-get -y install openmpi-bin openmpi-common openmpi-doc libopenmpi-dev

#Support for bake build tool
RUN apt-get -y install autoconf cvs bzr unrar

#Debugging
RUN apt-get install -y gdb valgrind

#Support for utils/check-style.py code style check program
RUN apt-get -y install uncrustify

#Doxygen and related inline documentation:
###RUN apt-get -y install doxygen graphviz imagemagick
RUN apt-get -y install texlive texlive-extra-utils texlive-latex-extra texlive-font-utils texlive-lang-portuguese dvipng

#The ns-3 manual and tutorial are written in reStructuredText for Sphinx (doc/tutorial, doc/manual, doc/models), and figures typically in dia (also needs the texlive packages above)
RUN apt-get -y install python-sphinx dia

#GNU Scientific Library (GSL) support for more accurate WiFi error models
RUN apt-get -y install gsl-bin libgsl2 libgsl-dev

#The Network Simulation Cradle (nsc) requires the flex lexical analyzer and bison parser generator
RUN apt-get -y install flex bison libfl-dev

#To read pcap packet traces
RUN apt-get -y install tcpdump

#Database support for statistics framework
RUN apt-get -y install sqlite sqlite3 libsqlite3-dev

#Xml-based version of the config store (requires libxml2 >= version 2.7)
RUN apt-get -y install libxml2 libxml2-dev

#Support for generating modified python bindings 
RUN apt-get -y install cmake libc6-dev libc6-dev-i386 libclang-dev

#A GTK-based configuration system
RUN apt-get -y install libgtk2.0-0 libgtk2.0-dev

#To experiment with virtual machines and ns-3
RUN apt-get -y install vtun lxc

#Support for openflow module (requires some boost libraries)
RUN apt-get -y install libboost-signals-dev libboost-filesystem-dev

#Download ns-3
WORKDIR /usr
RUN apt-get install -y wget && wget http://www.nsnam.org/release/ns-allinone-3.27.tar.bz2 

#Unpack ns-3 tarball
RUN tar -xf ns-allinone-3.27.tar.bz2

#Build ns-3
RUN cd ns-allinone-3.27 && ./build.py --enable-examples --enable-tests

#JAVA-install
#RUN apt-get update && \
#    apt-get upgrade -y && \
#    apt-get install -y  software-properties-common && \
#    add-apt-repository ppa:webupd8team/java -y && \
#    apt-get update && \
#    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
#    apt-get install -y oracle-java8-installer && \
#   apt-get clean

#Download eclipse
#RUN wget -O /tmp/eclipse.tar.gz http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/oxygen/1a/eclipse-cpp-oxygen-1a-linux-gtk-x86_64.tar.gz 
#RUN tar -zxvf /tmp/eclipse.tar.gz -C /home/developer
#RUN ln -s /home/developer/eclipse/eclipse /usr/local/bin/eclipse
#RUN apt-get -y install adwaita-icon-theme ant ant-optional binfmt-support dbus-x11 default-jdk default-jdk-headless default-jre default-jre-headless fastjar fontconfig gconf-service gconf-service-backend #gconf2 gconf2-common gtk-update-icon-cache hicolor-icon-theme humanity-icon-theme jarwrapper junit junit4 libapache-pom-java \
#  libart-2.0-2 libasm-java libasm3-java libasound2 libasound2-data libatk1.0-0 libatk1.0-data libavahi-client3 libavahi-common-data libavahi-common3 libavahi-glib1 libbonobo2-0 libbonobo2-common \
#  libbonoboui2-0 libbonoboui2-common libcairo2 libcanberra0 libcglib-java libcommons-beanutils-java libcommons-cli-java libcommons-codec-java libcommons-collections3-java libcommons-compress-java \
#  libcommons-dbcp-java libcommons-digester-java libcommons-httpclient-java libcommons-logging-java libcommons-parent-java libcommons-pool-java libcroco3 libcups2 libdatrie1 libdb-java libdb-je-java \
#  libdb5.3-java libdb5.3-java-jni libeasymock-java libecj-java libequinox-osgi-java libfelix-bundlerepository-java libfelix-gogo-command-java libfelix-gogo-runtime-java libfelix-gogo-shell-java \
#  libfelix-osgi-obr-java libfelix-shell-java libfelix-utils-java libgail-common libgail18 libgconf-2-4 libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-bin libgdk-pixbuf2.0-common libglade2-0 libgnome-2-0 \
#  libgnome-keyring-common libgnome-keyring0 libgnome2-common libgnomecanvas2-0 libgnomecanvas2-common libgnomeui-0 libgnomeui-common libgnomevfs2-0 libgnomevfs2-common libgraphite2-3 libgtk2.0-0 \
#  libgtk2.0-bin libgtk2.0-common libhamcrest-java libharfbuzz0b libicu4j-4.2-java libicu4j-49-java libjbig0 libjetty9-java libjline-java libjpeg-turbo8 libjpeg8 libjsch-java libjtidy-java libjzlib-java \
#  libkxml2-java liblucene2-java libobjenesis-java libogg0 liborbit-2-0 libosgi-annotation-java libosgi-compendium-java libosgi-core-java libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpipeline1 \
#  libpixman-1-0 libregexp-java librsvg2-2 librsvg2-common libservlet3.1-java libswt-cairo-gtk-3-jni libswt-glx-gtk-3-jni libswt-gnome-gtk-3-jni libswt-gtk-3-java libswt-gtk-3-jni libswt-webkit-gtk-3-jni \
#  libtdb1 libthai-data libthai0 libtiff5 libtomcat8-java libvorbis0a libvorbisfile3 libxcb-render0 libxcb-shm0 libxcursor1 sat4j sound-theme-freedesktop ubuntu-mono

#Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt && \
  rm /usr/ns-allinone-3.27.tar.bz2




