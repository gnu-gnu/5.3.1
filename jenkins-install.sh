#!/usr/bin/env bash
jkopt1="--sessionTimeout=1440"
jkopt2="--sessionEviction=86400"
jvopt1="-Duser.timezone=Asia/Seoul"
jvopt2="-Dcasc.jenkins.config=https://raw.githubusercontent.com/gnu-gnu/5.3.1/main/jenkins-config.yaml"
jvopt3="-Dhudson.model.DownloadService.noSignatureCheck=true"

helm install jenkins jenkins/jenkins \
--set persistence.existingClaim=pvc-jenkins \
--set controller.adminPassword=admin \
--set controller.nodeSelector."kubernetes\.io/hostname"=cp-k8s \
--set controller.tolerations[0].key=node-role.kubernetes.io/control-plane \
--set controller.tolerations[0].effect=NoSchedule \
--set controller.tolerations[0].operator=Exists \
--set controller.runAsUser=1000 \
--set controller.runAsGroup=1000 \
--set controller.image=docker.io/jenkins/jenkins
--set controller.tag=2.440.3-jdk17 \
--set controller.serviceType=LoadBalancer \
--set controller.servicePort=80 \
--set controller.jenkinsOpts="$jkopt1 $jkopt2" \
--set controller.javaOpts="$jvopt1 $jvopt2 $jvopt3"
