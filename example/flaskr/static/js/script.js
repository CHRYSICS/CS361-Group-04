const myInput = document.getElementById("password");
const letter = document.getElementById("letter");
const capital = document.getElementById("capital");
const number = document.getElementById("number");
const length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput.onfocus = function() {
  document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput.onblur = function() {
  document.getElementById("message").style.display = "none";
}

const validateElement = (element, regex) => {
  if(myInput.value.match(regex)) {
    element.classList.remove("invalid");
    element.classList.add("valid");
  } else {
    element.classList.remove("valid");
    element.classList.add("invalid");
  }
}

// When the user starts to type something inside the password field
myInput.onkeyup = function() {
  // Validate lowercase letters
  const lowerCaseLetters = /[a-z]/g;
  validateElement(letter, lowerCaseLetters);

  // Validate capital letters
  const upperCaseLetters = /[A-Z]/g;
  validateElement(capital, upperCaseLetters);

  // Validate numbers
  const numbers = /[0-9]/g;
  validateElement(number, numbers);

  // Validate length
  if(myInput.value.length >= 8) {
    length.classList.remove("invalid");
    length.classList.add("valid");
  } else {
    length.classList.remove("valid");
    length.classList.add("invalid");
  }
}