function addElement () { 
  // create a new div element 
  // and give it popup content 
  var newDiv = document.createElement("div"); 
  newDiv.innerHTML += `
  <div id="popup" style="position: absolute;width: 300px;z-index: 999;display: none;top:0;background-color: #fff;  border: 1px solid #ddd;  border-radius: 5px;  box-shadow: 0 2px 8px #aaa;  overflow: hidden;   padding: 10px;">
    <div class="popup_body" style="  height: 100px;">
      This is sample popuup
    </div>
    <button class="close_button"onClick="closePopup()">close</button>
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