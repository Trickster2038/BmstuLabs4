// рекурсивный спуск
// Бэкус-Наур
// <запись> ::= var <идентификатор>:record <постоянные поля> <поля с вариантами> end;
// <постоянные поля> ::= <поля одного типа>;
//                    |<поля одного типа>;<постоянные поля>
// <поля с вариантами> ::= case <идентификатор> of <случаи>

// <случаи> ::= <ключ>: (<поля одного типа>)
// ИНОГДА НУЖНА ; В КОНЦЕ

// <поля одного типа> ::= <идентификаторы>: <тип>
// <идентификаторы> ::= <идентификатор>
//                      |<идентификатор>,<идентификаторы>
// TODO <идентификатор>, <ключ>, <тип> - регулярки

function validID(x){
    //var regex1 = /[ :;]{1,}/m 
    //flag = /^[_a-z]+[_a-z0-9]{0,}$/.test(tokens[0])
    //console.log("validingID")
    x = x.trim()
    console.log("validingID:"+x)
    if(/[_a-z]$/.test(x[0])){
        while((/[_a-z0-9]$/.test(x[0])) && x.length > 0){
            x = x.slice(1)
            //console.log("loop")
        }
    } else {
        throw "Wrong ID"
    }
    x = x.trim()
    return x
}

function validIDs(x){
    //console.log("validingIDs")
    x = x.trim()
    console.log("validingIDs:"+x)
    x = validID(x)
    if(x[0] == ","){
        x = x.slice(1)
        x = validIDs(x)
    } else {
        // nothing?
        console.log("validingIDs end")
    }
    return x
}

var str1 = "_abc3, feff, ghh"
str1 = validIDs(str1)

//validIDs("4abc3, regg")