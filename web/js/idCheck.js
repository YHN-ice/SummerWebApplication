let duplicated = false;
let checkRight = false;

function idCheck(id) {
    duplicated = false;
    let button = document.getElementById('submit-button');
    let info = document.getElementById('tips');

    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            let result = this.responseText;
            console.log(result)
            if (result == '0'){
                duplicated = false;
                if(!duplicated&&checkRight)
                button.disabled = false;
                info.innerHTML = "用户名未被使用过√"
            } else{
                duplicated = true;
                if(!checkRight||duplicated)
                button.disabled = true;
                info.innerHTML = '用户名已被使用x';
            }
        }
    };
    xmlhttp.open("GET", "checkUserNameExistence?id="+id, true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
    xmlhttp.send();
}

function passwordCheck() {
    let password1st = document.getElementsByName('password')[0].value;
    let password2nd = document.getElementsByName('password-again')[0].value;
    if(password1st!==password2nd){
        document.getElementById('submit-button').disabled = true;
        document.getElementById('password-tips').innerHTML = "两次密码不相同x";
    }
    else{
        document.getElementById('submit-button').disabled = false;
        document.getElementById('password-tips').innerHTML = "两次密码相同√";
    }
}

function passwordTest(obj) {
    var value = obj.value;
    var result = getResult(value);
    check(result);
}

function getResult(value) {
    if(value.length < 3) {
        return 0;
    }
    var i = 0;
    if(value.match(/[a-z]/ig)) {
        i++;
    }
    if(value.match(/[0-9]/ig)) {
        i++;
    }
    if(value.match(/(.[^a-z0-9])/ig)) {
        i++;
    }
    if(value.length < 6 && i > 0) {
        i--
    }
    return i;
}

function check(num) {
    if(num == 0) {
        $("note").innerHTML = "密码太短";
    } else if (num == 1) {
        $("note").innerHTML = "密码强度差";
    } else if (num == 2) {
        $("note").innerHTML = "密码强度良好";
    } else if (num == 3) {
        $("note").innerHTML = "密码强度高";
    } else {
        $("note").innerHTML = "未知错误";
    }
}

function $(id) {
    return document.getElementById(id);
}



var code;
function createCode()
{
    code = "";
    var codeLength = 6; //验证码的长度
    var checkCode = document.getElementById("checkCode");
    var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
    for(var i = 0; i < codeLength; i++)
    {
        var charNum = Math.floor(Math.random() * 52);
        code += codeChars[charNum];
    }
    if(checkCode)
    {
        checkCode.className = "code";
        checkCode.innerHTML = code;
    }
}
function validateCode()
{
    checkRight = false;
    let button = document.getElementById('submit-button');
    var inputCode=document.getElementById("inputCode").value;
    tip = document.getElementById("tip")
    if(inputCode.length <= 0)
    {
        tip.innerHTML = "请输入验证码！";

        checkRight = false;

        if(!checkRight||duplicated)
        button.disabled = true;
    }
    else if(inputCode.toUpperCase() != code.toUpperCase())
    {
        tip.innerHTML = "验证码输入有误！";

        checkRight = false;

        if(!checkRight||duplicated)
            button.disabled = true;
        createCode();
    }
    else
    {
        tip.innerHTML = "验证码正确！";
        checkRight = true;
        if(checkRight&&!duplicated)
        button.disabled = false;

    }
}