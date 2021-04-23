import { Controller } from "stimulus"

import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = [ "template", "templateLable", "property" ];

  connect() {
    //console.log("Hello, Stimulus!", this.page)
    this.setLables()
  }

  setLables() {
    this.templateLableTarget.innerHTML = this.template;
  }

  render() {
    var template = document.querySelector('#send-push-select2-template');
    return template.content.cloneNode(true);
  }

  set template(value) {
    this.templateTarget.value = value;
  }

  get template() {
    return this.templateTarget.value
  }
}