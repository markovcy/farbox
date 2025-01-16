document.querySelector('#order__form').onsubmit = function(event) {
    event.preventDefault();
    let username = document.querySelector('#username').value.trim();
    let phone = document.querySelector('#phone').value.trim();
    let email = document.querySelector('#email').value.trim();
    let address = document.querySelector('#address').value.trim();

    if (!document.querySelector('#rule').checked) {
        Swal.fire({
            title: "Warning",
            text: "Rear and accept the rules",
            type: "info",
            comfirmButtonText: "OK"
        })

    }
    if (username === '' || phone === '' || email === '' || address === '') {
        Swal.fire({
            title: "Warning",
            text: "Fill the fields",
            type: "info",
            comfirmButtonText: "OK"
        })

    }
    fetch('/finish-order', {
        method: 'POST',
        body: JSON.stringify({
            'username' : username,
            'phone' : phone,
            'email' : email,
            'address' : address,
            'key' : JSON.parse(localStorage.getItem('cart'))
        }),
        headers: {
            'Accept' : 'application/json',
            'Content-Type' : 'application/json'
        }
    }).then(function(response){
        return response.text()
    }).then(function(body){
        if (body === 1) {

        } else {

        }
    })
}