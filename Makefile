# GeTinConf system package generator
#
#    Copyright (C) 2013 Fundació Guifi.net 
#
#    Thiss program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Contributors: Agustí Moll i Garcia <agusti.moll@guifi.net>
#
VERSION = 0.5
NAME = getinconf-client
PACKAGE_VERSION=1_all
SOURCEDIR = $(NAME)-$(VERSION)
TGZNAME = $(NAME)-$(VERSION).tar.gz
SRC = src/
TMP = tmp/
EMAIL = agusti.moll@guifi.net
FULLNAME = Agustí Moll i Garcia
SIGNED ?= Yes
ifeq ($(SIGNED), Yes)
	DEBUILD_OPTIONS =
else
	DEBUILD_OPTIONS = -us -uc
endif
# Config info
GTC_SERVER_URL ?= "http://vpn.qmp.cat/index.php"
NETWORK_NAME ?= demo
NETWORK_KEY ?= demo
INTERNAL_DEV ?= eth0

define config_client_generator
	@echo "Make a config file in $1"
	@echo "GTC_SERVER_URL=\"$(GTC_SERVER_URL)\"" > $1
	@echo "NETWORK_NAME=\"$(NETWORK_NAME)\"" >> $1
	@echo "NETWORK_KEY=\"$(NETWORK_KEY)\"" >> $1
	@echo "INTERNAL_DEV=\"$(INTERNAL_DEV)\"" >> $1
endef

all: tgz buildpkg
	@echo "Did it!"

all_genconf: tgz_genconf buildpkg
	@echo "Did it with configfile!"

tgz:
	@echo "Create .tgz"
	@cd $(SRC);tar zcf ../$(TGZNAME) $(SOURCEDIR)

tgz_genconf:
	@echo "Copy $(SRC) to $(TMP)"
	rm -rf $(TMP)
	mkdir -p $(TMP) 
	cp -dpR $(SRC)* $(TMP)
	@echo "Generat config file"
	$(call config_client_generator, $(TMP)$(SOURCEDIR)/getinconf-client.conf)
	@echo "Create .tgz"
	@cd $(TMP);tar zcf ../$(TGZNAME) $(SOURCEDIR)
	rm -rf $(TMP)

cleanpkg:
	@echo "Remove debuild"
	@rm -f $(NAME)_$(VERSION)*
	@rm -rf $(SOURCEDIR)
	@rm -f $(TGZNAME)

preparepkg:
	@tar zxf $(TGZNAME)

makepkg:
	@cd $(SOURCEDIR); yes | DEBFULLNAME="$(FULLNAME)" dh_make -f ../$(TGZNAME) -i -e $(EMAIL) -c gpl2

preinstallpkg:
	cp -dpR debpkg/* $(SOURCEDIR)/debian/

installpkg:
	@cd $(SOURCEDIR); debuild ${DEBUILD_OPTIONS}

buildpkg:	preparepkg makepkg preinstallpkg installpkg
	@echo "buidlpkg"

install:
	sudo dpkg -i ./${NAME}_${VERSION}-${PACKAGE_VERSION}.deb

uninstall:
	sudo dpkg -P ${NAME}

