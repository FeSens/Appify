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
            label: "Inscritos",
            backgroundColor: "#E95362",
            data: data.push
          },
          {
            maxBarThickness: 50,
            label: "Novos Inscritos",
            backgroundColor: "#FF7595",
            data: data.push_new_subscribers
          },
          {
            maxBarThickness: 50,
            label: "Valor Gerado",
            backgroundColor: "#2D366E",
            data: data.value 
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
