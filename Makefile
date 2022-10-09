
# https://github.com/envygeeks/jekyll-docker

JEKYLL = docker run -ti --rm -v "$$PWD:/srv/jekyll" -p 4000:4000 jekyll/jekyll:4.2.0 jekyll

serve:
	$(JEKYLL) serve --watch --drafts $(FLAGS)

publish:
	$(JEKYLL) publish `find _drafts/ -name '*.markdown'`

