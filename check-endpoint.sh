#!/bin/bash
# Pass the name of a service to check ie: sh check-endpoint.sh staging-voting-app-vote
# Will run forever...
external_ip=""
while [ -z $external_ip ]; do
  echo "Waiting for end point..."
  external_ip=$(kubectl get svc --namespace ingress-basic $1 --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$external_ip" ] && sleep 3
done
echo 'End point ready:' && echo $external_ip
#echo "::set-output name=externalip::$external_ip"