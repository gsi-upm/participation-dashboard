# Vega Training

- [Custom Kibana Visualizations with Vega](https://www.elastic.co/webinars/vega-plugin-custom-visualizations-with-kibana)

- [Bubble Chart in Kibana with Vega](https://blog.bigdataboutique.com/2021/04/bubble-chart-in-kibana-with-vega-5il1u2)

- [Technical view on Vega for Kibana by Mathew Thekkekara](https://www.youtube.com/watch?v=RDe7KOb_SLQ)

## Radar chart 

- [Radar Chart Example in Kibana with Vega](https://synapticiel.hashnode.dev/radar-chart-example-in-kibana-with-vega)

- [Radar Chart Example](https://vega.github.io/vega/examples/radar-chart/)


# Dev Tools 

Source example:
```
GET participation/_search
{
  "size": 200, 
  "_source": ["schema:datePublished","ideology.narratives","liwc:result.affiliation", "liwc:result.achiev", "liwc:result.power", "liwc:result.reward", "liwc:result.risk"]
}
```
Aggregation example:
```
GET participation/_search
{
  "size": 0,
  "aggs": {
    "table": {
      "composite": {
        "size": 10000, 
        "sources": [
          {
            "time": {
              "date_histogram": {
                "field": "schema:datePublished",
                "calendar_interval": "1w"
              }
            }
          },
          {
            "ideology": {
              "terms": {
                 "field": "ideology.narratives.keyword" 
              }
            }
          },
          {
            "affiliation":{
              "terms": {
                "field": "liwc:result.affiliation"
              }
            }
          },
          {
            "power":{
              "terms": {
                "field": "liwc:result.power"
              }
            }
          },
          {
            "reward":{
              "terms": {
                "field": "liwc:result.reward"
              }
            }
          }
        ]
      }
    }
  }
}
```

# Vega Debug

`Inspect Element-> Console`
```
VEGA_DEBUG.view.data('source_0')
```

## Data 

```
// Apply dashboard context filters when set
%context%: true
// Filter the time picker (upper right corner) with this field
%timefield%: ["schema:datePublished"]
```