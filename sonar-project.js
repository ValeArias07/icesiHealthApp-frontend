const sonarqubeScanner = require('sonarqube-scanner');
sonarqubeScanner(
  {
    serverUrl: 'http://20.228.242.97:9000/',
    token: process.env.SONAR_TOKEN || '',
    options: {}
  },
  () => process.exit()
);
