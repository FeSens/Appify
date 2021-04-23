import { Controller } from "stimulus"
import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = [ "pageLable", "timerLable", "page", "timer", "property" ];

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