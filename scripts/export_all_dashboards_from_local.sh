#!/bin/bash -    

curl -k -X POST "http://localhost:5601/api/saved_objects/_export" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
 "type": "dashboard",
 "includeReferencesDeep": "true"
}
' > all_dashboards.ndjson