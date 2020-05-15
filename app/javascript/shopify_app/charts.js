$(document).ready(function() {
  $.getJSON('/subscriber_count', function( data ) {
    new Chart(document.getElementById("bar-chart"), {
      type: 'bar',
      data: {
        labels: data.date_pwa,
        datasets: [
          {
            label: "Novos Usuários Diarios",
            backgroundColor: "#c45850",
            data: data.pwa
          }
        ]
      },
      options: {
        legend: { display: false },
        title: {
          display: true,
          text: 'Novos Usuários'
        }
      }
    });
  })
});
