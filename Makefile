
# https://github.com/envygeeks/jekyll-docker

serve:
	docker run -ti --rm -v "$$PWD:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve --watch --drafts $(FLAGS)

