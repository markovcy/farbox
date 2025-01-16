let cart = {};

document.querySelectorAll('.add-to-cart').forEach(function(element) {
    element.onclick = addToCart;
})

if(localStorage.getItem('cart')) {
    cart = JSON.parse(localStorage.getItem('cart'));
    AjaxGetGoodInfo();
}

function addToCart() {
    let goodsId = this.dataset.goods_id;
    if (cart[goodsId]) {
        cart[goodsId]++;
    } else {
        cart[goodsId] = 1;
    }
    console.log(cart);
    AjaxGetGoodInfo();
}

function AjaxGetGoodInfo() {
    updateLocalStorageCart();
    fetch('/get-goods-info', {
        method: 'POST',
        body: JSON.stringify({key: Object.keys(cart)}),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    }).then(function(response){
        console.log(response)
        // console.log(response.text())
        return response.text()
    }).then(function(body){
        console.log("body", body);
        showCart(JSON.parse(body))
        // console.log(JSON.parse(body));
    })
    
}

function showCart(data) {
    let total = 0;
    let out = "<table class='table table-striped table-cart'><tbody>";
    for (let key in cart) {
        console.log(data[key]['name'])
        out += `<tr><td colspan="4"><a href='goods?id=${key}'>${data[key]['name']}</a></td></tr>`
        out += `<tr><td><i class="fa fa-minus-square cart-minus" data-goods_id='${key}'></i></td>`
        out += `<td>${cart[key]}</td>`
        out += `<td class=""><i class="fa fa-plus-square cart-plus" data-goods_id='${key}'></i></td>`
        out += `<td>${formatPrice(data[key]['cost']*cart[key])}</td>`
        total += data[key]['cost']*cart[key]
    }
    out += `<tr><td colspan="3">Total:</td><td>${formatPrice(total)}</td></tr>`
    out += '</tbody></table>'
    document.querySelector("#cart-nav").innerHTML = out; 
    document.querySelectorAll(".cart-plus").forEach(function(element){
        element.onclick = plusCart;
    document.querySelectorAll(".cart-minus").forEach(function(element){
        element.onclick = minusCart
    })
    }) 
}

function plusCart() {
    let goodsId = this.dataset.goods_id
    cart[goodsId]++
    AjaxGetGoodInfo()
}
function minusCart() {
    let goodsId = this.dataset.goods_id
    if (cart[goodsId] > 1) {
        cart[goodsId]--
    } else {
        delete(cart[goodsId])
    }
    AjaxGetGoodInfo()
}

function updateLocalStorageCart() {
    localStorage.setItem('cart', JSON.stringify(cart))
}

function formatPrice(price) {
    return price.toFixed(2)
}