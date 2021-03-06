// Generated by CoffeeScript 1.4.0
(function() {
  var Drumknott,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Drumknott = (function() {

    function Drumknott(name) {
      this.name = name;
      this.updateState = __bind(this.updateState, this);

      this.previousPage = __bind(this.previousPage, this);

      this.nextPage = __bind(this.nextPage, this);

      this.display = __bind(this.display, this);

    }

    Drumknott.prototype.embed = function() {
      document.write("<style>\n#drumknott-search span, #drumknott-search input {\n  float: left;\n}\n#drumknott-search span {\n  min-width: 18%;\n  display: inline-block;\n  margin-bottom: 1em;\n}\n#drumknott-search input[type=\"text\"] {\n  width: 40%;\n  font-size: 16px;\n  line-height: 1.5;\n}\n#drumknott-search input[type=\"submit\"] {\n  width: 18%;\n  margin-top: 0.3em;\n  margin-left: 2%;\n  font-size: 16px;\n}\n#drumknott-search .drumknott-next {\n  max-width: 100%;\n  min-width: 90%;\n  display: inline-block;\n  text-align: right;\n}\n.drumknott-pagination * {\n  margin: 0 2px;\n}\n.drumknott-pagination a {\n  text-decoration: none;\n  color: rgba(0, 0, 0, 0.5);\n}\n.drumknott-pagination em {\n  color: rgba(0, 0, 0, 0.9);\n}\n#drumknott-results {\n  clear: left;\n}\n#drumknott-results li.drumknott-loading {\n  font-style: italic;\n}\n</style>\n<form id=\"drumknott-search\" method=\"GET\" action=\"/search\">\n  <span class=\"drumknott-pagination\"><a href=\"#previous\" class=\"drumknott-previous\">&larr; Previous</a>&nbsp;</span>\n  <input type=\"text\" id=\"drumknott-query\" value=\"query\" />\n  <input type=\"submit\" value=\"Search\" />\n  <span class=\"drumknott-pagination\">&nbsp;<a href=\"#next\" class=\"drumknott-next\">Next &rarr;</a></span>\n</form>\n\n<ul id=\"drumknott-results\" class=\"drumknott-list\"></ul>");
      return this.attach();
    };

    Drumknott.prototype.attach = function() {
      var _this = this;
      this.uri = new URI(window.location.href);
      this.page = parseInt(this.uri.search(true).page || 1);
      this.results = $('#drumknott-results');
      this.previous = $('.drumknott-pagination .drumknott-previous');
      this.next = $('.drumknott-pagination .drumknott-next');
      this.next.on('click', this.nextPage);
      this.previous.on('click', this.previousPage);
      $('#drumknott-query').val(this.uri.search(true).query);
      this.previous.hide();
      this.next.hide();
      $('#drumknott-search').on('submit', function() {
        _this.page = 1;
        _this.updateState();
        _this.run();
        return false;
      });
      if ($('#drumknott-query').val().length > 0) {
        return this.run();
      }
    };

    Drumknott.prototype.run = function() {
      this.results.empty().html('<li class="drumknott-loading">Loading...</li>');
      if ($('#drumknott-query').val().trim().length > 0) {
        return this.search({
          query: $('#drumknott-query').val(),
          page: this.page
        }, this.display);
      } else {
        return this.results.empty();
      }
    };

    Drumknott.prototype.display = function(data) {
      var result, _i, _len, _ref;
      this.results.empty();
      _ref = data.results;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        result = _ref[_i];
        $('#drumknott-results').append("<li class=\"drumknott-result\"><a href=\"" + result.path + "\">" + result.name + "</a></li>");
      }
      this.toggleElement(this.previous, data.page > 1);
      return this.toggleElement(this.next, data.page < data.pages);
    };

    Drumknott.prototype.nextPage = function() {
      this.page++;
      this.updateState();
      this.run();
      return false;
    };

    Drumknott.prototype.previousPage = function() {
      this.page--;
      this.updateState();
      this.run();
      return false;
    };

    Drumknott.prototype.toggleElement = function(element, visible) {
      if (visible) {
        return element.show();
      } else {
        return element.hide();
      }
    };

    Drumknott.prototype.updateState = function() {
      this.uri.setSearch({
        page: this.page.toString(),
        query: $('#drumknott-query').val()
      });
      return history.pushState(this.uri.search(true), '', this.uri.path() + this.uri.search());
    };

    Drumknott.prototype.search = function(options, success) {
      if (options == null) {
        options = {};
      }
      return $.get("https://drumknottsearch.com/api/v1/" + this.name + "/pages", options).done(success);
    };

    return Drumknott;

  })();

  window.Drumknott = Drumknott;

}).call(this);
