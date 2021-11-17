#!/bin/bash -    

curl -k -X POST "http://localhost:5601/api/saved_objects/_export" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "objects": [
    {
      "type": "dashboard",
      "id": "0d9bfad0-c1f0-11eb-bd86-5343658b133b"
    }
  ],
  "includeReferencesDeep": true
}
' > dashboard_participation_production.ndjson