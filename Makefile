default: clean
	mkdir -p result/h5bp
	cp -R `/bin/ls -l | grep "paulirish-html5-boilerplate" | awk '{print $$8}'`/* result/h5bp
	cp src/django-patterns.txt result/h5bp/build/config/
	patch result/h5bp/build/build.xml src/build.patch
	sed -f src/boilerplate.convert.sed result/h5bp/index.html > tmp.html
	mv tmp.html result/h5bp/index.html

clean:
	rm -rf result
