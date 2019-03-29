// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import Plotly from "plotly.js-dist"
export var App = {
  makePlot: (id, histogramData, keysInOrder, columnHeaders) => {
    var hisogramTransposed = App.transposeHistogram(histogramData)
    var chart_data = []
    for (var i = 0; i < columnHeaders.length; i++) {
      chart_data.push({
        x: App.generateArray(keysInOrder),
        y: hisogramTransposed[i],
        name: columnHeaders[i],
        type: 'bar'
      })
    }

    var layout = {barmode: 'group'};

    Plotly.newPlot(id, chart_data, layout);
  },
  htmlDecodeAsJSON: (input) => {
    var e = document.createElement('textarea');
    e.innerHTML = input;
    // handle case of empty input
    return JSON.parse(e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue);
  },
  transposeHistogram: (obj) => {
    var newObj = {0: [], 1: [], 2: [], 3: []}
    Object.keys(obj).forEach((lg) => {
      Object.keys(newObj).forEach((index) => {
        newObj[index].push(obj[lg][index])
      })
    })
    return newObj
  },
  generateArray: (obj) => {
    var arr = []
    for (var i = 0; i <= Object.keys(obj).length; i++) {
      arr.push(obj[i])
    }
    return arr
  }
}
