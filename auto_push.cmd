@echo off
rem "git pull"
git pull
rem "git check and commit"
git status && git add * && git commit -m "automatic commit" && git push
rem "done"