```sql
select count() as allCnt,
  ((countIf(simple_tm_cumulative_layout_shift, simple_tm_cumulative_layout_shift > 0.25) / allCnt) * 100) as poor,
  ((countIf(simple_tm_cumulative_layout_shift, simple_tm_cumulative_layout_shift > 0.1 AND simple_tm_cumulative_layout_shift <= 0.25)  / allCnt) * 100) as needsImprovement,
  ((countIf(simple_tm_cumulative_layout_shift, simple_tm_cumulative_layout_shift <= 0.1)  / allCnt) * 100) as good

from rum_virtualglobetrotting_com_data_flat
WHERE
    simple_tm_cumulative_layout_shift IS NOT NULL
    AND simple_tm_largest_contentful_paint IS NOT NULL
    AND simple_tm_first_input_delay IS NOT NULL
    AND derived_bm_browser_name = 'Chrome'
```

```js
// console.log(data);

var metricName = "cls";

// Data from Grafana Table format

var poor = 0.00;
var needsImprovement = 0.00;
var good = 0.00;

for (var k in data.series[0].fields)
{
    var metric = data.series[0].fields[k];



    if (metric.name === "poor")
    {
        poor = parseFloat(metric.values.buffer[0]).toFixed(2);
    }

    if (metric.name === "needsImprovement")
    {
        needsImprovement = parseFloat(metric.values.buffer[0]).toFixed(2);
    }

    if (metric.name === "good")
    {
        good = parseFloat(metric.values.buffer[0]).toFixed(2);
    }
}

var traces = [
  {
    x: [good],
    y: [metricName],
    orientation: 'h',
    name: "good (" + good + "%)",
    marker: {
      color: '#0cce6b',
      width: 1
    },
    type: 'bar'
  },
  {
    x: [needsImprovement],
    y: [metricName],
    orientation: "h",
    name: "needs improvement (" + needsImprovement + "%)",
    marker: {
      color: '#ffa400',
      width: 1
    },
    type: 'bar'
  },
    {
    x: [poor],
    y: [metricName],
    orientation: "h",
    name: "poor (" + poor + "%)",
    marker: {
      color: '#ff4e42',
      width: 1
    },
    type: 'bar'
  }
]
  
return {data: traces, layout:{title:''}};
```
