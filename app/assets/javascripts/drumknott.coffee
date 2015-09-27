class Drumknott
  constructor: (@name) ->
  search: (options = {}, success) ->
    $.get(
      "https://drumknottsearch.com/api/v1/#{@name}/pages", options
    ).done(success)

window.Drumknott = Drumknott
