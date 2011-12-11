PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
DATADIR=$(PREFIX)/share
MANDIR=$(DATADIR)/man

INSTALL=/usr/bin/install

name=snap
fullname=Snap
version=0.3.3

doc: $(name).1 $(name).html

install: $(name).1
	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
	$(INSTALL) $(name) $(DESTDIR)$(BINDIR)
	$(INSTALL) -d -m 755 $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) -m 644 $(name).1 $(DESTDIR)$(MANDIR)/man1

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
