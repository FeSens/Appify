import { flowy } from "../../vendor/flowy/flowy"
import new_visitor from "../flowy/cards/new_visitor.html"
import page_view from "../flowy/cards/page_view.html"
import send_push from "../flowy/cards/send_push.html"
import delay from "../flowy/cards/delay.html"
import end_block from "../flowy/cards/end_block.html"

document.addEventListener("turbolinks:load", () => {
  // INITIALIZATION OF FLOWY
  // =======================================================
  if ($("#canvas").length > 0) {
    var rightcard = false;
    var tempblock;
    var tempblock2;
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
        drag.innerHTML += new_visitor;
      } else if (drag.querySelector(".blockelemtype").value == "2") {
        drag.innerHTML += page_view;
      } else if (drag.querySelector(".blockelemtype").value == "3") {
        drag.innerHTML += send_push;
      } else if (drag.querySelector(".blockelemtype").value == "4") {
        drag.innerHTML += delay;
      } else if (drag.querySelector(".blockelemtype").value == "5") {
        drag.innerHTML += end_block;
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

    document.getElementById("close").addEventListener("click", function () {
      if (rightcard) {
        rightcard = false;
        document.getElementById("properties").classList.remove("expanded");
        setTimeout(function () {
          document.getElementById("propwrap").classList.remove("itson");
        }, 300);
        tempblock.classList.remove("selectedblock");
      }
    });

    document.getElementById("removeblock").addEventListener("click", function () {
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
  }
});


// Get tempblock inputs
function get_inputs(block) {
  data = [];

  block.querySelectorAll("input").forEach(function(input) {
    var json_name = input.getAttribute("name");
    var json_value = input.value;
    data.push({
        name: json_name,
        value: json_value
    });
  });
}

// List them in the properties tab
function list_inputs(data) {
  data.forEach(function(input) {
    html += html_tamplate_erb(input)
  })
}

// Update inputs on card 
function save_properties(block){
  b = get_inputs($("#properties"))
  b.forEach(function(input) {
    input.attr("value", input.value)
  })
}

// Update preview of input on card 