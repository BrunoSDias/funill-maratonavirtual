var maratonaVirtual = {};
maratonaVirtual.host = 'https://admin-maratonavirtual.herokuapp.com/';
// maratonaVirtual.host = 'http://localhost:3001/';
maratonaVirtual.token = '79hrovrwibfxsrh_TglsoTy*b5sjcht9f5na*53Gmcfjg555Site';
maratonaVirtual.pg_id = "C49117ED8151463DB189BF82F7AECB67";

var promocao = {};
promocao.callback = undefined;
promocao.paginaCorrenteId = undefined;
promocao.produtoId = undefined;

maratonaVirtual.load = {
  on: function() {
    $("#modal-load").show();
  },
  off: function() {
    $("#modal-load").hide();
  }
}

maratonaVirtual.testaCPF = function(strCPF) {
  if(!strCPF) return true

  strCPF = strCPF.replace(/(\.)|(-)/g, '');
  if(11!=strCPF.length||"00000000000"==strCPF||"11111111111"==strCPF||"22222222222"==strCPF||"33333333333"==strCPF||"44444444444"==strCPF||"55555555555"==strCPF||"66666666666"==strCPF||"77777777777"==strCPF||"88888888888"==strCPF||"99999999999"==strCPF){
    return false;
  }

  var Soma;
  var Resto;
  Soma = 0;
  if (strCPF == "00000000000") return false;
     
  for (i=1; i<=9; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (11 - i);
  Resto = (Soma * 10) % 11;
   
  if ((Resto == 10) || (Resto == 11))  Resto = 0;
  if (Resto != parseInt(strCPF.substring(9, 10)) ) return false;
   
  Soma = 0;
  for (i = 1; i <= 10; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (12 - i);
  Resto = (Soma * 10) % 11;
 
  if ((Resto == 10) || (Resto == 11))  Resto = 0;
  if (Resto != parseInt(strCPF.substring(10, 11) ) ) return false;
  return true;
}

promocao.updateUsuario = function(usuario_id, field, step, event, fim, callback){
  event.preventDefault();

  if(!($("#" + field).val()) && $("#" + field).val() == ""){
    $("#" + field).focus();
    $("#" + field).attr("placeholder", field + " obrigatório");
    $("#" + field).css("background", "#fbb67a")
    $("#" + field).blur(function(){
      $(this).css("background", "#D8D8D8");
    });
    return;
  }

  usuario = {id: usuario_id}
  usuario[field] = $("#" + field).val();

  var url = maratonaVirtual.host + '/usuarios/busca-ou-cria.json';
  $.ajax({
    type: 'POST',
    url: url,
    headers: {
      'MaratonaKeyAccess': maratonaVirtual.token,
      'Accept': 'application/json; charset=utf-8',
      'Content-Type': 'application/json; charset=utf-8'
    },
    data: JSON.stringify({usuario: usuario})
  });

  $("#step" + field).hide();
  $("#" + step).show();
  if(fim){
    $("#stepFim").show();
  }
  else{
    $("#stepFim").hide();
  }

  $("#" + field).focus();

  if(callback){
    callback.call();
  }
}

promocao.carregarEndereco = function(cep){
  if(cep == ""){
    $("#cep").focus();
    $("#cep").attr("placeholder", "CEP obrigatório");
    $("#cep").css("background", "#fbb67a")
    $("#cep").blur(function(){
      $(this).css("background", "#D8D8D8");
    });
    return;
  }

  if($("#endereco").val() != ""){
    return;
  }

  maratonaVirtual.load.on();
  var url = maratonaVirtual.host + '/busca-cep/' + cep + ".json";
  $.ajax({
    type: 'get',
    url: url,
    headers: {
      'MaratonaKeyAccess': maratonaVirtual.token,
      'Accept': 'application/json; charset=utf-8',
      'Content-Type': 'application/json; charset=utf-8'
    }
  }).done(function(enderecoCorreios) { 
    maratonaVirtual.load.off();
    if(enderecoCorreios.tipoDeLogradouro){
      var endereco = (enderecoCorreios.tipoDeLogradouro + ' ' + enderecoCorreios.logradouro).trim() + ' - ' + enderecoCorreios.bairro;
      endereco = endereco.replace(/null/g,  "");

      $("#endereco").val(endereco);
      $("#cidade").val(enderecoCorreios.cidade);
      $("#estado").val(enderecoCorreios.estado);
    }
  }).fail(function(jqXHR, textStatus) { maratonaVirtual.load.off(); });
}

promocao.atualizar = function(self, pagina_id, produtoId){
  promocao.produtoId = produtoId;
  promocao.paginaCorrenteId = pagina_id;

  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  var usuario = JSON.parse(decodeURIComponent(getCookie("usuario")).replace(/\+\:/g, ":"));

  var cpf = $("#cpf");
  var cep = $("#cep");
  var endereco = $("#endereco");
  var numero = $("#numero");
  var cidade = $("#cidade");
  var estado = $("#estado");
  var senha = $("#senha");

  if(cpf.lenth > 0 && (!cpf.val() || cpf.val() == "")){
    cpf.focus();
    cpf.css("background", "#fbb67a")
    cpf.attr("placeholder", "CPF obrigatório");
    setTimeout(function(){ $("#cpf").val(""); }, 200);
    cpf.blur(function(){
      $(this).css("background", "#fff");
    });
    $("#stepcpf").show();
    return;
  }
  else if(cpf.lenth > 0 && !maratonaVirtual.testaCPF(cpf.val())){
    cpf.focus();
    setTimeout(function(){ $("#cpf").val(""); }, 200);
    cpf.css("background", "#fbb67a")
    cpf.attr("placeholder", "CPF inválido");
    cpf.blur(function(){
      $(this).css("background", "#fff");
    });
    $("#stepcpf").show();
    return;
  }

  if(senha.lenth > 0 && (!senha.val() || senha.val() == "")){
    senha.focus();
    senha.attr("placeholder", "Preencha a senha");
    senha.css("background", "#fbb67a")
    senha.blur(function(){
      $(this).css("background", "#fff");
    });
    $("#stepsenha").show();
    return;
  }

  if($("#cpf").val())
    usuario.cpf         = $("#cpf").val();
  if($("#nome").val())
    usuario.nome        = $("#nome").val();
  if($("#telefone").val())
    usuario.telefone    = $("#telefone").val();
  if($("#email").val()){
    if(IsEmail($("#email").val())){
      usuario.email       = $("#email").val();
    }
    else{
      $("#email").val("");
      $("#email").focus();
      $("#email").attr("placeholder", "E-mail inválido");
      $("#email").css("background", "#fbb67a")
      $("#email").blur(function(){
        $(this).css("background", "#fff");
      });

      $("#stepemail").show();
      return;
    }
  }

  if($("#senha").val())
    usuario.senha = $("#senha").val();

  maratonaVirtual.load.on();
  var url = maratonaVirtual.host + '/usuarios/busca-ou-cria.json';
  $.ajax({
    type: 'POST',
    url: url,
    headers: {
      'MaratonaKeyAccess': maratonaVirtual.token,
      'Accept': 'application/json; charset=utf-8',
      'Content-Type': 'application/json; charset=utf-8'
    },
    data: JSON.stringify({usuario: usuario})
  }).done(function(data) { 
    maratonaVirtual.load.off();
    var url = '/produtos/' + promocao.produtoId + '/paginas/' + promocao.paginaCorrenteId + '.json';
    $.ajax({
      type: 'GET',
      url: url,
    }).done(function(data) {
      if(!data.slug_produto || !data.slug_proxima){
        window.location.reload();
      }
      else{
        window.location.href = "/" + data.slug_produto + "/" + data.slug_proxima + "";
      }
    }).fail(function(jqXHR, textStatus) {
      window.location.reload();
    });
  }).fail(function(jqXHR, textStatus) {
    maratonaVirtual.load.off();
    var url = '/produtos/' + promocao.produtoId + '/paginas/' + promocao.paginaCorrenteId + '.json';
    $.ajax({
      type: 'GET',
      url: url,
    }).done(function(data) {
      if(!data.slug_produto || !data.slug_proxima){
        window.location.reload();
      }
      else{
        window.location.href = "/" + data.slug_produto + "/" + data.slug_proxima + "";
      }
    }).fail(function(jqXHR, textStatus) {
      window.location.reload();
    });;
  });    
}

promocao.gerarBoleto = function(self, pagina_id, produtoId){
  promocao.produtoId = produtoId;
  promocao.paginaCorrenteId = pagina_id;

  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));

  var cpf = $("#cpf");
  var cep = $("#cep");
  var endereco = $("#endereco");
  var numero = $("#numero");
  var cidade = $("#cidade");
  var estado = $("#estado");

  if(!cpf.val() || cpf.val() == ""){
    cpf.focus();
    cpf.css("background", "#fbb67a")
    cpf.attr("placeholder", "CPF obrigatório");
    setTimeout(function(){ $("#cpf").val(""); }, 200);
    cpf.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }
  else if(cpf.lenth > 0 && !maratonaVirtual.testaCPF(cpf.val())){
    cpf.focus();
    setTimeout(function(){ $("#cpf").val(""); }, 200);
    cpf.css("background", "#fbb67a")
    cpf.attr("placeholder", "CPF inválido");
    cpf.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!cep.val() || cep.val() == ""){
    cep.focus();
    cep.attr("placeholder", "CEP obrigatório");
    cep.css("background", "#fbb67a")
    cep.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!endereco.val() || endereco.val() == ""){
    endereco.focus();
    endereco.attr("placeholder", "Endereço obrigatório");
    endereco.css("background", "#fbb67a")
    endereco.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!numero.val() || numero.val() == ""){
    numero.focus();
    numero.attr("placeholder", "Número obrigatório");
    numero.css("background", "#fbb67a")
    numero.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!cidade.val() || cidade.val() == ""){
    cidade.focus();
    cidade.attr("placeholder", "Cidade obrigatório");
    cidade.css("background", "#fbb67a")
    cidade.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  if(!estado.val() || estado.val() == ""){
    estado.focus();
    estado.attr("placeholder", "Estado obrigatório");
    estado.css("background", "#fbb67a")
    estado.blur(function(){
      $(this).css("background", "#fff");
    });
    return;
  }

  promocao.showUpsell(pagina_id, function(){
    promocao.confirmarTransacao();
  });
}

promocao.btnCompra = undefined;
promocao.confirmarCompra = function(self, pagina_id, produtoId){
  promocao.btnCompra = self;
  promocao.produtoId = produtoId;
  promocao.paginaCorrenteId = pagina_id;

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


  $(promocao.btnCompra).data("texto", $(self).text());
  $(promocao.btnCompra).html("Carregando ...");
  $(promocao.btnCompra).attr("disabled", "disabled");

  Iugu.setAccountID(maratonaVirtual.pg_id);
  Iugu.setup();

  var nome = $("#nomeCartao").val();
  var number = $("#numeroCartao").val();
  var month = $("#mesAnoCartao").val().split("/")[0];
  var year = $("#mesAnoCartao").val().split("/")[1];
  var cvv = $("#cvvCartao").val();

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

      $(promocao.btnCompra).html($(promocao.btnCompra).data("texto"));
      $(promocao.btnCompra).removeAttr("disabled");

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

  var usuario = JSON.parse(decodeURIComponent(getCookie("usuario")).replace(/\+\:/g, ":"));
  var funil = JSON.parse(decodeURIComponent(getCookie("funil")).replace(/\+\:/g, ":"));
  
  if(funil.pagar_com_boleto){
    usuario.cpf         = $("#cpf").val();
    usuario.nome        = $("#nome").val();
    usuario.telefone    = $("#telefone").val();
    usuario.email       = $("#email").val();
    usuario.cep         = $("#cep").val();
    usuario.endereco    = $("#endereco").val();
    usuario.complemento = $("#complemento").val();
    usuario.numero      = $("#numero").val();
    usuario.cidade      = $("#cidade").val();
    usuario.estado      = $("#estado").val();
  }

  var data = {};
  if($("#parcelas").val()){
    data.months = $("#parcelas").val()
  }

  if(promocao.token){
    data.token = promocao.token
  }
  data.usuario = usuario
  data.pedido = {
    items: funil.carrinho
  }

  if(!data.usuario || !data.usuario.id){
    alert("Não foi possível concluir o pedido, por favor entre em contato no whatsapp +55 11 96433-5064, para concluir a sua compra");
    return;
  }

  var url = maratonaVirtual.host + '/usuarios/' + data.usuario.id + '/comprar.json';
  $.ajax({
    type: 'POST',
    url: url,
    headers: {
      'MaratonaKeyAccess': maratonaVirtual.token,
      'Accept': 'application/json; charset=utf-8',
      'Content-Type': 'application/json; charset=utf-8'
    },
    data: JSON.stringify(data)
  }).done(function(data) { 
    maratonaVirtual.load.off();

    setCookie("id_pedido", data.pedidos_efetuados[0].id, 2);

    var url = '/produtos/' + promocao.produtoId + '/paginas/' + promocao.paginaCorrenteId + '.json';
    $.ajax({
      type: 'GET',
      url: url,
    }).done(function(data) {
      if(!data.slug_produto || !data.slug_proxima){
        window.location.reload();
      }
      else{
        window.location.href = "/" + data.slug_produto + "/" + data.slug_proxima + "";
      }
    }).fail(function(jqXHR, textStatus) {
      window.location.reload();
    });;

  }).fail(function(jqXHR, textStatus) {
    maratonaVirtual.load.off();

    $(promocao.btnCompra).html($(promocao.btnCompra).data("texto"));
    $(promocao.btnCompra).removeAttr("disabled");

    var data = jqXHR.responseJSON;
    var mensagem = data.erro;
    if(!mensagem){
      mensagem = data.error
      if(!mensagem){
        if(data.pedidos_nao_efetuados && data.pedidos_nao_efetuados.length > 0){
          for(var i=0; i<data.pedidos_nao_efetuados.length; i++){
            var pedidos_nao_efetuados = data.pedidos_nao_efetuados[i];
            var mensagem = pedidos_nao_efetuados.erro;
            if(!mensagem){
              mensagem = pedidos_nao_efetuados.error
            }
            if(mensagem){
              mensagem += "<br>";
            }
          }
        }

        if(!mensagem){
          mensagem = JSON.stringify(data);
        }
      }
    }

    if(mensagem !== "Not Found"){
      alert('Confira: \n' + mensagem.replace(/<br>/g, "\n"));
    }
    else{
      alert(mensagem);
    }

  });
}

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
    if(html && html != ""){
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

function IsEmail(email) {
  var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(String(email).toLowerCase());
}

$(function(){
  promocao.checkSeCarrinho();
})