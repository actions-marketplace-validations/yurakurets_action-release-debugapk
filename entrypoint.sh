#!/bin/bash

hub checkout ${${REPO_BRANCH}:-master}
VERSION_NAME=`grep -oP 'versionName "\K(.*?)(?=")' ./${APP_FOLDER}/build.gradle`
hub release create -a ./${APP_FOLDER} -m "${RELEASE_TITLE} - $(date '+%d.%m.%Y %H:%M:%S')" $(date +%Y%m%d%H%M%S)
