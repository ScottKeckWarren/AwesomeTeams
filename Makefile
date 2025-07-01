
## static code analysis

### PreCommit Section
CHANGED_PHP_FILES = git diff --diff-filter=AM --staged --name-only app tests scripts | grep ".php"
pre-commit: phpcs_changed phpstan_changed

#lint_changed:
#	${CHANGED_PHP_FILES} | xargs vendor/bin/parallel-lint

phpcs_changed:
	${CHANGED_PHP_FILES} | xargs vendor/bin/phpcs --standard=phpcs.xml

phpstan_changed:
	${CHANGED_PHP_FILES} | xargs vendor/bin/phpstan analyze  --memory-limit 1G

#rector_changed:
#	${CHANGED_PHP_FILES} | xargs vendor/bin/rector process --dry-run

### Full Static Code Analysis Section
phpcbf:
	vendor/bin/phpcbf --standard=phpcs.xml app tests scripts

phpcs:
	vendor/bin/phpcs --standard=phpcs.xml app tests scripts

phpstan:
	vendor/bin/phpstan analyze  --memory-limit 1G -l9 app tests



## Helpers
update-atomic-commit:
	git commit -a --amend
	git push --force-with-lease

back-to-trunk:
	git checkout main
	git pull
