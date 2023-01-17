JEKYLL_COMMAND=bundle exec jekyll

.PHONY: clean
clean:
	${JEKYLL_COMMAND} clean

.PHONY: profile
profile: clean
profile:
	${JEKYLL_COMMAND} build --strict_front_matter --profile

.PHONY: server
server: clean
server:
	${JEKYLL_COMMAND} server --watch --drafts --unpublished --strict_front_matter --livereload --open-url

TARGET_COMMIT=$(shell git log --oneline --all  | awk '{print $$1}' | tail -n 2 | head -n 1)

.PHONY: squash_and_push
squash_and_push: clean
squash_and_push:
	git reset --soft ${TARGET_COMMIT}
	git commit --all --amend --no-edit
	git push --force

.PHONY: commit_and_push
commit_and_push: clean
commit_and_push:
	git add .
	git commit -m WIP
	git push --force
