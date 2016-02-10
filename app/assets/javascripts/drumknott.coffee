class Drumknott
  constructor: (@name) ->

  embed: ->
    document.write """
<style>
#drumknott-search span, #drumknott-search input {
  float: left;
}
#drumknott-search span {
  min-width: 18%;
  display: inline-block;
  margin-bottom: 1em;
}
#drumknott-search input[type="text"] {
  width: 40%;
  font-size: 16px;
  line-height: 1.5;
}
#drumknott-search input[type="submit"] {
  width: 18%;
  margin-top: 0.3em;
  margin-left: 2%;
  font-size: 16px;
}
#drumknott-search .drumknott-next {
  max-width: 100%;
  min-width: 90%;
  display: inline-block;
  text-align: right;
}
.drumknott-pagination * {
  margin: 0 2px;
}
.drumknott-pagination a {
  text-decoration: none;
  color: rgba(0, 0, 0, 0.5);
}
.drumknott-pagination em {
  color: rgba(0, 0, 0, 0.9);
}
#drumknott-results {
  clear: left;
}
#drumknott-results li.drumknott-loading {
  font-style: italic;
}
</style>
<form id="drumknott-search" method="GET" action="/search">
  <span class="drumknott-pagination"><a href="#previous" class="drumknott-previous">&larr; Previous</a>&nbsp;</span>
  <input type="text" id="drumknott-query" value="query" />
  <input type="submit" value="Search" />
  <span class="drumknott-pagination">&nbsp;<a href="#next" class="drumknott-next">Next &rarr;</a></span>
</form>

<ul id="drumknott-results" class="drumknott-list"></ul>
    """

    @attach()

  attach: ->
    @uri        = new URI window.location.href
    @page       = parseInt(@uri.search(true).page || 1)
    @results    = $('#drumknott-results')
    @previous   = $('.drumknott-pagination .drumknott-previous')
    @next       = $('.drumknott-pagination .drumknott-next')

    @next.on     'click', @nextPage
    @previous.on 'click', @previousPage

    $('#drumknott-query').val(@uri.search(true).query);

    @previous.hide()
    @next.hide()

    $('#drumknott-search').on 'submit', =>
      @page = 1
      @updateState()
      @run()

      return false

    @run() if $('#drumknott-query').val().length > 0

  run: ->
    @results.empty().html('<li class="drumknott-loading">Loading...</li>');

    if $('#drumknott-query').val().trim().length > 0
      @search
        query: $('#drumknott-query').val(),
        page:  @page
      , @display
    else
      @results.empty()

  display: (data) =>
    @results.empty();

    for result in data.results
      $('#drumknott-results').append("<li class=\"drumknott-result\"><a href=\"#{result.path}\">#{result.name}</a></li>");

    @toggleElement @previous,   data.page  > 1
    @toggleElement @next,       data.page < data.pages

  nextPage: =>
    @page++;
    @updateState()
    @run()

    return false

  previousPage: =>
    @page--;
    @updateState()
    @run()

    return false

  toggleElement: (element, visible) ->
    if visible
      element.show()
    else
      element.hide()

  updateState: =>
    @uri.setSearch page: @page.toString(), query: $('#drumknott-query').val()

    history.pushState @uri.search(true), '', @uri.path() + @uri.search()

  search: (options = {}, success) ->
    $.get(
      "https://drumknottsearch.com/api/v1/#{@name}/pages", options
    ).done(success)

window.Drumknott = Drumknott
