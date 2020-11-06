var canvas = document.querySelector("canvas");
var clearButton = document.querySelector("[data-action=clear]");

var signaturePad = new SignaturePad(canvas);

// Draws signature image from data URL.
// NOTE: This method does not populate internal data structure that represents drawn signature. Thus, after using #fromDataURL, #toData won't work properly.
signaturePad.fromDataURL("data:image/png;base64,iVBORw0K...");
// Returns signature image as an array of point groups
const data = signaturePad.toData();
// Draws signature image from an array of point groups
signaturePad.fromData(data);

// Clears the canvas
clearButton.addEventListener("click", function (event) {
  signaturePad.clear();
});

// Sends the Signature Image to Server
document.getElementById('confirm-signature').addEventListener('click', function(){
  // The signature image is saved in png format.
  var dataURL = signaturePad.toDataURL();
  var dataImg = document.createElement('img');
  dataImg.src = dataURL;
  var drawingField = document.createElement('div');
  drawingField.innerHTML = "<input type='hidden' name='signature[signature_image]' id='signature_image' value='" + dataImg.src + "'>";
  document.getElementById('signature-image').value = dataURL;
  document.getElementById('submit-signature').click();
  document.getElementById('close-signature').click();
});

// Sends Justification Denial to Server
document.getElementById('confirm-denial').addEventListener('click', function(){
  var justificationContent = document.getElementById('justification-denial-textarea').value;
  if(justificationContent.length > 15){
    document.getElementById('justification').value = justificationContent;
    document.getElementById('submit-signature').click();
  }else{
    alert('You must fill in the justification with more than 15 characters!');
  }
});

// Close and Clear content - Justification Denial
document.getElementById('close-justification-denial').addEventListener('click', ()=>{
  var justificationTextArea = document.getElementById('justification-denial-textarea');
  if(justificationTextArea.value.length > 0){
    if(confirm('If you close, you will lose your justification. Are you sure about that?')) document.getElementById('justification-denial-textarea').value = '';
  }
});

// Close and Clear content - Signature Image
document.getElementById('close-signature').addEventListener('click', ()=>{
  signaturePad.clear();
});

