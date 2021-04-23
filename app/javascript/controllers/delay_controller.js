import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "delay", "delayLable" ];

  connect() {
    //console.log("Hello, Stimulus!", this.page)
    this.setLables()
  }

  setLables() {
    this.delayLableTarget.innerHTML = this.delay;
  }

  get delay() {
    return this.delayTarget.value
  }
}