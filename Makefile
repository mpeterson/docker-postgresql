AUTHOR=mpeterson
NAME=postgresql
VERSION=0.3

.PHONY: all build tag_latest

all: build

build:
	docker build -t $(AUTHOR)/$(NAME):$(VERSION) --rm image

tag_latest:
	docker tag $(AUTHOR)/$(NAME):$(VERSION) $(AUTHOR)/$(NAME):latest
