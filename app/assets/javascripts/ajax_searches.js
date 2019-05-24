function BuscaAjax(field, search_parameters, select2_options) {
  var parameters = {
    pageLimit: 20
  }
  $.extend(parameters, search_parameters);

  var options = {
    placeholder: 'Selecione e digite para buscar',
    allowClear: true,
    minimumResultsForSearch: 0,
    minimumInputLength: 3,
    createSearchChoice: false,
    createSearchChoicePosition: 'bottom',
    ajax: {
      cache: true,
      delay: 600,
      quietMillis: 600,
      dataType: 'json',
      url: '/search/ajax_search.json',
      data: function(search) {
        return $.extend(parameters, {termo: search} );
      },
      results: function(data, page) {
        return {
          results: $.map(data, function(obj, i) {
            return { id: obj.id, text: obj[parameters.texto] };
          })
        };
      }
    },
    initSelection: function(element, callback) {
      var id = $(element).val();
      if (id) {
        $.ajax('/search/search_by_id.json', {
            data: { id: id, model: parameters.model },
            dataType: 'json'
          }).done(function(data) {
            callback({ id: data.id, text: data[parameters.texto] });
          });
      }
    }
  };

  $.extend(options, select2_options);
  field.select2(options);
}
