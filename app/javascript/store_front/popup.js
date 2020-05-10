var style = {
  popup:`
    position: absolute;
    margin: auto;
    width: 50%;
    height: 30%;
    top: 0; left: 0; bottom: 0; right: 0;
    z-index: 999;
    display: none;
    top:0;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;  
    box-shadow: 0 2px 8px #aaa;  
    overflow: hidden;   
    padding: 10px;
    font-size: 1.3em;`,
  
  button:`
    color: 24a0ed;
    background-color: white;
    text-align: center;
    border-color: white;
    float: right;
    padding: 10px 20px;`,

  alingBottom:`
    position: absolute;
    right: 0;
    bottom: 0;
  `
}

function addElement () { 
  // create a new div element 
  // and give it popup content 
  var newDiv = document.createElement("div"); 
  newDiv.innerHTML +=`<div id="popup" style="${style.popup}">
                        <div class="popup_body">
                          Would you like to use our app, and recive exclusive promotions?
                        </div>
                        <div style="${style.alingBottom}">
                          <button class="accept" onClick="showPrompt()"  style="${style.button}">Yes</button>
                          <button class="close_button" onClick="closePopup()" style="${style.button}">No</button>
                        </div>
                      </div>`;   

  // add the newly created element and its content into the DOM 
  var currentDiv = document.getElementById("main_container"); 
  document.body.insertBefore(newDiv, currentDiv); 

  // open popup onload
  openPopup();
}

function openPopup() {
  var el = document.getElementById('popup');
  el.style.display = 'block';
  
  // Updates: set window background color black
  document.body.style.background = '#353333';
}

function closePopup() {
  var el = document.getElementById('popup');
  el.style.display = 'none';
  document.body.style.background = 'white';
}

function showPrompt() {
  closePopup();
  window.installPromptEvent.prompt();
  window.installPromptEvent.userChoice.then((choice) => {
    if (choice.outcome === 'accepted') {
      console.log('User accepted the A2HS prompt');
    } else {
      console.log('User dismissed the A2HS prompt');
    }
    // Clear the saved prompt since it can't be used again
    installPromptEvent = null;
  });
}

window.showPrompt = showPrompt;
window.closePopup = closePopup;

setTimeout(addElement, 20000);