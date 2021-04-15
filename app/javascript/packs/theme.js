// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

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
require("datatables")
require("daterangepicker")
require("moment")
require("flatpickr")
require("jquery-validation")

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import "../vendor/hs/hs.core"
import "../vendor/hs/hs.chartjs"
import "../vendor/hs/hs.datatables"
import "../vendor/hs/hs.daterangepicker"
import "../vendor/hs/hs.fullcalendar"
import "../vendor/hs/hs.flatpickr"
import "../vendor/hs/hs.validation"

import { flowy } from "../vendor/flowy/flowy"

import HSMegaMenu from "../vendor/hs/hs-mega-menu"
import HSUnfold from "../vendor/hs/hs-unfold"
import HSStickyBlock from "../vendor/hs/hs-sticky-block"
import HSScrollspy from "../vendor/hs/hs-scrollspy"

document.addEventListener("turbolinks:load", () => {
  console.log("we are here")
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
  $('.toast').toast({ autohide: false })
  $('#toast').toast('show')
  var datatable = $.HSCore.components.HSDatatables.init($('#datatable'));

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

  // initialization of fullcalendar
  $('.js-fullcalendar').each(function () {
    var fullcalendar = $.HSCore.components.HSFullcalendar.init($(this));
  });
  
  // INITIALIZATION OF FLATPICKR
  // =======================================================
  $('.js-flatpickr').each(function () {
    $.HSCore.components.HSFlatpickr.init($(this));
  });

  // INITIALIZATION OF FORM VALIDATION
  // =======================================================
  $('.js-validate').each(function() {
    $.HSCore.components.HSValidation.init($(this));
  });

  // INITIALIZATION OF STICKY BLOCKS
  // =======================================================
  $('.js-sticky-block').each(function () {
    var stickyBlock = new HSStickyBlock($(this)).init();
  });

  // INITIALIZATION OF FLOWY
  // =======================================================

  var rightcard = false;
  var tempblock;
  var tempblock2;
  document.getElementById("blocklist").innerHTML = '<div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="1"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/eye.svg"></div><div class="blocktext">                        <p class="blocktitle">New visitor</p><p class="blockdesc">Triggers when somebody visits a specified page</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="2"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/action.svg"></div><div class="blocktext">                        <p class="blocktitle">Action is performed</p><p class="blockdesc">Triggers when somebody performs a specified action</p></div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="3"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/time.svg"></div><div class="blocktext">                        <p class="blocktitle">Time has passed</p><p class="blockdesc">Triggers after a specified amount of time</p>          </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="4"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/error.svg"></div><div class="blocktext">                        <p class="blocktitle">Error prompt</p><p class="blockdesc">Triggers when a specified error happens</p>              </div></div></div>';
  flowy(document.getElementById("canvas"), drag, release, snapping);
  function addEventListenerMulti(type, listener, capture, selector) {
      var nodes = document.querySelectorAll(selector);
      for (var i = 0; i < nodes.length; i++) {
          nodes[i].addEventListener(type, listener, capture);
      }
  }
  function snapping(drag, first) {
      var grab = drag.querySelector(".grabme");
      grab.parentNode.removeChild(grab);
      var blockin = drag.querySelector(".blockin");
      blockin.parentNode.removeChild(blockin);
      if (drag.querySelector(".blockelemtype").value == "1") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/eyeblue.svg'><p class='blockyname'>New visitor</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>When a <span>new visitor</span> goes to <span>Site 1</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "2") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/actionblue.svg'><p class='blockyname'>Action is performed</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>When <span>Action 1</span> is performed</div>";
      } else if (drag.querySelector(".blockelemtype").value == "3") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/timeblue.svg'><p class='blockyname'>Time has passed</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>When <span>10 seconds</span> have passed</div>";
      } else if (drag.querySelector(".blockelemtype").value == "4") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/errorblue.svg'><p class='blockyname'>Error prompt</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>When <span>Error 1</span> is triggered</div>";
      } else if (drag.querySelector(".blockelemtype").value == "5") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/databaseorange.svg'><p class='blockyname'>New database entry</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Add <span>Data object</span> to <span>Database 1</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "6") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/databaseorange.svg'><p class='blockyname'>Update database</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Update <span>Database 1</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "7") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/actionorange.svg'><p class='blockyname'>Perform an action</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Perform <span>Action 1</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "8") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/twitterorange.svg'><p class='blockyname'>Make a tweet</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Tweet <span>Query 1</span> with the account <span>@alyssaxuu</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "9") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/logred.svg'><p class='blockyname'>Add new log entry</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Add new <span>success</span> log entry</div>";
      } else if (drag.querySelector(".blockelemtype").value == "10") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/logred.svg'><p class='blockyname'>Update logs</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Edit <span>Log Entry 1</span></div>";
      } else if (drag.querySelector(".blockelemtype").value == "11") {
          drag.innerHTML += "<div class='blockyleft'><img src='assets/errorred.svg'><p class='blockyname'>Prompt an error</p></div><div class='blockyright'><img src='assets/more.svg'></div><div class='blockydiv'></div><div class='blockyinfo'>Trigger <span>Error 1</span></div>";
      }
      return true;
  }
  function drag(block) {
      block.classList.add("blockdisabled");
      tempblock2 = block;
  }
  function release() {
      if (tempblock2) {
          tempblock2.classList.remove("blockdisabled");
      }
  }
  var disabledClick = function(){
      document.querySelector(".navactive").classList.add("navdisabled");
      document.querySelector(".navactive").classList.remove("navactive");
      this.classList.add("navactive");
      this.classList.remove("navdisabled");
      if (this.getAttribute("id") == "triggers") {
          document.getElementById("blocklist").innerHTML = '<div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="1"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/eye.svg"></div><div class="blocktext">                        <p class="blocktitle">New visitor</p><p class="blockdesc">Triggers when somebody visits a specified page</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="2"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/action.svg"></div><div class="blocktext">                        <p class="blocktitle">Action is performed</p><p class="blockdesc">Triggers when somebody performs a specified action</p></div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="3"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/time.svg"></div><div class="blocktext">                        <p class="blocktitle">Time has passed</p><p class="blockdesc">Triggers after a specified amount of time</p>          </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="4"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                    <div class="blockico"><span></span><img src="assets/error.svg"></div><div class="blocktext">                        <p class="blocktitle">Error prompt</p><p class="blockdesc">Triggers when a specified error happens</p>              </div></div></div>';
      } else if (this.getAttribute("id") == "actions") {
          document.getElementById("blocklist").innerHTML = '<div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="5"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/database.svg"></div><div class="blocktext">                        <p class="blocktitle">New database entry</p><p class="blockdesc">Adds a new entry to a specified database</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="6"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/database.svg"></div><div class="blocktext">                        <p class="blocktitle">Update database</p><p class="blockdesc">Edits and deletes database entries and properties</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="7"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/action.svg"></div><div class="blocktext">                        <p class="blocktitle">Perform an action</p><p class="blockdesc">Performs or edits a specified action</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="8"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/twitter.svg"></div><div class="blocktext">                        <p class="blocktitle">Make a tweet</p><p class="blockdesc">Makes a tweet with a specified query</p>        </div></div></div>';
      } else if (this.getAttribute("id") == "loggers") {
          document.getElementById("blocklist").innerHTML = '<div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="9"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/log.svg"></div><div class="blocktext">                        <p class="blocktitle">Add new log entry</p><p class="blockdesc">Adds a new log entry to this project</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="10"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/log.svg"></div><div class="blocktext">                        <p class="blocktitle">Update logs</p><p class="blockdesc">Edits and deletes log entries in this project</p>        </div></div></div><div class="blockelem create-flowy noselect"><input type="hidden" name="blockelemtype" class="blockelemtype" value="11"><div class="grabme"><img src="assets/grabme.svg"></div><div class="blockin">                  <div class="blockico"><span></span><img src="assets/error.svg"></div><div class="blocktext">                        <p class="blocktitle">Prompt an error</p><p class="blockdesc">Triggers a specified error</p>        </div></div></div>';
      }
  }
  addEventListenerMulti("click", disabledClick, false, ".side");
  document.getElementById("close").addEventListener("click", function(){
     if (rightcard) {
         rightcard = false;
         document.getElementById("properties").classList.remove("expanded");
         setTimeout(function(){
              document.getElementById("propwrap").classList.remove("itson"); 
         }, 300);
          tempblock.classList.remove("selectedblock");
     } 
  });
  
