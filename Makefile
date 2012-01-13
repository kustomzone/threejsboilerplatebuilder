# makefile to automatize simple operations

server:
	python -m SimpleHTTPServer

deploy: build
	# assume there is something to commit
	# use "git diff --exit-code HEAD" to know if there is something to commit
	# so two lines: one if no commit, one if something to commit 
	git commit -a -m "New deploy" && git push -f origin HEAD:gh-pages && git reset HEAD~


build:	buildOrigFilelist buildTmplFilelist 
clean:	cleanOrigFilelist cleanTmplFilelist

buildOrigFilelist:
	echo "var origFileList = ["	> origFileList.js
	(cd template/boilerplate.orig/ && find . -type f | awk '{print "\t\""$$1"\","}' | tee -a ../../origFileList.js)
	echo "];"			>> origFileList.js

cleanOrigFilelist:
	rm origFileList.js

buildTmplFilelist:
	echo "var tmplFileList = ["	> tmplFileList.js
	(cd template/boilerplate.tmpl/ && find . -type f | awk '{print "\t\""$$1"\","}' | tee -a ../../tmplFileList.js)
	echo "];"			>> tmplFileList.js

cleanTmplFilelist:
	rm tmplFileList.js