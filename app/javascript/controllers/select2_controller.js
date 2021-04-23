import { Controller } from "stimulus"

export default class extends Controller {
  connect() { 
    $(this.element).children(".custom-select").on('select2:select', function () {
      console.log("list item selected");
      let event = new Event('change', { bubbles: true }) // fire a native event
      this.dispatchEvent(event);
    });
  }
}