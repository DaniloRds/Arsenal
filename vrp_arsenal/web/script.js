$("img").attr("draggable","false")
const active = (parameter) => {
    $('.armamentos').removeClass('active')
    $('#armamentos').removeClass('active')
    $(parameter).addClass("active")
}

function fechar() {
    $('body').fadeOut()
    fetch(`https://${GetParentResourceName()}/fechar2`, {
        method: "POST",
        headers: {
        "Content-Type": "application/json; charset=UTF-8",
        }
    })
}

function armamentos() {
    $(".favoritos-main").hide()
    $(".quadrado-main").show()
}

function guardar() {
    fetch(`https://${GetParentResourceName()}/guardar`, {
		method: "POST",
		headers: {
		"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({name : print}),
	})
}

function colete() {
    fetch(`https://${GetParentResourceName()}/colete`, {
		method: "POST",
		headers: {
		"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({name : print}),
	})
}

function guardarColete() {
    fetch(`https://${GetParentResourceName()}/guardarColete`, {
		method: "POST",
		headers: {
		"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({name : print}),
	})
}

function verificar(dom, domChildren) {
    let add = true
    const element = dom

    $(domChildren).children().each((_,item) => {
        const tem = $(item).find('.q-text').text()
        const vaiter = $($(dom)[0]).find('.q-text').text()

        if (tem != '' && vaiter != '' && tem == vaiter) {
           $(item).remove()
        }
    })

    if (add) {
        $('.favoritos-main').append(`<div class="quadrado"> ${element} </div>`)
        add = false
    }
}

$("body").css("display", "none")

window.addEventListener('message', (event) => {
    const data  = event.data

    if (data.arsenal) {
        $("body").css("display", "flex")
    } else {
      $("body").css("display", "none")
    }  
})

function equipar(print) {
    fetch(`https://${GetParentResourceName()}/buy`, {
		method: "POST",
		headers: {
		"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({name : print}),
	})
}

document.onkeyup = function(data) {
    if (data.which == 27) {
        $("body").css("display", "none")
        fetch(`https://${GetParentResourceName()}/fechar2`, {
            method: "POST",
            headers: {
            "Content-Type": "application/json; charset=UTF-8",
            }
        })
    }
};