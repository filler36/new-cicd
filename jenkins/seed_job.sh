#/bin/bash
CRUMB=$(curl -s 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' -u admin:admin)
curl -s -XPOST 'http://localhost:8080/createItem?name=seed' -u admin:admin --data-binary @seed_job.xml -H "$CRUMB" -H "Content-Type:text/xml"

