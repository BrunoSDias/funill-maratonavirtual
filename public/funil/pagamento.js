var maratonaVirtual = {};
maratonaVirtual.host = 'http://localhost:3001/';
maratonaVirtual.token = '79hrovrwibfxsrh_TglsoTy*b5sjcht9f5na*53Gmcfjg555Site';
maratonaVirtual.pg_id = "C49117ED8151463DB189BF82F7AECB67";

maratonaVirtual.load = {
  on: function() {
    $("#modal-load").show();
  },
  off: function() {
    $("#modal-load").hide();
  }
}

var promocao = {};
promocao.confirmarCompra = function(self, pagina_id){
  $(self).html("Carregando ...");
  $(self).attr("disabled", "disabled");

  if(!$("#numeroCartao").val() || $("#numeroCartao").val() == ""){
    $("#numeroCartao").focus();
    $("#numeroCartao").css("background", "#fbb67a")
    $("#numeroCartao").attr("placeholder", "Número obrigatório");
    $("#numeroCartao").blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!$("#nomeCartao").val() || $("#nomeCartao").val() == ""){
    $("#nomeCartao").focus();
    $("#nomeCartao").css("background", "#fbb67a")
    $("#nomeCartao").attr("placeholder", "Nome obrigatório");
    $("#nomeCartao").blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!$("#mesAnoCartao").val() || $("#mesAnoCartao").val() == ""){
    $("#mesAnoCartao").focus();
    $("#mesAnoCartao").css("background", "#fbb67a")
    $("#mesAnoCartao").attr("placeholder", "Mês obrigatório");
    $("#mesAnoCartao").blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!$("#cvvCartao").val() || $("#cvvCartao").val() == ""){
    $("#cvvCartao").focus();
    $("#cvvCartao").css("background", "#fbb67a")
    $("#cvvCartao").attr("placeholder", "CVV obrigatório");
    $("#cvvCartao").blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  Iugu.setAccountID(maratonaVirtual.pg_id);
  Iugu.setup();

  var nome = $("#nomeCartao").val();
  var number = $("#numeroCartao").val();
  var month = $("#mesAnoCartao").val().split("/")[0];
  var year = $("#mesAnoCartao").val().split("/")[1];
  var cvv = $("#cvvCartao").val();
  var parcelas = $("#parcelas").val();

  var sobrenome = "";
  try{
    var splitName = nome.split(' ');
    nome = splitName[0];
    sobrenome = splitName[splitName.length-1];
  }catch(e){}

  cc = Iugu.CreditCard(number, month, year, nome, sobrenome, cvv);
  
  Iugu.createPaymentToken(cc, function(data) {
    maratonaVirtual.load.off();
    if (data.errors) {

      $("#numeroCartao").focus();
      $("#numeroCartao").val("");
      $("#numeroCartao").css("background", "#fbb67a")
      $("#numeroCartao").attr("placeholder", "Cartão inválido, tente novamente");
      $("#numeroCartao").blur(function(){
        $(this).css("background", "#fff");
      });

    } else {
      promocao.token = data.id;
      promocao.showUpsell(pagina_id, function(){
        promocao.confirmarTransacao();
      });
    }
  });

}

promocao.addCarrinhoCheckBox = function(self){
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  if(self.checked){
    promocao.addCarrinho(self.value, self.id);
  }
  else{
    promocao.removeCarrinho(self.value);
  }
}

promocao.addCarrinho = function(idProduto, htmlId){
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  var adicionar = true;

  $(funil.carrinho).each(function(){
    if(this.id == idProduto){
      adicionar = false
    }
  });

  if(adicionar){
    funil.carrinho.push({id: idProduto, name: "id produto upsell", htmlId: htmlId});
    setCookie("funil", JSON.stringify(funil), 2)
  }
}

promocao.removeCarrinho = function(idProduto){
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  carrinho_novo = [];
  $(funil.carrinho).each(function(){
    if(this.id != idProduto){
      carrinho_novo.push(this);
    }
  });
  funil.carrinho = carrinho_novo;
  setCookie("funil", JSON.stringify(funil), 2);
}

promocao.checkSeCarrinho = function(self){
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  $(funil.carrinho).each(function(){
    $("#" + this.htmlId).prop( "checked", true );
  });
}

promocao.token = undefined;
promocao.confirmarTransacao = function(){
  maratonaVirtual.load.on();
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));

  data.usuario_id = funil.usuario_id
  data.pedido = {
    items: funil.carrinho
  }

  var url = maratonaVirtual.host + '/usuarios/' + data.usuario_id + '/comprar.json';
  $.ajax({
    type: 'POST',
    url: url,
    headers: {
      'MaratonaKeyAccess': maratonaVirtual.token,
      'Accept': 'application/json; charset=utf-8',
      'Content-Type': 'application/json; charset=utf-8'
    },
    data: JSON.stringify(data)
  }).done(function() { 
    maratonaVirtual.load.off();
    alert("pago");
    callback.call();
  }).fail(function(jqXHR, textStatus) {
    maratonaVirtual.load.off();
    alert("Não pago");
  });
}

