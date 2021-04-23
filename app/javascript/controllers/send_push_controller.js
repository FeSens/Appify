import { Controller } from "stimulus"

import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = ["cardInputs", "templateNameLable"]
  static values = {
    template: String
  }

  initialize() {
    window.block = this.block
    this.templateValue = this.templateValue || this.properties_template.content.querySelector('option').value
    this.render_inputs()
  }

  templateValueChanged() {
    this.templateNameLableTarget.innerHTML = this.templateValue && this.properties_template.content.querySelector(`option[value='${this.templateValue}']`).text;
    this.render_inputs()
  }

  render_inputs() {
    this.cardInputsTarget.innerHTML = `
      <input type="hidden" name="template" class="hidden-input" value="${this.templateValue}">
    `
  }

  render_properties() {
    var template = this.properties_template.content.cloneNode(true)
    return template 
  }

}