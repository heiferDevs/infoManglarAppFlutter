# info_manglar

InfoManglarApp

## build APK
$ flutter build apk

find on:
build/app/outputs/apk/release/app-release.apk

## to deploy ManglarApp
$ git checkout manglarApp && git rebase master
$ rm -rf assets/config assets/images && flutter pub get && flutter pub pub run flutter_launcher_icons:main && flutter build apk

## to deploy InfoManglar
1.- update CONSTANTS
2.- REMOVE html import
$ flutter build apk
$ scp build/app/outputs/apk/release/app-release.apk ubuntu@100.25.105.241:Downloads/.


## download apk on
http://santiagocuenca.com/downloads/app-release.apk

## to change infoManglar ManglarApp
change constants.dart and main.dart

## Back after deploy
$ git checkout . && git checkout - && flutter pub get



## to deploy InfoManglar WEB
1.- update CONSTANTS
$ flutter build web
$ cd build && zip -r release-manglar.zip web && scp release-manglar.zip ubuntu@100.25.105.241:/home/ubuntu/proyectos && rm release-manglar.zip && cd ..

// ssh ubuntu@100.25.105.241
// server projects folder:
rm -rf info-manglar && unzip release-manglar.zip && mv ./web ./info-manglar && chmod -R 775 info-manglar && rm release-manglar.zip