promocao.callback = undefined;
promocao.paginaCorrenteId = undefined;
promocao.showUpsell = function(pagina_corrente_id, callback, idProximaPromocao){
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  promocao.callback = callback;
  promocao.paginaCorrenteId = pagina_corrente_id;

  $('html, body').animate({ scrollTop: 0 }, 100);

  var url = "/upsell/" + pagina_corrente_id;
  if(idProximaPromocao){
    url += "?idProximaPromocao=" + idProximaPromocao
  }

  $.ajax({
    type: 'GET',
    url: url
  }).done(function(html) { 
    maratonaVirtual.load.off();
    if(html != ""){

      var adicionado = false;
      var jsItemProximaId = $(html.match(/jsItemProximaId.*"/))[0].replace(/\"/g,"").replace(/jsItemProximaId.*?=/, "").trim();
      $(html.match(/jsItemProdutoId.*"/)).each(function(){
        if(!adicionado){
          var jsItemProdutoId = this.replace(/\"/g,"").replace(/jsItemProdutoId.*?=/, "").trim();
          $(funil.carrinho).each(function(){
            if(this.id == jsItemProdutoId){
              adicionado = true
            }
          });
        }
      })

      if(!adicionado){
        $(".jsUpsell").html(html);
        $(".jsUpsell").show();
        $(".jsUpsell").css("min-height", $(window).width() + "px");
      }
      else{
        if(parseInt(jsItemProximaId) > 0){
          promocao.showUpsell(promocao.paginaCorrenteId, promocao.callback, jsItemProximaId)
        }
        else{
          promocao.callback.call();
        }
      }
    }
    else{
      promocao.callback.call();
    }
  }).fail(function(jqXHR, textStatus) {
    promocao.callback.call();
  });
}

upsell = {};
upsell.selecionaItem = function(self){
  $(".jsItensPromocao .box-check").removeClass("border-selected")
  $(self).addClass("border-selected")
}

upsell.adicionar = function(idProximaPromocao){
  var idProduto = $(".jsItensPromocao .border-selected").parents(".jsItensPromocao").find(".jsItemProdutoId").val();
  promocao.addCarrinho(idProduto);

  if(parseInt(idProximaPromocao) > 0){
    promocao.showUpsell(promocao.paginaCorrenteId, promocao.callback, idProximaPromocao)
  }
  else{
    promocao.callback.call();
  }
}

upsell.naoAdicionar = function(idProximaPromocao){
  if(parseInt(idProximaPromocao) > 0){
    promocao.showUpsell(promocao.paginaCorrenteId, promocao.callback, idProximaPromocao)
  }
  else{
    promocao.callback.call();
  }
}

function setCookie(name,value,days) {
  var expires = "";
  if (days) {
    var date = new Date();
    date.setTime(date.getTime() + (days*24*60*60*1000));
    expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "")  + expires + "; path=/";
}

function getCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

function eraseCookie(name) {   
    document.cookie = name+'=; Max-Age=-99999999;';  
}

$(function(){
  promocao.checkSeCarrinho();
})