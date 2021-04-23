import { Controller } from "stimulus"
import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = ["cardInputs", "timerLable", "urlLable"]
  static values = {
    url: String,
    timer: Number,
  }

  initialize() {
    this.urlValue = this.urlValue || "/products";
    this.timerValue = this.timerValue || 60;
    this.render_inputs()
  }

  urlValueChanged() {
    this.urlLableTarget.innerHTML = this.urlValue;
    this.render_inputs()
  }

  timerValueChanged() {
    this.timerLableTarget.innerHTML = this.timerValue;
    this.render_inputs()
  }

  render_inputs() {
    this.cardInputsTarget.innerHTML = `
      <input type="hidden" name="url" class="hidden-input" value="${this.urlValue}">
      <input type="hidden" name="timer" class="hidden-input" value="${this.timerValue}">
    `
  }

  render_properties() {
    var template = this.properties_template.content.cloneNode(true)
    template.querySelector("input[target-value='timer']").value = this.timerValue;
    template.querySelector("input[target-value='url']").value = this.urlValue;

    return template 
  }

}