#!/usr/bin/env zsh

# disable zsh confirm future
setopt RM_STAR_SILENT

flutter build web

target_dir="../firebase/public"
rm -rf ${target_dir}/*
cp -r build/web/* ${target_dir}

cd ../firebase
firebase deploy --only hosting