This respoitory contains tagged releases of Drupal imported from http://git.drupal.org/project/drupal.git.

The release versions are on the 'vanilla' branch and each one is tagged as 'vanilla/*drupal version number*'.

The submodule deployment versions with no sites directory are on the 'no_sites' branch and each one is tagged as 'no_sites/*drupal version number*'.

#####To add to a project as a submodule:

* `git submodule add -b no_sites https://github.com/bluerock-solutions/drupal-releases.git drupal`
* `ln -nfsT ../sites drupal/sites`
* `cp -a drupal/example.sites sites`

#####To update Drupal in a project:

* `git submodule update --remote drupal`
* Commit update

#####To import a new upstream release:

* `git remote add upstream http://git.drupal.org/project/drupal.git`
* `git fetch upstream`
* `git checkout vanilla`
* delete (use rm) * .gitignore .htaccess (need to remove all file & dirs EXCEPT .git)
* `ls -A` # should show .git only
* `export vdrupal=x.yz` # set to next Drupal version - should point to the drupal repo tag for the next release
* `git checkout $vdrupal -- .` # Pull files from next Drupal version
* `git add --all`
* `git commit -m "$(echo -e "Drupal $vdrupal\n\n$(git log $vdrupal -n 1)")"`
* `git diff $vdrupal --stat` # Check every thing matches original commit - should show no output
* `git tag vanilla/$vdrupal`
* `git checkout no_sites`
* `git merge vanilla/$vdrupal --no-commit`
* Ensure no merge conflicts
* `git diff vanilla/$vdrupal --stat` # Should show 3 lines added to .gitignore and all sites/* should be renamed to example.sites/*
* `ls -d *sites*` # Should show example.sites and NOT sites
* `git commit --no-edit`
* `git tag no_sites/$vdrupal`
* `git push origin vanilla no_sites vanilla/$vdrupal no_sites/$vdrupal`
