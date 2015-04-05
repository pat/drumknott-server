class Drumknott
  constructor: (@name) ->
  search: (query, success) ->
    $.get(
      "http://drumknottsearch.com/api/v1/#{@name}/pages", query: query
    ).done(success)

window.Drumknott = Drumknott
