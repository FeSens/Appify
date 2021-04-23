import { Controller } from "stimulus"

export default class extends Controller {
  connect() { 
    // INITIALIZATION OF SELECT2
    // =======================================================
    console.log("Hello, Stimulus!")
    $('.js-select2-custom').each(function () {
      var select2 = $.HSCore.components.HSSelect2.init($(this));
    });

    $(this.element).children(".custom-select").on('select2:select', function () {
      console.log("list item selected");
      let event = new Event('input', { bubbles: true }) // fire a native event
      this.dispatchEvent(event);
    });
  }
}