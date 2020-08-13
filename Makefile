js:
	npm run build
#	coffee -b -c realurl.coffee
#	coffee -b -c crypt.coffee

#
# Chromeエクステンション公開用のzipを作る
#
ZIPFILES=\
	manifest.json \
	realurl.js \
	jquery-2.1.4.min.js \
	md5.js \
	crypt.js \
	setting.js \
	setting.html \
	icons/realurl-48.png \
	icons/realurl-96.png \
	icons/realurl-128.png

zip: js
	/bin/rm -f realurl.zip
	zip -r realurl.zip ${ZIPFILES}

