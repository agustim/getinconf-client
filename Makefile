VERSION = 0.1
NAME = getinconf-client
SOURCEDIR = $(NAME)-$(VERSION)
TGZNAME = $(NAME)-$(VERSION).tar.gz
SRC = "src/"

all: tgz buildpkg
	@echo "Did it!"

tgz:
	@echo "Create .tgz"
	@cd $(SRC);tar zcfv ../$(TGZNAME) $(SOURCEDIR)

cleanpkg:
	@echo "Remove debuild"
	@rm -f $(NAME)_$(VERSION)*
	@rm -rf $(SOURCEDIR)
	@rm -f $(TGZNAME)

preparepkg:
	@tar zxvf $(TGZNAME)

makepkg:
	@cd $(SOURCEDIR); dh_make -f ../$(TGZNAME)

installpkg:
	@cd $(SOURCEDIR); debuild -us -uc

buildpkg:	preparepkg makepkg installpkg
	@echo "buidlpkg"
