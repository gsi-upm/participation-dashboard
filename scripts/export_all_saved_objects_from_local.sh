#!/bin/bash -    

curl -k -X POST "http://localhost:5601/api/saved_objects/_export" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
 "type": ["dashboard", "index-pattern", "visualization", "map", "lens", "tag", "search", "config"],
 "includeReferencesDeep": "true"
}
' > all_saved_objects.ndjson