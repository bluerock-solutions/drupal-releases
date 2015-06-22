This respoitory contains tagged releases of Drupal imported from http://git.drupal.org/project/drupal.git.

The release versions are on the 'vanilla' branch and each one is tagged as 'vanilla/*drupal version number*'.

The submodule deployment versions with no sites directory are on the 'no_sites' branch and each one is tagged as 'no_sites/*drupal version number*'.

#####To add to a project as a submodule:

* `git submodule add -b no_sites https://github.com/bluerock-solutions/drupal-releases.git drupal`
* `ln -nfsT ../sites drupal/sites`
* `cp -a drupal/example.sites sites`

#####To update Drupal in a project:

* Either this (simple update to latest no_sites but will remove your sites symlink)
    * `git submodule update --remote drupal`
* Or this
    * `cd drupal`
    * `git fetch`
    * `git checkout no_sites` # Can replace no_sites with nosites/x.yz if you want a specific version
    * `cd -`
* Commit update

#####To import a new upstream release:

If you've not cloned the repository before, start here...

|   	| Command 							  	| Comment 									|
|---	|---									|---										|
| 1.	| `git fetch upstream`							| Clone and disable autocrlf so line endings stay the same as upstream.		|
| 2. 	| `git remote add upstream http://git.drupal.org/project/drupal.git`	| Add drupal core as an upstream.						|

Otherwise, start here. Probably wouldn't hurt to do a `git reset --hard HEAD` before you crack on.

|   	| Command 					  	| Comment 											|
|---	|---							|---												|
| 1.	| `git fetch upstream`					| Fetches the latest changes from drupal core.							|
| 2.	| `git checkout vanilla`				| Checkout the vanilla branch (where we store the clean drupal core).				|
| 3.	| See Comment. No way I'm putting an rm command here!	| delete (use rm) * .gitignore .htaccess (need to remove all file & dirs EXCEPT .git). 		|
| 4. 	| `ls -A`						| Directory listing, should show nothing buy .git.						|
| 5.	| `export vdrupal=x.yz`					| Where x.yz is the new Drupal version. Convenience variable.					|
| 6.	| `git checkout $vdrupal -- .`				| Pull the files from next Drupal version, discarding anything in the local copy.		|
| 7.	| `git add --all`					| Stage everything.										|
| 8. 	| `git commit -m "$(echo -e "Drupal $vdrupal\n\n$(git log $vdrupal -n 1)")"`	| Commit with a message referencing the Drupal version / commit.	|
| 9.	| `git diff $vdrupal --numstat`				| Check every thing matches original commit - should show no output.				|
| 10.	| `git tag vanilla/$vdrupal`				| Tag the vanilla commit.									|
| 11.	| `git checkout no_sites`				| Switch to our no_sites branch (the one without the "sites" directory.				|
| 12.	| `git merge vanilla/$vdrupal --no-commit`		| Merge the vanilla branch in, ensuring **no merge conflicts**.					|
| 13.	| `git diff vanilla/$vdrupal --numstat`			| Should show 3 lines added to .gitignore and all sites/* should be renamed to example.sites/*.	|
| 14.	| `ls -d *sites*`					| Should show example.sites and **NOT** sites.							|
| 15.	| `git commit --no-edit`				| Commit all the things.									|
| 16.	| `git tag no_sites/$vdrupal`				| Tag the no_sites commit.									|
| 17.	| `git push origin vanilla no_sites vanilla/$vdrupal no_sites/$vdrupal` | Push it back to github							|

