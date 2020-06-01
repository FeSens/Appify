var Chart = require('chart.js');

$(document).on('turbolinks:load', function() {
  $.getJSON('/admin/subscribers', function( data ) {

    new Chart(document.getElementById("push-subscribers"), {
      type: 'bar',
      data: {
        labels: data.date_push,
        datasets: [
          {
            maxBarThickness: 50,
            label: "Subscribers",
            backgroundColor: "#E95362",
            data: data.push
          },
          {
            maxBarThickness: 50,
            label: "New Subscribers",
            backgroundColor: "#FF5B6B",
            data: data.push_new_subscribers
          }
        ]
      },
      options: {
        legend: { display: false },
        title: {
          display: false,
          text: 'Assinantes Push'
        },
        scales: {
          yAxes: [{
            stacked: true,
          }],
          xAxes: [{
            stacked: true,
          }]
        }
      }
    });
  })
});
