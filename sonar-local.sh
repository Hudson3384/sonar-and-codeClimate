export SONAR_SCANNER_HOME=/opt/sonar-scanner/bin
PATH=$PATH:$SONAR_SCANNER_HOME
STATUSCODE="$(curl -IL localhost:9000 | head -n 1 | cut -d$' ' -f2)"

GET_TOKEN () {
TOKEN="$(< /tmp/token.txt)"
if [ "$TOKEN" ]; then
  SEND_CODE $TOKEN
else 
  echo -n 'Please, access the 9000 port and insert your token here: '
  read -r  TOKEN
  echo $TOKEN > /tmp/token.txt
  SEND_CODE $TOKEN
fi 
}

SEND_CODE () {
sudo sonar-scanner -X \
  -Dsonar.projectKey=app-web \
  -Dsonar.sources=. \
  -Dsonar.javascript.lcov.reportPaths=./e2e-coverage/lcov.info \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token="$1"
}

if [ "$STATUSCODE" == '200' ]; then 
 echo 'SONAR CLOUD IS READY'
 GET_TOKEN
else 
    docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest
    GET_TOKEN
fi