document.getElementById("removeblock").addEventListener("click", function(){
flowy.deleteBlocks();
});
var aclick = false;
var noinfo = false;
var beginTouch = function (event) {
  aclick = true;
  noinfo = false;
  if (event.target.closest(".create-flowy")) {
      noinfo = true;
  }
}
var checkTouch = function (event) {
  aclick = false;
}
var doneTouch = function (event) {
  if (event.type === "mouseup" && aclick && !noinfo) {
    if (!rightcard && event.target.closest(".block") && !event.target.closest(".block").classList.contains("dragging")) {
          tempblock = event.target.closest(".block");
          rightcard = true;
          document.getElementById("properties").classList.add("expanded");
          document.getElementById("propwrap").classList.add("itson");
          tempblock.classList.add("selectedblock");
     } 
  }
}
addEventListener("mousedown", beginTouch, false);
addEventListener("mousemove", checkTouch, false);
addEventListener("mouseup", doneTouch, false);
addEventListenerMulti("touchstart", beginTouch, false, ".block");


  // INITIALIZATION OF SCROLLSPY
  // =======================================================
  var scrollspy = new HSScrollspy($('body'), {
    // !SETTING "resolve" PARAMETER AND RETURNING "resolve('completed')" IS REQUIRED
    beforeScroll: function(resolve) {
      if (window.innerWidth < 992) {
        $('#navbarVerticalNavMenu').collapse('hide').on('hidden.bs.collapse', function () {
          return resolve('completed');
        });
      } else {
        return resolve('completed');
      }
    }
  }).init();
})

window.$ = $;