# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# place .nojekyll to bypass Jekyll processing
echo > .nojekyll

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git checkout -B main
git add -A
git commit -m 'deploy'


# if you are deploying to https://engineerjohnson.github.io
# git push -f git@github.com:engineerjohnson/engineerjohnson.github.io.git main

# if you are deploying to https://engineerjohnson.github.io/<REPO>
git push -f https://github.com/engineerjohnson/F2E2023Vote.git main:gh-pages

cd