#!/bin/sh

# Credit to:
# https://github.com/BryanSchuetz/jekyll-deploy-gh-pages/blob/master/entrypoint.sh
# https://github.com/envygeeks/jekyll-docker/blob/master/README.md
docker -v
docker-compose -v
docker-compose up aws

exit 0

chmod -R 777 docs
cd docs
echo '👍 ENTRYPOINT HAS STARTED—INSTALLING THE GEM BUNDLE'
bundle install
bundle list | grep "jekyll ("
echo '👍 BUNDLE INSTALLED—BUILDING THE SITE'
echo 'Jekyll version'
bundle exec jekyll --version
bundle exec jekyll build --draft
echo '👍 THE SITE IS BUILT—PUSHING IT BACK TO GITHUB-PAGES'
cd _site
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
remote_branch="gh-pages" && \

echo ' Create cname and robot.txt'
echo $2 > CNAME

# Disallow robots crawling if not on the producation site
if [[ ! $2 =~ '*nyulawglobal.org*' ]]; then
    echo -e "User-agent: * \n Disallow: /" > robots.txt
fi


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












exit 0
# echo "Start docker service"
# service docker start

echo "Current directory"
pwd

echo " Listing"
ls


export JEKYLL_VERSION=$1
echo "Running docker jekyll/jekyll:$1"


# docker run --rm \
#     # --name "jekyll_container"
#     --volume="$PWD:/srv/jekyll" \
#     -it jekyll/jekyll:$JEKYLL_VERSION \
#     ls

# --volume="/github/workspace/docs/_site:/srv/jekyll/_site" \
docker run -v /srv/jekyll jekyll/builder:latest /bin/bash -c "chmod 777 /srv/jekyll && pwd && ls && jekyll build --draft"

# docker run -t -d --name jekyll_container --volume "$PWD/docs:/srv/jekyll" jekyll/jekyll:$JEKYLL_VERSION jekyll build

docker ps

exit 0


