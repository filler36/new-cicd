#/bin/bash
CRUMB=$(curl -s 'http://localhost/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' -u admin:admin)
curl -s -XPOST 'http://localhost/createItem?name=seeddd' -u admin:admin --data-binary @seed_job.xml -H "$CRUMB" -H "Content-Type:text/xml"

