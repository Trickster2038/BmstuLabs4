// рекурсивный спуск
// Бэкус-Наур
// <запись> ::= var <идентификатор>:record <постоянные поля> <поля с вариантами> end;
// <постоянные поля> ::= <поля одного типа>;
//                    |<поля одного типа>;<постоянные поля>
// <поля с вариантами> ::= case <идентификатор> of <случаи>
// <случаи> = <случай>|<случай>;<случаи>
// <случай> ::= <ключ>: (<поля одного типа>)
// ИНОГДА НУЖНА ; В КОНЦЕ ?

// <поля одного типа> ::= <идентификаторы>: <тип>
// <идентификаторы> ::= <идентификатор>
//                      |<идентификатор>,<идентификаторы>
// TODO <идентификатор>, <ключ>, <тип> - регулярки

function validID(x) {
    //var regex1 = /[ :;]{1,}/m 
    //flag = /^[_a-z]+[_a-z0-9]{0,}$/.test(tokens[0])
    //console.log("validingID")
    x = x.trim()
    console.log("validingID:" + x)
    if (/[_a-z]$/.test(x[0])) {
        while ((/[_a-z0-9]$/.test(x[0])) && x.length > 0) {
            x = x.slice(1)
            //console.log("loop")
        }
    } else {
        throw "Wrong ID"
    }
    x = x.trim()
    return x
}

function validIDs(x) {
    //console.log("validingIDs")
    x = x.trim()
    console.log("validingIDs:" + x)
    x = validID(x)
    if (x[0] == ",") {
        x = x.slice(1)
        x = validIDs(x)
    } else {
        // nothing?
        console.log("validingIDs end")
    }
    return x
}

function validType(x) {
    x = x.trim()
    console.log("validingType:" + x)
    if (x.slice(0, 4) == "byte" || x.slice(0, 4) == "char" || x.slice(0, 4) == "real") {
        x = x.slice(4)
    } else if (x.slice(0, 7) == "integer") {
        x = x.slice(7)
    } else {
        throw "Wrong Type"
    }
    x = x.trim()
    return x
}

function validSameFields(x) {
    x = x.trim()
    console.log("validingSameFields:" + x)
    x = validIDs(x)
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

function validCase(x){
    let flag = 0
    x = x.trim()
    console.log("validingCase:" + x)
    x = validKey(x)
    x = x.trim()
    if(x[0]==":"){
        flag++
        x = x.slice(1)
        x = x.trim()
        if(x[0]=="("){
            flag++
            x = x.slice(1)
            x = x.trim()
            x = validSameFields(x)
            x = x.trim()
            if(x[0]==")"){
                flag++
                x = x.slice(1)
                x = x.trim()
            }
        }
    }
    if(flag != 3){
        throw "Wrong Case"
    }
    return x
}

function validCases(x){
    x = x.trim()
    console.log("validingCases:" + x)
    x = validCase(x)
    x = x.trim()
    if(x[0]==";"){
        x = x.slice(1)
        x = validCase(x)
    } else{
        console.log("validingCases end")
    }
    x = x.trim()
    return x
}

function validSwitch(x){
    let flag = 0
    x = x.trim()
    console.log("validingSwitch:" + x)
    if(x.slice(0,4)=="case"){
        flag++
        x = x.slice(4)
        x = validID(x)
        x = x.trim()
        if(x.slice(0,2)=="of"){
            flag++
            x = x.slice(2)
            x = validCases(x)
        }
    }
    if(flag != 2){
        throw "Wrong Switch"
    }
    x = x.trim()
    return x
}

var str1 = "_abc3, feff, ghh"
str1 = validIDs(str1)
//validType("integer")
//validSameFields("af, gh :integer")
//validKey("421:")
//validCase("42: (ab, gh: integer)")
//validCases("42: (ab, gh: integer); 3213: (_ab, gd3h: byte)")
validSwitch("case saa of 42: (ab, gh: integer); 3213: (_ab, gd3h: byte)")

// ERROR TESTS
//validCases("42: (ab, gh: integer); 3213: (1_ab, gd3h: byte)")
// validCase("42: ab, gh: integer)")
//validSameFields("af, gh :intger")
//validIDs("4abc3, regg")
//validKey("421f:")