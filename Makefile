PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
MANDIR=$(PREFIX)/man

INSTALL=/usr/bin/install -m 644
INSTALL_DIR=/usr/bin/install -d -m 755
INSTALL_BIN=/usr/bin/install -m 755

name=snap
fullname=Snap
version=0.3.3

install: $(name).1
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_BIN) $(name) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) $(name).1 $(DESTDIR)$(MANDIR)/man1

doc: $(name).1 $(name).html

$(name).html: $(name).1.ronn
	ronn --html --style=toc \
	     --manual="$(fullname) Manual" \
	     --organization="$(fullname) $(version)" \
	     $(name).1.ronn

$(name).1: $(name).1.ronn
	ronn --roff \
	     --manual="$(fullname) Manual" \
	     --organization="$(fullname) $(version)" \
	     $(name).1.ronn

.PHONY: clean
clean:
	rm -f $(name).1 $(name).1.html
