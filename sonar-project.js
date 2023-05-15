const sonarqubeScanner = require('sonarqube-scanner');
sonarqubeScanner(
  {
    serverUrl: process.env.SONAR_URL,
    token: process.env.SONAR_TOKEN || '',
    options: {}
  },
  () => process.exit()
);
