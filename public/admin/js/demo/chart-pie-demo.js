// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

// Pie Chart Example
var ctx = document.getElementById("myPieChart");

var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["Admis", "Fit refusé", "Potential refusé", "Abandon ou en cours"],
    datasets: [{
      data: $("#myPieChart").data().array,
      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', "#ccc"],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', "#cc6"],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,

    tooltips: {
      callbacks: {
        label: function(tooltipItem, chart) {
          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
          return datasetLabel +' '+chart.labels[tooltipItem.index] + ': '+chart.datasets[0].data[tooltipItem.index]+'%';

// return ' : ';

        }
      }
    }
  },
});
