# action-release-debugapk

![screenshot](screenshot.png)

🕷 Build and release APK from your Android project

## Warning ⚠
Add a target branch (eg. master) to build the APK to prevent infinite loop (releasing the APK on the release tag will trigger a rerun of the action).

## Usage

To use the action simply add the following lines to your `.github/workflows/android.yml` and provide the required Secrets and Environment variables.

#### YML
```
name: Build & Publish Release APK

on:
 push:
  branches:
   - master
   
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: set up JDK 1.8
      uses: actions/setup-java@v1
      with:
        java-version: 1.8
    - name: Make Gradle executable
      run: chmod +x ./gradlew
    - name: Build with Gradle
      run: ./gradlew build
    - name: Build Debug APK
      run: ./gradlew assembleDebug
    - name: Releasing using Hub
      uses: yurakurets/action-release-debugapk@master
      env:
       REPO_BRANCH: master
       GITHUB_TOKEN: ${{ secrets.TOKEN }}
       APK_FOLDER: android/app/build/outputs/apk/release/app-release.apk
       APP_FOLDER: android/app
       RELEASE_TITLE: New Build
```

### Secrets

You'll need to provide this secret token to use the action (for publishing the APK). Enter these secrets in your Settings > Secrets

* **TOKEN**: Create a new [access token](https://github.com/settings/tokens) with `repo` access.

I am unsure as to why using the default `GITHUB_TOKEN` provided universally will fail to authorize the user. This is the only workaround that I'd found.

### Environment Variables

You'll need to provide these environment variables to specify exactly what information is needed to build the APK.

* **APK_FOLDER**: full path to the apk file. Most of the time for release, it's `android/app/build/outputs/apk/release/app-release.apk`, for debug, it's `android/app/build/outputs/apk/debug/app-debug.apk`
* **APP_FOLDER**: app folder for getting versionName
* **RELEASE_TITLE**: title for release

## Credits

Based off [elgohr/Github-Hub-Action](https://github.com/elgohr/Github-Hub-Action)
