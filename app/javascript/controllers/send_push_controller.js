import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "template", "templateLable" ];

  connect() {
    //console.log("Hello, Stimulus!", this.page)
    this.setLables()
  }

  setLables() {
    this.templateLableTarget.innerHTML = this.template;
  }

  get template() {
    return this.templateTarget.value
  }
}