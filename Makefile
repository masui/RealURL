js:
	coffee -b -c realurl.coffee
	coffee -b -c crypt.coffee

#
# Chromeエクステンション公開用のzipを作る
#
ZIPFILES=manifest.json realurl.js jquery-2.1.4.min.js md5.js crypt.js settings.js settings.html icons/realurl-48.png icons/realurl-96.png
zip: js
	/bin/rm -f realurl.zip
	zip -r realurl.zip ${ZIPFILES}

