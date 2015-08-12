# TM_Gulp
Repo to hold gulp scripts for TM sites (for example to compile coffeescript and jade into js)

This build step should be designed to run inside an docker image (based on TM_Docker)


For devs, run the command below to auto execute the TM_QA unit tests (with auto compilation of Angular resources)

```
cd build/TM_Gulp
npm run gulp-watch
```

which is the equivalent of doing
```
cd build/TM_Gulp
NODE_PATH=../../qa/TM_QA/node_modules gulp coffee-watch angular-watch  mocha-watch --silent
```

