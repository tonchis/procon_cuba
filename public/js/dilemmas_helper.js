(function() {

  window.DilemmasHelper = (function() {

    function DilemmasHelper() {}

    DilemmasHelper.show_delete = function() {
      return $(this).find(".delete").show();
    };

    DilemmasHelper.hide_delete = function() {
      return $(this).find(".delete").hide();
    };

    DilemmasHelper.select_reasons = function(reasons, type) {
      var reason, reasons_type;
      reasons_type = [];
      return reasons_type = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = reasons.length; _i < _len; _i++) {
          reason = reasons[_i];
          if (reason.type === type) _results.push(reason);
        }
        return _results;
      })();
    };

    DilemmasHelper.stringify_array = function(objects) {
      var jsons, object;
      jsons = [];
      return jsons = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = objects.length; _i < _len; _i++) {
          object = objects[_i];
          _results.push(JSON.stringify(object));
        }
        return _results;
      })();
    };

    DilemmasHelper.delete_reason = function(reason, reasons) {
      return reasons.destroy(reason);
    };

    DilemmasHelper.build_dilemmas = function(attrs) {
      var dilemma_attrs, dilemmas;
      dilemmas = [];
      return dilemmas = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = attrs.length; _i < _len; _i++) {
          dilemma_attrs = attrs[_i];
          _results.push(new Dilemma(dilemma_attrs));
        }
        return _results;
      })();
    };

    return DilemmasHelper;

  })();

}).call(this);
