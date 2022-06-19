#!/bin/sh

component=$(tail -n1 $1 | sed 's/export default \(.*\);/\1/')

dir=components/Pages/$component
mkdir -p $dir
echo "export { $component } from './$component';" > $dir/index.ts

new_component=$dir/$component.tsx
head -n -2 $1 | sed 's#../components#../..#' > $new_component

rel_path=$(realpath --relative-to=$(dirname $1).. $dir)
echo "export { $component as default } from '$rel_path';" >$1
