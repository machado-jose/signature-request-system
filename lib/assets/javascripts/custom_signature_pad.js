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

document.getElementById('confirm-signature').addEventListener('click', function(){
  var dataURL = signaturePad.toDataURL();
  var dataImg = document.createElement('img');
  dataImg.src = dataURL;
  var drawingField = document.createElement('div');
  drawingField.innerHTML = "<input type='hidden' name='signature[signature_image]' id='signature_image' value='" + dataImg.src + "'>";
  document.getElementById('signature-image').value = dataURL;
  document.getElementById('submit-signature').click();
});