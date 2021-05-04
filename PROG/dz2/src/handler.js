function validID(x) {
    x = x.trim()
    console.log("validingID:" + x)
    if (/[_a-z]$/.test(x[0])) {
        while ((/[_a-z0-9]$/.test(x[0])) && x.length > 0) {
            x = x.slice(1)
        }
    } else {
        throw "Wrong ID"
    }
    x = x.trim()
    return x
}

function validIDs(x) {
    x = x.trim()
    console.log("validingIDs:" + x)
    x = validID(x)
    if (x[0] == ",") {
        x = x.slice(1)
        x = validIDs(x)
    } else {
        console.log("validingIDs end")
    }
    return x
}

function validType(x) {
    x = x.trim()
    console.log("validingType:" + x)
    let xcpy = x
    if (x.slice(0, 4) == "byte" || x.slice(0, 4) == "char" || x.slice(0, 4) == "real") {
        x = x.slice(4)
    } else if (x.slice(0, 7) == "integer") {
        x = x.slice(7)
    } else {
        throw "Wrong Type"
    }
    logOnUi("Type: "+xcpy.slice(0,xcpy.length-x.length))
    x = x.trim()
    return x
}

function validSameFields(x) {
    x = x.trim()
    console.log("validingSameFields:" + x)
    let xcpy
    xcpy = x
    x = validIDs(x)
    logOnUi("\nFields: "+ xcpy.slice(0,xcpy.length-x.length))
    x = x.trim()
    if (x[0] == ":") {
        x = x.slice(1)
        x = x.trim()
        x = validType(x)
        x = x.trim()
    } else {
        throw "Wrong Same Fields"
    }
    return x
}

function validKey(x) {
    x = x.trim()
    console.log("validingKey:" + x)
    if (/[0-9]$/.test(x[0])) {
        while ((/[0-9]$/.test(x[0])) && x.length > 0) {
            x = x.slice(1)
        }
    } else {
        throw "Wrong Key"
    }
    x = x.trim()
    if (x[0] != ":") {
        throw "Wrong Key"
    }
    return x
}

function validCase(x) {
    let flag = 0
    x = x.trim()
    console.log("validingCase:" + x)
    x = validKey(x)
    x = x.trim()
    if (x[0] == ":") {
        flag++
        x = x.slice(1)
        x = x.trim()
        if (x[0] == "(") {
            flag++
            x = x.slice(1)
            x = x.trim()
            x = validSameFields(x)
            x = x.trim()
            if (x[0] == ")") {
                flag++
                x = x.slice(1)
                x = x.trim()
            }
        }
    }
    if (flag != 3) {
        throw "Wrong Case"
    }
    return x
}

function validCases(x) {
    x = x.trim()
    console.log("validingCases:" + x)
    x = validCase(x)
    x = x.trim()
    if (x[0] == ";") {
        x = x.slice(1)
        x = validCase(x)
    } else {
        console.log("validingCases end")
    }
    x = x.trim()
    return x
}

function validSwitchFields(x) {
    let flag = 0
    x = x.trim()
    console.log("validingSwitch:" + x)
    if (x.slice(0, 4) == "case") {
        flag++
        x = x.slice(4)
        x = validID(x)
        x = x.trim()
        if (x.slice(0, 2) == "of") {
            flag++
            x = x.slice(2)
            x = validCases(x)
        }
    }
    if (flag != 2) {
        throw "Wrong Switch"
    }
    x = x.trim()
    return x
}

function validStaticFields(x) {
    let flag = false
    x = x.trim()
    console.log("validingStatic:" + x)
    x = validSameFields(x)
    if (x[0] == ";") {
        x = x.slice(1)
        x = x.trim()
        if (x.slice(0, 4) != "case") {
            flag = true
            while (flag) {
                flag = false
                x = validSameFields(x)
                if (x[0] == ";") {
                    x = x.slice(1)
                    x = x.trim()
                    if (x.slice(0, 4) != "case") {
                        flag = true
                    }
                }
            }
        }
    }
    return x
}

function validRecord(x){
    let flag = 0
    x = x.toLowerCase()
    x = x.replace(/[\n\t]/g," ")
    x = x.trim()
    console.log("validingRecord:" + x)
    if(x.slice(0,3)=="var"){
        flag++
        x = x.slice(3)
        x = x.trim()
        let xcpy
        xcpy = x
        x = validID(x)
        logOnUi("Record name: "+ xcpy.slice(0, (xcpy.length-x.length)))
        x = x.trim()
        if(x.slice(0,7)==":record"){
            flag++
            x = x.slice(7)
            x = x.trim()
            x = validStaticFields(x)
            x = x.trim()
            if(x.slice(0,4)=="end;"){
                flag++
            } else {
                x = validSwitchFields(x)
                if(x.slice(0,4)=="end;"){
                    flag++
                }
            }
        }
    }
    if(flag!=3){
        throw "Wrong Record"
    }
    return x
}

// =========================== UI Business-logic ===============================

function validUiCall(){
    codeInput = document.getElementById("codeInput")
    resultLine = document.getElementById("resultInput")
    code = codeInput.value
    try{
        validRecord(code)
        resultLine.value = "Code is correct"
        resultLine.className = "bg-success form-control"
    }catch(e){
        resultLine.value = e
        resultLine.className = "bg-danger form-control"
    }
}

function logOnUi(x)
{
    logArea = document.getElementById("logTextArea")
    logArea.value += x + "\n"
}

function resetUi(){
    resultLine = document.getElementById("resultInput")
    resultLine.value = ""
    resultLine.className = "form-control"
    logArea = document.getElementById("logTextArea")
    logArea.value = ""
}