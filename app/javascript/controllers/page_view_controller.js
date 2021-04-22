import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "pageLable", "timerLable", "page", "timer" ];

  connect() {
    //console.log("Hello, Stimulus!", this.page)
    this.setLables()
  }

  setLables() {
    this.pageLableTarget.innerHTML = this.page;
    this.timerLableTarget.innerHTML = this.timer;
  }

  get page() {
    return this.pageTarget.value
  }

  get timer() {
    return this.timerTarget.value
  }
}