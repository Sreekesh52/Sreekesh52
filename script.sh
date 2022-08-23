#!/bin/bash

#Validating if Git is running in the machine.

git --version >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Git is already installed"
else
    echo "Install Git as per the Linux flavour to continue with the testing"
fi

#Validating if docker is running in the machine.

docker version >/dev/null 2>&1

if [ $? -eq 0 ]
then
    docker --version | grep "Docker version"
    if [ $? -eq 0 ]
    then
        echo "Docker is already installed"
    else
        echo "Install docker as per the Linux flavour to continue with the testing"
    fi
else
    echo "Install docker as per the Linux flavour to continue with the testing" >&2
fi

#Validating if minikube is running in the machine.

minikube --version >/dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "minikube is already installed"
else
    echo "Install minikube as per the Linux flavour to continue with the testing"
fi

#Cloning Git repo

echo "Please provide username for git repository coding-challenge-sreekesh-rishikesha"
read username
echo "Please provide password for git repository coding-challenge-sreekesh-rishikesha"
read password
git clone https://$username:$password@github.com/signavio-hiring/coding-challenge-sreekesh-rishikesha.git
git pull


#Starting minikube
minikube start

#Enbaling ingress addons to minikube
minikube addons enable ingress

#Creating Deployment, Service and Ingress for the first application
kubectl apply -f .coding-challenge-sreekesh-rishikesha/app/deploymentapp1.yml
sleep 300s

i=''
while [ "$i" != "Running" ]
do
  kubectl get pods >>signavioapplog.txt
  i=`cat signavioapplog.txt |grep signavio |grep -o Running`
  if [ "$i" == "Running" ]
  then
    break
  else
    echo "Please wait until first application is up and running"
    sleep 60s
  fi
done

kubectl apply -f .coding-challenge-sreekesh-rishikesha/app/deploymentapp2.yml
sleep 300s

j=''
while [ "$j" != "Running" ]
do
  kubectl get pods >>signabioapplog.txt
  j=`cat signabioapplog.txt |grep signabio |grep -o Running`
  if [ "$j" == "Running" ]
  then
    break
  else
    echo "Please wait until second application is up and running"
    sleep 60s
  fi
done

#Adding app name in /etc/hosts file for ingress URL DNS resolution
minikube ip >>minikubeip.txt
k=`cat minikubeip.txt`
echo "$k signavioapp.com" | sudo tee -a /etc/hosts > /dev/null
echo "$k signabioapp.com" | sudo tee -a /etc/hosts > /dev/null

rm minikubeip.txt signabioapplog.txt signavioapplog.txt

echo "Please access your first application through http://signavioapp.com"
echo "Please access your first application through http://signabioapp.com"
