console.log("nav")

let button = document.querySelector('.close-nav')
let theme = document.querySelector('.site-nav')

button.onclick = function() {
    console.log("6")
    document.querySelector('.site-nav').classList.toggle('site-nav-close')
    document.querySelector('.site-nav').classList.toggle('site-nav-open')
}


function getCategoryList() {
    fetch('/get-category-list', {
        method: 'POST'
    }).then(function(response){
        console.log(response)
        // console.log(response.text())
        return response.text()
    }).then(function(body){
        console.log("body", body);
        body = JSON.parse(body);
        console.log("JSONbody", body);
        
        showCategotyList(body)
    })
}

function showCategotyList(data) {
    console.log('data', data);
    let out =   "<ul class='category-list'><li class='menu_link'><a href='/'>Main</a></li>"
    for (let i = 0; i < data.length; i++) {
        out += `<li class='menu_link'><a href='/cat?id=${data[i]['id']}'>${data[i]['category']}</a></li>`
    }
    let out_top =   "<ul class='menu_list'><li class='menu_item'><a href='/' class='menu_link'>Main</a></li>"
    for (let i = 0; i < data.length; i++) {
        out_top += `<li  class='menu_item'><a href='/cat?id=${data[i]['id']}' class='menu_link'>${data[i]['category']}</a></li>`
    }
    out += "</ul>"
    console.log(out)
    document.querySelector("#category-list").innerHTML = out
    document.querySelector(".header_menu").innerHTML = out_top
}

getCategoryList()