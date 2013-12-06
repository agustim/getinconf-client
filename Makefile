VERSION = 0.1
NAME = getinconf-client
PACKAGE_VERSION=1_all
SOURCEDIR = $(NAME)-$(VERSION)
TGZNAME = $(NAME)-$(VERSION).tar.gz
SRC = src/
EMAIL = agusti.moll@guifi.net
FULLNAME = Agustí Moll

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
	@cd $(SOURCEDIR); DEBFULLNAME="$(FULLNAME)" yes | dh_make -f ../$(TGZNAME) -i -e $(EMAIL) -c gpl2

preinstallpkg:
	cp -dpR debpkg/* $(SOURCEDIR)/debian/

installpkg:
	@cd $(SOURCEDIR); debuild -us -uc

buildpkg:	preparepkg makepkg preinstallpkg installpkg
	@echo "buidlpkg"

install:
	sudo dpkg -i ./${NAME}_${VERSION}-${PACKAGE_VERSION}.deb

uninstall:
	sudo dpkg -P ${NAME}