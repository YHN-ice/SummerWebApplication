function refresh() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            let room = document.getElementById('show-zone');
            let imageElements = document.getElementsByClassName('show-zone-image');
            let titleElements = document.getElementsByClassName('show-zone-title');
            let descriptionElements = document.getElementsByClassName('show-zone-description');



            let result = this.responseXML;
            console.log(result);
            let size=result.documentElement.getElementsByTagName("size")[0].firstChild.nodeValue;


            for (let i = 0; i < size; i++) {

                if (!(i < imageElements.length)) {
                    let img = document.createElement('img');
                    img.src = 'travel-images/large/' + result.documentElement.getElementsByTagName("path" + i)[0].firstChild.nodeValue;
                    img.className = 'show-zone-image ' + result.documentElement.getElementsByTagName("imageId" + i)[0].firstChild.nodeValue;

                    let outer = document.createElement('a');
                    outer.href = "detail.php?ImageID=" + result.documentElement.getElementsByTagName("imageId" + i)[0].firstChild.nodeValue;

                    let title = document.createElement('h3');
                    title.className = 'show-zone-title';
                    title.innerHTML = result.documentElement.getElementsByTagName("title" + i)[0].firstChild.nodeValue;

                    let description = document.createElement('p');
                    description.className = 'show-zone-description';
                    description.innerHTML = result.documentElement.getElementsByTagName("description" + i)[0].firstChild.nodeValue;

                    let container = document.createElement('div');

                    outer.appendChild(img);
                    container.appendChild(outer);
                    container.appendChild(title);
                    container.appendChild(description);
                    room.appendChild(container);
                } else {
                    imageElements[i].src = 'travel-images/large/' + result.documentElement.getElementsByTagName("path" + i)[0].firstChild.nodeValue;
                    imageElements[i].parentElement.href = "detail?ImageID=" + result.documentElement.getElementsByTagName("imageId" + i)[0].firstChild.nodeValue;
                    titleElements[i].innerHTML = result.documentElement.getElementsByTagName("title" + i)[0].firstChild.nodeValue;
                    descriptionElements[i].innerHTML = result.documentElement.getElementsByTagName("description" + i)[0].firstChild.nodeValue;
                }
            }

        }
    };
    xmlhttp.open("GET", "refreshImageExhibited", true);
    xmlhttp.send();
}