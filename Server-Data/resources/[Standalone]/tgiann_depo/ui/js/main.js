let sifre = ""
let identifier = ""

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        let htmlYazi = ""
        let depomVar = false
        for (let data = 0; data < event.data.data.length; data++) {
            const element = event.data.data[data];
            if (element.identifier == event.data.identifier) {
                depomVar = true
                htmlYazi = htmlYazi + `
                    <div class="depo-tablo">
                        <div class="depo-tablo-sol">
                            <div class="depo-id">depo_${element.num}</div>
                            <div class="depo-ismi">${element.ad}</div>
                        </div>
                        <div class="depo-button" data-pw="${element.sifre}" data-ci="${element.identifier}" data-isim="${element.ad}(${element.num})"><i class="fas fa-star"></i> Depoyu Aç</div>
                    </div>
                `
            } else {
                htmlYazi = htmlYazi + `
                    <div class="depo-tablo">
                        <div class="depo-tablo-sol">
                            <div class="depo-id">depo_${element.num}</div>
                            <div class="depo-ismi">${element.ad}</div>
                        </div>
                        <div class="depo-button" data-pw="${element.sifre}" data-ci="${element.identifier}" data-isim="${element.ad}(${element.num})"><i class="far fa-star"></i> Depoyu Aç</div>
                    </div>
                `
            }
        }

        if (depomVar) {
            $(".tablet-top").html(`
                <div class="tablet-top">
                    <div class="tablet-top-button" id="sat">Depomu Sat</div>
                    <div class="top-text">DEPOLAR</div>
                    <div class="tablet-top-button-x" id="ui-kapat"><i class="fas fa-times"></i></div>
                </div>
            `)
        } else {
            $(".tablet-top").html(`
                <div class="tablet-top">
                    <div class="tablet-top-button" id="satin-al">Depo Satın Al</div>
                    <div class="top-text">DEPOLAR</div>
                    <div class="tablet-top-button-x" id="ui-kapat"><i class="fas fa-times"></i></div>
                </div>
            `)
        }

        $(".depolar").html(htmlYazi)
        $(".tablet").css("display", "flex");
    }
});

$(document).on("click",".depo-button", function() {
    sifre = $(this).attr("data-pw")
    ad = $(this).attr("data-isim")
    $(".satin-al").css("display", "none");
    $(".ac-menu").css("display", "block");
    $(".depo-sifre-isim").html($(this).attr("data-isim"));
}); 

$(document).on("click","#ui-kapat", function() {
    uiKapat()
});

function uiKapat() {
    $(".tablet").css("display", "none");
    $(".satin-al").css("display", "none");
    $(".ac-menu").css("display", "none");
    $.post('http://tgiann_depo/kapat')
}

$(document).on("click","#satin-al-x", function() {
    $(".satin-al").css("display", "none");
});

$(document).on("click","#sifre-x", function() {
    $(".ac-menu").css("display", "none");
});

$(document).on("click","#satin-al", function() {
    $(".satin-al").css("display", "block");
    $(".ac-menu").css("display", "none");
});

$(document).on("click",".satin-al-menu-button", function() {
    const depoIsmi = $("#depo-ismi").val()
    const depoSifre = $("#depo-sifre").val()
    if (depoIsmi.length < 4) {
        Swal.fire({icon: 'error', text: 'Deponun Adı En Az 4 Haneli Olabilir!'});
    } else if (depoSifre.length < 4) {
        Swal.fire({icon: 'error', text: 'Deponun Şifresi En Az 4 Haneli Olabilir!'});
    } else {
        $.post('http://tgiann_depo/satinal', JSON.stringify({
                ad: $("#depo-ismi").val(),
                sifre: $("#depo-sifre").val()
            })
        );
        $(".satin-al").css("display", "none");
    }
});

$(document).on("click","#sat", function() {
    $.post('http://tgiann_depo/deposat')
})

$(document).on("click",".ac-menu-button", function() {
    console.log(sifre)
    if (sifre == $("#depo-sifre-gir").val()) {
        uiKapat()
        $.post('http://tgiann_depo/ac', JSON.stringify({
            ad: ad
            })
        );
    } else {
        $.post('http://tgiann_depo/sifreyanlis')
    }
});