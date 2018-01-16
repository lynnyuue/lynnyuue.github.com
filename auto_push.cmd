@echo off
rem "check ssh key"
IF EXIST /.ssh/id_rsa goto update
rem "copy ssh kye"
cp %USERPROFILE%"/.ssh/id_rsa" /.ssh/id_rsa
cp %USERPROFILE%"/.ssh/id_rsa.pub" /.ssh/id_rsa.pub

:update
rem "git pull"
git pull origin
rem "git check and commit"
git status && git add * && git commit -a -m "automatic commit" && git push origin master
rem "done"