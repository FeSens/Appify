// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("shopify_app")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap";
import "../stylesheets/theme"
import "../vendor/icon-set/liga"

require("chart.js")

import "../vendor/hs/hs.core"
import "../vendor/hs/hs.chartjs"
import HSMegaMenu from "../vendor/hs/hs-mega-menu"
import HSUnfold from "../vendor/hs/hs-unfold"

document.addEventListener("turbolinks:load", () => {
  console.log("we are here")
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
  $('.toast').toast({ autohide: false })
  $('#toast').toast('show')
  var megaMenu = new HSMegaMenu($('.js-mega-menu')).init();

  $('.js-hs-unfold-invoker').each(function () {
    var unfold = new HSUnfold($(this)).init();
  });

  $.HSCore.components.HSChartJS.init($('.js-chartjs-doughnut-half'), {
    options: {
      tooltips: {
        postfix: ""
      },
      cutoutPercentage: 85,
      rotation: 1 * Math.PI,
      circumference: 1 * Math.PI
    }
  });

  $('.js-chart').each(function () {
    $.HSCore.components.HSChartJS.init($(this));
  });
})


window.$ = $;