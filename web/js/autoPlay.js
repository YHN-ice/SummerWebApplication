let pictureOn = 1;
let wrap = document.getElementById("wrap");
let buttons = document.getElementsByTagName("span");
let arrows = document.getElementsByClassName("arrow");
let next = document.getElementsByClassName("arrow_right")[0];
let prev = document.getElementsByClassName("arrow_left")[0];

let wrapMarginLeft = 0;
let auto = setInterval(function () {
    changePic(1)
}, 2000);


next.addEventListener("click", function () {
    changePic(1);
});
prev.addEventListener("click", function () {
    changePic(-1);
});

function changePic(direction) {
    let originPictureOn = pictureOn;
    pictureOn = pictureOn + direction;
    wrapMarginLeft = wrapMarginLeft - direction * 760;
    if (pictureOn == 0) {
        pictureOn = 5;
        wrapMarginLeft = -3040;
    } else if (pictureOn == 6) {
        pictureOn = 1;
        wrapMarginLeft = 0;
    }
    wrap.style.marginLeft = wrapMarginLeft + "px";
    buttons[originPictureOn - 1].className = null;
    buttons[pictureOn - 1].className = 'on';
}


/**-----------------------------------------*/

wrap.addEventListener("mouseout", function () {
    auto = setInterval(function () {
        changePic(1)
    }, 2000);
});

wrap.addEventListener("mouseover", function () {
    clearInterval(auto);
});

for (let i = 0; i < buttons.length; i++) {
    buttons[i].addEventListener("mouseout", function () {
        auto = setInterval(function () {
            changePic(1)
        }, 2000);
    });

    buttons[i].addEventListener("mouseover", function () {
        clearInterval(auto);
    });
}

for (let i = 0; i < arrows.length; i++) {
    arrows[i].addEventListener("mouseout", function () {
        auto = setInterval(function () {
            changePic(1)
        }, 2000);
    });

    arrows[i].addEventListener("mouseover", function () {
        clearInterval(auto);
    });
}

/**-----------------------------------------*/
for (let i = 0; i < buttons.length; i++) {
    buttons[i].addEventListener("click", function () {
        changePic(i + 1 - pictureOn);
    })
}