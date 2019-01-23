#!/bin/bash
set -e

git push --force https://\$bat-staging-manage-courses-support-app:$APP_CREDENTIALS_STAGING_PWD@bat-staging-manage-courses-support-app.scm.azurewebsites.net:443/bat-staging-manage-courses-support-app.git HEAD:refs/heads/master
