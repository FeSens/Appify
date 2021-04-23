import { Controller } from "stimulus"
import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = ["cardInputs", "delayLable"]
  static values = {
    delay: Number,
  }
  
  initialize() {
    this.delayValue = this.delayValue || 12;
    this.render_inputs()
  }

  delayValueChanged() {
    this.delayLableTarget.innerHTML = this.delayValue;
    this.render_inputs()
  }

  render_inputs() {
    this.cardInputsTarget.innerHTML = `
      <input type="hidden" name="delay" class="hidden-input" value="${this.delayValue}">
    `
  }

  render_properties() {
    var template = this.properties_template.content.cloneNode(true)
    template.querySelector("input[target-value='delay']").value = this.timerValue;

    return template 
  }
}