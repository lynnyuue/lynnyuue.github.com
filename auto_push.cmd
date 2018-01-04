@echo off
rem "git pull"
git pull
rem "git check and commit"
git status && git add * && git commit -a -m "automatic commit" && git push origin master
rem "done"