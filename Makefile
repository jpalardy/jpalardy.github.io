
# https://github.com/envygeeks/jekyll-docker

serve:
	docker run -ti --rm -v "$$PWD:/srv/jekyll" -p 4000:4000 jekyll/jekyll:4.2.0 jekyll serve --watch --drafts $(FLAGS)

