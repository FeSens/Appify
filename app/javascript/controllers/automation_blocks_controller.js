import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["property"]
  static classes = ["selected"]

  openSidePanel() {
    this.propertiesController.open(this)
    this.select_block()
    //Render the properties there
  }

  select_block() {
    this.unselect_all_blocks()
    this.parent.addClass(this.selectedClass)
  }

  unselect_all_blocks() {
    $(".blockelem").removeClass(this.selectedClass)
  }

  get properties() {
    return this.propertyTargets
  }

  get propertiesController() {
    return this.application.getControllerForElementAndIdentifier($("#propwrap")[0], "properties")
  }

  get identifier() {
    return "automationBlocks"
  }

  get parent() {
    return $(this.element).parent()
  }
}
