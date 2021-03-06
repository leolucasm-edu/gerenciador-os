// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require cocoon
//= require jquery_ujs
//= require jquery-mask
//= require bootstrap_sb_admin_base_v2
//= require turbolinks
//= require functions
//= require jquery/jquery.inputmask.bundle
//= require chartjs/Chart.min
//= require datepicker/bootstrap-datepicker
//= require datepicker/locales/bootstrap-datepicker.pt-BR
//= require timepicker/bootstrap-timepicker
//= require cocoon_callbacks
//= require select2
//= require select2_locale_pt-BR
//= require_tree .

function BuscaCliente(field, search_parameters, select2_options) {
  select2_options = select2_options || {};
  $.extend(search_parameters, { model: 'Cliente', campo: 'nome', texto: 'nome' });
  BuscaAjax(field, search_parameters, select2_options);
}

function BuscaProduto(field, search_parameters, select2_options) {
  select2_options = select2_options || {};
  $.extend(search_parameters, { model: 'Produto', campo: 'descricao', texto: 'descricao' });
  BuscaAjax(field, search_parameters, select2_options);
}

function BuscaServico(field, search_parameters, select2_options) {
  select2_options = select2_options || {};
  $.extend(search_parameters, { model: 'Servico', campo: 'descricao', texto: 'descricao' });
  BuscaAjax(field, search_parameters, select2_options);
}
