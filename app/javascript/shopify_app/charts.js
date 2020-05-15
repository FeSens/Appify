$(document).ready(function() {
  $.getJSON('/subscriber_count', function( data ) {
    new Chart(document.getElementById("download-app"), {
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
