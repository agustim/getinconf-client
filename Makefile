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
VERSION = 0.1
NAME = getinconf-client
PACKAGE_VERSION=1_all
SOURCEDIR = $(NAME)-$(VERSION)
TGZNAME = $(NAME)-$(VERSION).tar.gz
SRC = src/
EMAIL = agusti.moll@guifi.net
FULLNAME = Agustí Moll i Garcia
SIGNED ?= Yes
ifeq ($(SIGNED), Yes)
	DEBUILD_OPTIONS =
else
	DEBUILD_OPTIONS = -us -uc
endif


all: tgz buildpkg
	@echo "Did it!"

tgz:
	@echo "Create .tgz"
	@cd $(SRC);tar zcf ../$(TGZNAME) $(SOURCEDIR)

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
