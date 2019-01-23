#!/bin/bash
set -e

git push --force https://\$bat-dev-manage-courses-support-app:$APP_CREDENTIALS_DEV_PWD@bat-dev-manage-courses-support-app.scm.azurewebsites.net:443/bat-dev-manage-courses-support-app.git HEAD:refs/heads/master
