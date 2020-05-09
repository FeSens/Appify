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
    padding: 10px;`
}

function addElement () { 
  // create a new div element 
  // and give it popup content 
  var newDiv = document.createElement("div"); 
  newDiv.innerHTML +=`<div id="popup" style="${style.popup}">
                        <div class="popup_body" style="height: 90%;">
                          Would you like to use your app?
                        </div>
                        <button class="accept" onClick="showPrompt()"> Yes! </button>
                        <button class="close_button"onClick="closePopup()">close</button>
                      </div>`;   

  // add the newly created element and its content into the DOM 
  var currentDiv = document.getElementById("main_container"); 
  document.body.insertBefore(newDiv, currentDiv); 

  // open popup onload
  openPopup();
}

setTimeout(openPopup, 20);

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