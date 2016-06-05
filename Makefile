PATH := ./node_modules/.bin:$(PATH)
APIDOCDIR = apidocs

.PHONY: apidocs apidocs-push test

test:
	coffee $$(find test -name '*.coffee') | tap-spec

apidocs:
	crojsdoc -o gh-pages/apidocs --theme kba -f src

apidocs-deploy:
	make apidocs &&  \
	cd gh-pages &&  \
	git add apidocs &&  \
	git commit -m "Update apidocs `date`" &&  \
	git push

clean:
	rm $(APIDOCDIR)
