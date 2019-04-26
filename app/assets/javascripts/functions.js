function formatCurrency(value) {
  return parseFloat(value, 10).toFixed(2).replace(/\./, ",").toString();
}

function DesabilitaCampos(obj, disabled) {
  $(obj).prop('disabled', disabled);
}

function CamposReadOnly(obj, readonly) {
  $(obj).prop('readonly', readonly);
}

function CliqueUnico(link) {
  link.one('click', function() {
    $(this).click( function () { return false; } );
    $(this).attr('disabled', 'disabled');
  });
}

function SubmitUnico(form) {
  form.one('submit', function() {
    $(this).find('input[type="submit"]').attr('disabled', 'disabled');
  });
}

function DesabilitarSubmit(form) {
  form.find('input[type="submit"]').attr('disabled', 'disabled');
}

function ReabilitarSubmit(form) {
  form.find('input[type="submit"]').removeAttr('disabled');
}

function ReabilitarSubmitTargetBlank(form) {
  setTimeout(function() { // Delay for Chrome
    ReabilitarSubmit(form);
  }, 200);
}

function add_tooltip_on_text_truncation(css_selector) {
  $(document).on('mouseenter', css_selector, function() {
    $this = $(this);
    if(this.offsetWidth < this.scrollWidth && !$this.attr('title')) {
      $this.prop("title", $this.text());
    }
  });
}

function AddAjaxLoader(div) {
  $(document).on({
    ajaxStart: function() {
      div.addClass("loading");
      DesabilitarSubmit( $("form") );
    },
    ajaxComplete: function() {
      div.removeClass("loading");
      ReabilitarSubmit( $("form") );
    }
  });
}

function Mask(oClass) {

  switch(oClass) {
    case '.date':
      $(oClass).datepicker({
        format: 'dd/mm/yyyy',
        language: 'pt-BR',
        autoclose: true,
        todayHighlight: true
      });
      $(oClass).inputmask(
        "dd/mm/yyyy",
        { placeholder: "__/__/____" }
      );
      break;
    case '.time':
      $(oClass).timepicker({
        showMeridian: false,
        defaultTime: false,
        showInputs: false,
      });
      $(oClass).inputmask("99:99");
      break;
    case '.currency':
      $('.currency').inputmask('decimal', {
        autoGroup: true,
        groupSeparator: "",
        groupSize: 3,
        radixPoint: ",",
        digits: 2,
        rightAlign: 0,
        //prefix: 'R$',
        digitsOptional: false,
        allowPlus: false,
        allowMinus: false,
        placeholder: '0',
      });
      break;
    case '.numeros':
      $(oClass).inputmask({
        'mask': '9',
        'greedy': 'false',
        'repeat': '*'
      });
      break;
    case '.numeros_letras':
      $(oClass).inputmask({
        'mask': '*',
        'greedy': 'false',
        'repeat': '*'
      });
      break;
    case '.phone':
      $(oClass).inputmask("(99) 9999[9]-9999");
      break;
    case '.cep':
      $(oClass).inputmask("99999-999");
      break;
    case '.cpf':
      $(oClass).inputmask("999.999.999-99");
      break;
    case '.cei':
      $(oClass).inputmask("99.999.99999/99");
      break;
    case '.cnpj':
      $(oClass).inputmask("99.999.999/9999-99");
      break;
    case '.pis':
      $(oClass).inputmask("999.9999.999-9");
      break;
    case '.nit':
      $(oClass).inputmask("999.99999.99-9");
      break;
    case '.cartao_credito':
      $(oClass).inputmask("9999-9999-9999-9999");
      break;  
  }

}

function DatePickerMonths(klass, options) {
  options = options || {}
  defaultOptions = {
    format: "mm/yyyy",
    language: "pt-BR",
    startView: 1,
    minViewMode: 1,
    maxViewMode: 2,
    clearBtn: true,
    multidate: true,
    multidateSeparator: ","
  }
  $.extend(defaultOptions, options);
  $(klass).datepicker(defaultOptions);

  // Conserta datas vindas do banco (para o 1º dia do mês)
  var arr = [];
  $.each( $(klass).datepicker("getDates"), function( index, value ){
    value.setDate(1);
    arr[index] = value;
  });
  $(".meses").datepicker("setDates", arr);
}
