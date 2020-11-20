// initialize ingredient counter
ingCounter = 0;
// function that allows user to enter a new ingredient entry
function createIngInput(event){
    event.preventDefault();
    var input = document.createElement("input");
    input.placeholder = 'Enter ingredient Name';
    input.type = 'text';
    input.id = "ingredient" + ingCounter;
    ingCounter++;
    var listFooter = document.getElementById("listFooter");
    insertBefore(input, listFooter);

  }

  function insertBefore(newNode, referenceNode) {
    referenceNode.parentNode.insertBefore(newNode, referenceNode);
}