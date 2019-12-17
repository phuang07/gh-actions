#!/bin/sh

# Credit to:
# https://github.com/BryanSchuetz/jekyll-deploy-gh-pages/blob/master/entrypoint.sh
# https://github.com/envygeeks/jekyll-docker/blob/master/README.md

echo "Start docker service"
service docker start

export JEKYLL_VERSION=$1
echo "Running docker jekyll/jekyll:$1"
echo "Current directory: $(`pwd`)"

ls
docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  -it jekyll/jekyll:JEKYLL_VERSION \
  ls
  #jekyll build --draft


exit 0



echo '👍 ENTRYPOINT HAS STARTED—INSTALLING THE GEM BUNDLE'
bundle install
bundle list | grep "jekyll ("
echo '👍 BUNDLE INSTALLED—BUILDING THE SITE'
bundle exec jekyll build
echo '👍 THE SITE IS BUILT—PUSHING IT BACK TO GITHUB-PAGES'
cd _site
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
remote_branch="gh-pages" && \
git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
git add . && \
echo -n 'Files to Commit:' && ls -l | wc -l && \
git commit -m'action build' > /dev/null 2>&1 && \
git push --force $remote_repo master:$remote_branch > /dev/null 2>&1 && \
rm -fr .git && \
cd ../
echo '👍 GREAT SUCCESS!'
