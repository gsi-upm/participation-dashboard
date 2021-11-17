# Kibana dashboard 

## Location mapping as a geopoint field

A prerequisite to upload data in elasticsearch is to set the location property of type geo point. This will be done from Dev Tools with the following request:

```
PUT participation
{
  "mappings": {
    "properties": {
      "location": {
        "type": "geo_point"
      }
    }
  }
}
```

## Import

- Using Kibana UI: 
  1. `Management->Stack Manegement->Saved Object->Import`.
  2. Choose `dashboard_participation+index-pattern_participation.ndjson`.

- Using curl (something similar to next command, it's not working due to a error):
```zsh
curl -X POST "http://localhost:5601/api/saved_objects/_import" -H "kbn-xsrf: true" --form file=@dashboard_participation.ndjson -H 'kbn-xsrf: true'
```

## Export 

- Using Kibana UI: 
  1. `Management->Stack Manegement->Saved Object`
  2. Select index pattern `participation` and `Participation` and `export`.

### All saved objects

- Using curl:
```zsh
curl -k -X POST "http://localhost:5601/api/saved_objects/_export" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
 "type": ["dashboard", "index-pattern", "visualization", "map", "lens", "tag", "search", "config"],
 "includeReferencesDeep": "true"
}
' > all_saved_objects.ndjson
```

### All dashboard

- Using curl:
```zsh
curl -k -X POST "http://localhost:5601/api/saved_objects/_export" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
 "type": "dashboard",
 "includeReferencesDeep": "true"
}
' > all_dashboards.ndjson
```

### Unique dashboard

- Find a ID of a saved object called `participation` (result in the first line):
```
curl -X GET "localhost:5601/api/saved_objects/_find?type=dashboard&search_fields=title&search=participation" -H 'kbn-xsrf: true' | grep \"id\"
```

- Export with ID:

```zsh
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
' > dashboard_participation_test.ndjson
```

## Plugins

- [x-pack/plugins](https://github.com/elastic/kibana/tree/7.12/x-pack/plugins) for plugins related to subscription features
- [src/plugins](https://github.com/elastic/kibana/tree/7.12/src/plugins) for plugins related to free features
- [examples](https://github.com/elastic/kibana/tree/7.12/examples) for developer example plugins (these will not be included in the distributables)

- [List of plugins under development](https://www.elastic.co/guide/en/kibana/master/plugin-list.html#plugin-list)

- [List of plugins without compatibility with Kibana 7.12 version](https://www.elastic.co/guide/en/kibana/current/kibana-plugins.html)

```zsh
docker-compose exec kibana bin/kibana-plugin install <package name or URL>
```

- [Include additional Kibana plugins](https://www.elastic.co/guide/en/cloud-enterprise/current/ece-include-additional-kibana-plugin.html)

- [Install Kibana plugins](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-kibana-plugins.html)

## Dev tools

Get data with French language:
```
GET /participation/_search
{
    "size": 3000, 
    "query" : {
        "match" : {
            "schema:inLanguage" : "fr"
        }
    }
}

```

Delete data with French language:
```
POST  /participation/_delete_by_query
{
    "query" : {
        "match" : {
            "schema:inLanguage" : "fr"
        }
    }
}
```

Obtain data without the ideology field:
```
GET participation/_search
{
  "query": {
    "bool": {
      "must_not": {
        "exists": {
          "field": "ideology"
        }
      }
    }
  }
}
```

Delete data without ideology field:
```
POST participation/_delete_by_query
{
  "query": {
    "bool": {
      "must_not": {
        "exists": {
          "field": "ideology"
        }
      }
    }
  }
}
```

## Other examples

- [Twint Kibana](https://github.com/Nedja995/twint_kibana)

## Charts

### Tag Cloud

[Can't specify the color of the tag cloud tag](https://github.com/elastic/kibana/issues/12418#ref-issue-529761272)

## Known errors

`Too Many Requests` or `[lens_merge_tables] > [esaggs] > EsError`.
```
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }' 
```

