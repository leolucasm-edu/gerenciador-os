jQuery(document).on 'turbolinks:load', ->
  telefones = $('#telefones')
  emails = $('#emails')

  telefones.on 'cocoon:after-insert', (e, added_el) ->
    added_el.find("input").first().focus();
    Mask(".phone");

  telefones.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 250)
    el_to_remove.fadeOut(250)

  emails.on 'cocoon:after-insert', (e, added_el) ->
    added_el.find("input").first().focus();

  emails.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 250)
    el_to_remove.fadeOut(250)
