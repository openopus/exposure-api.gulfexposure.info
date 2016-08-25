#= require active_admin/base
(($) ->
  $(document).ready ->
    $('.handle').closest('tbody').activeAdminSortable()
    return

  $.fn.activeAdminSortable = ->
    @sortable update: (event, ui) ->
      url = ui.item.find('[data-sort-url]').data('sort-url')
      $.ajax
        url: url
        type: 'post'
        data: position: ui.item.index() + 1
        success: ->
          window.location.reload()
          return
      return
    @disableSelection()
    return

  return
) jQuery
