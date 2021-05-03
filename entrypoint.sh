#!/bin/bash

hub checkout ${${REPO_BRANCH}:-master}
VERSION_NAME=`grep -oP 'versionName "\K(.*?)(?=")' ./${APP_FOLDER}/build.gradle`
hub release create -a ./${APK_FOLDER} -m "${RELEASE_TITLE} ${VERSION_NAME} - $(date '+%d.%m.%Y %H:%M:%S')" $(date +%Y%m%d%H%M%S)
