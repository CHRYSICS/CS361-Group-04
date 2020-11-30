// rating categories (defaulted)
var categories = {"YOU": [0, {
    "r_nourishment": [0, "nourishment"],
    "r_value": [0, "value"]}],
"OTHERS": [0, {
    "r_human_welfare": [0, "human welfare"],
    "r_animal_welfare": [0, "animal welfare"]}],
"PLANET":[0, {
    "r_resource_cons": [0, "resource cons"],
    "r_biodiversity": [0, "biodiversity"],
    "r_global_warming": [0, "global warming"]}]};

var icons = {"YOU": "/static/img/icons8-customer-40.png",
    "OTHERS": "/static/img/icons8-user-groups-40.png",
    "PLANET": "/static/img/icons8-globe-40.png",
    "INFO": "/static/img/icons8-info-40.png"};

// Parse incoming working data from flask update template
var ingredients = JSON.parse(ingredients);
var alts = JSON.parse(alts);

// Create Profile Table for Ethical Ratings, added element with id "title"
var title = document.getElementById("body");
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
                td.innerHTML = categories[category][1][subcat][1];
            }
            else{
                td.className = "rating";
                td.id = subcat;
                td.innerHTML = categories[category][1][subcat][0];
            }
        }
        k++;
    } 
}

// console log the working data from flask template 
console.log(ingredients);
console.log(alts);

// update ratings
calcCategoryRatings();
console.log(categories);

function zeroRatings(categoryDict){
    for(name in categoryDict){
        categoryDict[name][0] = 0;
        for(subName in categoryDict[name][1]){
            categoryDict[name][1][subName][0] = 0;
        }
    }
}

function calcSubRatings(ingredients, alts){
    // zero rate values first
    zeroRatings(categories);
    // Assign avg rating for each subcategory
    var notRatingValues = ["id", "category_id", "amount", "unit"];
    for(name in ingredients){
        for(rating in alts[name]){
            if(notRatingValues.includes(rating)){
                continue;
            }
            for(cat in categories){
                if(rating in categories[cat][1]){
                    curVal = categories[cat][1][rating][0];
                    newAdd = alts[name][rating] / (Object.keys(ingredients).length);
                    newVal = Math.round((curVal + newAdd) * 100)/100;
                    categories[cat][1][rating][0] = newVal;
                    tableRating = document.getElementById(rating);
                    tableRating.innerHTML = newVal;
                    break;
                }
            }
        }
    }
}

function calcCategoryRatings(){
    // update subcategories first
    calcSubRatings(ingredients, alts);
    // Assign avg rating for each category
    for(cat in categories){
        categories[cat][0] = 0;
        curVal = 0;
        subCats = categories[cat][1];
        for(sub in subCats){
            newAdd = subCats[sub][0] / (Object.keys(subCats).length);
            curVal += newAdd;
        }
        categories[cat][0] = Math.round(curVal * 100)/100;
        table = document.getElementById(cat);
        avgRating = table.querySelector(".avgRating");
        avgRating.innerHTML = categories[cat][0];
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

function changeAlts(currentTarget){
    // changes currentIngredient to selected ingredient
    currentTarget.onchange = function(){
        console.log(currentTarget.value);
        for(name in ingredients){
            if(ingredients[name]["id"] == currentTarget.value){
                console.log(ingredient[name]);
            }
        }
    }
    // for(i = 1; i < targets.length; i++){
    //     if(targets[i].classList.contains("selected")){
    //         target = targets[i];
    //         target.className = "alts unselected";
    //         if(i == targets.length - 1){
    //             nextTarget = targets[1];
    //             nextTarget.className = "alts selected";
    //         }else{
    //             nextTarget = targets[i + 1];
    //             nextTarget.className = "alts selected";
    //         }
    //         return;
    //     }
    // }
}

function changeAmount(currentTarget, signal){
    // Depending on signal, either increase or decrease amount by .1
    target = currentTarget.querySelector(".amount");
    inputs = target.innerHTML.split(" ");
    returnInput = "";
    if(signal === "increase"){
        inputs[0] = Math.round((parseFloat(inputs[0]) + .1) * 100)/100;
        for(i in inputs){
            returnInput += inputs[i] + " ";
        }
        target.abbr = inputs[0] + " " + inputs[1];
        target.innerHTML = returnInput;
        console.log(target.abbr);
    }
    else if(signal === "decrease"){
        inputs[0] = Math.round((parseFloat(inputs[0]) - .1) * 100)/100;
        for(i in inputs){
            returnInput += inputs[i] + " ";
        }
        target.abbr = inputs[0] + " " + inputs[1];
        target.innerHTML = returnInput;
    }else{return;}
}

function eventManager(event){
    // handles events from ingredient table and call corresponding function
    target = event.target;
    curtarget = event.currentTarget;
    classes = target.classList;
    if(target.classList.contains("alts")){
        changeAlts(target);
    }
    else if(target.classList.contains("amount")){
        if(classes.contains("increase")){
            changeAmount(curtarget, "increase");
        }else if(classes.contains("decrease")){
            changeAmount(curtarget, "decrease");
        }
    }
    else{return;}
}

function updateRecipe(event){
    //console.log(event.currentTarget);
}
// add event listener to ingredient table
Array.from(document.getElementsByClassName('alts')).forEach(selected => {
    selected.onchange = function(){
        var id = selected.value;
        var name, category;
        for(name in alts){
            if(parseInt(alts[name]["id"]) == selected.value){
                category = alts[name]["category_id"];
                break;
            }
        }
        for(item in ingredients){
            if(ingredients[item]["category"] == category){
                amount = ingredients[item]["amount"];
                unit = ingredients[item]["unit"];
                recipe_id = ingredients[item]["unit"];
                delete ingredients[item];

                ingredients[name] = {};
                ingredients[name]["recipe_id"] = recipe_id;
                ingredients[name]["ingredient_id"] = selected.value;
                ingredients[name]["category"] = category;
                ingredients[name]["amount"] = amount;
                ingredients[name]["unit"] = unit;
                calcSubRatings(ingredients, alts);
                calcCategoryRatings();
                return;
            }
        }
    }
});
// document.querySelectorAll('.ingredient').forEach(item => {
//     item.addEventListener('click', eventManager);
//     item.addEventListener('click', updateRecipe);
// })
