

## Helpers
update-atomic-commit:
	git commit -a --amend
	git push --force-with-lease

back-to-trunk:
	git checkout main
	git pull
