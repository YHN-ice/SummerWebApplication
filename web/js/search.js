window.onload = function () {
    var module = document.getElementsByClassName("to-be-trimmed");

    for (var i = 0; i < module.length; i++) {
        $clamp(module[i], {clamp: '3'});
    }
};

checkDelete = function(url) {
    if (confirm("Do you confirm your modification?"))
        window.location.href = url;
}
