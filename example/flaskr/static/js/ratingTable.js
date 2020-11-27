// rating categories (defaulted)
var categories = {"YOU": [0, {
    "r_nourishment": ["nourishment", 0],
    "r_value": ["value", 0]}],
"OTHERS": [0, {
    "r_human_welfare": ["human welfare", 0],
    "r_animal_welfare": ["animal welfare", 0]}],
"PLANET":[0, {
    "r_resource_cons": ["resource cons", 0],
    "r_biodiversity": ["biodiversity", 0],
    "r_global_warming": ["global warming", 0]}]};

var icons = {"YOU": "/static/img/icons8-customer-40.png",
    "OTHERS": "/static/img/icons8-user-groups-40.png",
    "PLANET": "/static/img/icons8-globe-40.png",
    "INFO": "/static/img/icons8-info-40.png"};

// Create Profile Table for Ethical Ratings, added element with id "title"
var title = document.getElementById("title");
var profileTable = createTableStruct("profile", 3);
insertAfter(profileTable, title);

// grab rows of profile table starting with header row
var header = profileTable.querySelector("thead > tr");
header.innerHTML = "RECIPE PROFILE";

// Add category table into row of profile table
var rows = profileTable.querySelectorAll("tbody > tr");
var i = 0
for(category in categories){
    td = document.createElement("td");
    rows[i].appendChild(td);
    i++;
    categoryTable = createTableStruct(category, Object.keys(categories[category][1]).length);
    categoryTable.addEventListener("click", showTableBody);
    td.appendChild(categoryTable);
    chead = categoryTable.querySelector("thead > tr");
    // Format each header with general details and provide expand button
    for(var j = 0; j < 5; j++){
        var headcell = document.createElement("th");
        chead.appendChild(headcell);
        if(j == 0){
            var img = document.createElement("img");
            img.src = icons[category];
            headcell.appendChild(img);
        }
        else if(j == 1){
            headcell.innerHTML = category;
        }
        else if (j == 2){
            headcell.innerHTML = "Average Rating:";
        }
        else if(j == 3){
            headcell.className = "avgRating";
            headcell.innerHTML = categories[category][0];
        }
        else{
            var btn = document.createElement("button");
            btn.type = "button";
            btn.className = "expand";
            btn.innerHTML = '\u25BC';
            headcell.appendChild(btn);
        }
    }
    // Add to each table body
    cbody = categoryTable.querySelector("tbody");
    cbody.style.display = "none";
    crows = categoryTable.querySelectorAll("tbody > tr");
    var k = 0;
    for(subcat in categories[category][1]){
        for(var j = 0; j < 3; j++){
            td = document.createElement("td");
            crows[k].appendChild(td);
            if(j == 0){
                var img = document.createElement("img");
                img.src = icons["INFO"];
                img.width = "20";
                td.appendChild(img);
            }
            else if(j == 1){
                td.innerHTML = categories[category][1][subcat][0];
            }
            else{
                td.className = "rating";
                td.id = subcat;
                td.innerHTML = categories[category][1][subcat][1];
            }
        }
        k++;
    } 
}

// update ratings
calcSubRatings(ingredients);
calcCategoryRatings();

console.log(JSON.parse(ingredients));
console.log(JSON.parse(alts));

function calcSubRatings(rating_dict){
    // Assign avg rating for each subcategory
    var dict = JSON.parse(rating_dict);
    for(ingredient in dict){
        for(rating in dict[ingredient]){
            tableRating = document.getElementById(rating);
            rating = dict[ingredient][rating] / (Object.keys(dict).length);
            newRating = Math.round((parseFloat(tableRating.innerHTML) + rating) * 100)/100;
            tableRating.innerHTML = newRating;
        }
    }
}

function calcCategoryRatings(){
    // Assign avg rating for each category
    for(category in categories){
        table = document.getElementById(category);
        avgRating = table.querySelector(".avgRating");
        ratings = table.querySelectorAll(".rating");
        for(r = 0; r < ratings.length; r++){
            value = parseFloat(ratings[r].innerHTML) / ratings.length;
            newValue = Math.round((parseFloat(avgRating.innerHTML) + value) * 100 )/ 100;
            avgRating.innerHTML = newValue;
        }
    }
}

function createTableStruct(tableID, numBodyRows){
    // Creates empty table with id of tableID
    var table = document.createElement("table");
    table.id = tableID;
    addTableHeader(table);
    addTableBody(table, numBodyRows);
    return table;
}

function addTableHeader(table){
    // Adds empty header row to table element
    var thead = document.createElement("thead");
    table.appendChild(thead);
    var hrow = document.createElement("tr");
    thead.appendChild(hrow);
}

function addTableBody(table, numBodyRows){
    // Adds empty body rows to table element
    var tbody = document.createElement("tbody");
    table.appendChild(tbody);
    for(var i =0; i < numBodyRows; i++){
        var tr = document.createElement("tr");
        tbody.appendChild(tr);
    }
}

function insertAfter(newNode, existingNode) {
    // place element after existing Node element 
    existingNode.parentNode.insertBefore(newNode, existingNode.nextSibling);
  }

function showTableBody(event) {
    // catches event of expand button and makes body of table either visible or hidden
    target = event.currentTarget;
    clicktarget = target.querySelector("button");
    tableBody = target.querySelector("tbody");
    if(tableBody.style.display === "none"){
        tableBody.style.display = "block";
        clicktarget.innerHTML = '\u25B2';
    }
    else{
        tableBody.style.display = "none";
        clicktarget.innerHTML = '\u25BC';
    }
}
