import { Controller } from "stimulus"

export default class extends Controller {
  static classes = ["selected"]

  openSidePanel() {
    this.propertiesController.open(this)
    this.select_block()
  }

  select_block() {
    this.unselect_all_blocks()
    this.parent.addClass(this.selectedClass)
  }

  unselect_all_blocks() {
    $(".blockelem").removeClass(this.selectedClass)
  }

  get propertiesController() {
    return this.application.getControllerForElementAndIdentifier($("#propwrap")[0], "properties")
  }

  get parent() {
    return $(this.element).parent()
  }

  get properties_template() {
    return document.querySelector(`#${this.identifier}-properties-template`);
  }
}
