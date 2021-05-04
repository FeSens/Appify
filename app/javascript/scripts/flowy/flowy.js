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
          //document.getElementById("properties").classList.add("expanded");
        }
      }
    }
    addEventListener("mousedown", beginTouch, false);
    addEventListener("mousemove", checkTouch, false);
    addEventListener("mouseup", doneTouch, false);
    addEventListenerMulti("touchstart", beginTouch, false, ".block");
  }
});

window.flowy = flowy;
