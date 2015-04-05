class Drumknott
  constructor: (@name) ->
  search: (query, success) ->
    $.get(
      "http://drumknott.dev/api/v1/#{@name}/pages", query: query
    ).done(success)

window.Drumknott = Drumknott
