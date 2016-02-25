STABILITY=dev

default: satis package

satis: clean
	@composer create-project composer/satis --stability=$(STABILITY) --keep-vcs$
	@mkdir -p debian/opt/
  @rm -rf satis/.git
	@cp -r satis debian/opt/

package:
	@fakeroot make finish

finish:
	@chown -R root:root debian
	@dpkg-deb --build debian .

clean:
	@rm -rf debian/usr
	@rm -f *.deb
	@rm -rf satis/

.PHONY: default
