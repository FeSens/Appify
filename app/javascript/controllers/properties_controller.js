import { Controller } from "stimulus"

export default class extends Controller {
  static classes = ["open"]

  initialize() {
    console.log("Hello, Stimulus!", this.element)
    window.xx = this
  }

  open(activeBlock) {
    this.element["activeBlock"] = activeBlock
    window.block  = activeBlock
    this.element.classList.add("itson");
    this.children.addClass(this.openClass)
    this.list_properties()
  }

  close() {
    this.activeBlock.unselect_all_blocks()
    this.element.classList.remove("itson");
    this.children.removeClass(this.openClass)
  }

  list_properties() {
    var tbody = document.querySelector("#proplist");
    tbody.innerHTML = ""
    tbody.appendChild(this.activeBlock.render_properties())
  }

  onChange(event) {
    console.log("mudou mudou")
    window.event = event
    var target = event.target.attributes["target-value"].value
    this.activeBlock[`${target}Value`] = event.target.value
  }

  fire_event(element, type) {
    var event = document.createEvent('Event');
    event.initEvent(type, true, true); //can bubble, and is cancellable
    element.dispatchEvent(event);
  }

  get activeBlock() {
    return this.element["activeBlock"]
  }

  get children() {
    return $(this.element).children()
  }
}