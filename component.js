function getTableByName(elementName){
    var tableElement = document.getElementsByName(elementName);
    var result = null;
    if(tableElement[0].tagName == "TABLE")
        result = tableElement[0];
    else
        console.error(elementName + "は、table要素ではないためエラーを送ります");
    return result;
}

function getRowByName(elementName){
    var roweElement = document.getElementsByName(elementName);
    var result = null;
    if(rowElement.tagName === "TR")
        result = rowElement;
    else
        console.error(elementName + "は、tr要素ではないためエラーを送ります");
    return result;
}

function getCellByName(elementName){
    var cellElement = document.getElementsByName(elementName);
    var result = null;
    if(cellElement.tagName === "TD")
        result = cellElement;
    else
        console.error(elementName + "は、td要素ではないためエラーを送ります");
    return result;
}

function addTableRow(tableElement){
    return tableElement.insertRow();
}

function addTableRowbyName(elementName){
    var tableElement = document.getElementsByName(elementName);
    return tableElement.insertRow();
}

function addCell(trElement){
    return trElement.insertCell();
}

function setCellElement(cellElement,elementName,typeName,controlName){
    var element = cellElement.appendChild(document.createElement(elementName));
    element.setAttribute("type",typeName);
    if(controlName!=null)
        element.setAttribute("name",controlName);
    return element;
}

function addCellAndSet(trElement,elementName,typeName,controlName){
    var cellElement = trElement.insertCell();
    return setCellElement(cellElement,elementName,typeName,controlName);
}

function addElementandSetAttribute(parentElement,elementName,attributeName,value){
    child = parentElement.appendChild(document.createElement(elementName));
    child.setAttribute(attributeName,value);
    return child;
}
