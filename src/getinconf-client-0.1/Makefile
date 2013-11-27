INSTALLDIR = $(DESTDIR)

all:
	@echo "Necessitats concretes."
	@echo "Nothing here."

clean:
	@echo "Netejar fitxers."
	@echo "Nothing here."

install:
	@echo "Make directory"
	mkdir -p $(INSTALLDIR)/usr/sbin
	mkdir -p $(INSTALLDIR)/etc
	@echo "Install files"	
	install -m 0755 stvclient $(INSTALLDIR)/usr/sbin
	install -m 0600 getinconf-client.conf $(INSTALLDIR)/etc/getinconf-client.conf
