#!/bin/bash
cd  /root/ansible

docker build -t $JOB_NAME:$BUILD_ID .

docker tag $JOB_NAME:$BUILD_ID manandock/$JOB_NAME:$BUILD_ID

docker tag $JOB_NAME:$BUILD_ID manandock/$JOB_NAME:latest

docker push manandock/$JOB_NAME:$BUILD_ID

docker push manandock/$JOB_NAME:latest

docker rmi -f $JOB_NAME:$BUILD_ID manandock/$JOB_NAME:$BUILD_ID manandock/$JOB_NAME:latest
