var Chart = require('chart.js');

$(document).on('turbolinks:load', function() {
  $.getJSON('/admin/subscribers', function( data ) {

    new Chart(document.getElementById("push-subscribers"), {
      type: 'bar',
      data: {
        labels: data.date_push,
        datasets: [
          {
            label: "Push",
            backgroundColor: "#c45850",
            data: data.push
          }
        ]
      },
      options: {
        legend: { display: false },
        title: {
          display: true,
          text: 'Assinantes Push'
        }
      }
    });
  })
});
