import { Controller } from "stimulus"

export default class extends Controller {
  static classes = ["open"]

  initialize() {
    console.log("Hello, Stimulus!", this.element)
    window.xx = this
  }

  open(activeBlock) {
    this.element["activeBlock"] = activeBlock
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
    var template = document.querySelector('#input-template');
    this.properties.forEach((input) => {
      var clone = template.content.cloneNode(true);
      var tinput = clone.querySelector("input");
      tinput.name = input.name
      tinput.value = input.value
      tinput.type = input.attributes.dtype.value
      //tinput.type = input.type

      tbody.appendChild(clone);
    })
  }

  onInputChange(event) {
    this.activeBlock.properties.forEach((input) => {
      if (input.name == event.target.name) {
        input.value = event.target.value
        this.fire_event(input, "input")
      }
    })
  }

  fire_event(element, type) {
    var event = document.createEvent('Event');
    event.initEvent(type, true, true); //can bubble, and is cancellable
    element.dispatchEvent(event);
  }

  get properties() {
    return this.activeBlock.properties
  }

  get activeBlock() {
    return this.element["activeBlock"]
  }

  get children() {
    return $(this.element).children()
  }
}