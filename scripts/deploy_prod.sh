#!/bin/bash
set -e

git push --force https://\$bat-prod-manage-courses-support-app:$APP_CREDENTIALS_PROD_PWD@bat-prod-manage-courses-support-app.scm.azurewebsites.net:443/bat-prod-manage-courses-support-app.git HEAD:refs/heads/master
