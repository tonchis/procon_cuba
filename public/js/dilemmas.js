(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.Dilemmas = (function() {

    function Dilemmas(attrs) {
      this.delete_dilemma = __bind(this.delete_dilemma, this);      this.dilemmas = ko.observableArray(DilemmasHelper.build_dilemmas(attrs));
      this.new_dilemma = ko.observable("");
    }

    Dilemmas.prototype.add_dilemma = function() {
      var _this = this;
      return $.ajax({
        dataType: "json",
        url: "/dilemmas",
        type: "POST",
        data: {
          name: this.new_dilemma()
        },
        success: function(data) {
          _this.dilemmas.push(new Dilemma(data));
          return _this.new_dilemma("");
        }
      });
    };

    Dilemmas.prototype.edit_dilemma = function(dilemma) {
      ko.applyBindings(dilemma, $("#edit-dilemma")[0]);
      $("#edit-dilemma").slideDown();
      $("#edit-dilemma ul").on("mouseenter", "li", DilemmasHelper.show_delete);
      $("#edit-dilemma ul").on("mouseleave", "li", DilemmasHelper.hide_delete);
      return $("#dilemmas").slideUp();
    };

    Dilemmas.prototype.delete_dilemma = function(dilemma) {
      var _this = this;
      return $.ajax({
        url: "/dilemmas/" + dilemma.id,
        type: "DELETE",
        success: function() {
          return _this.dilemmas.remove(dilemma);
        }
      });
    };

    return Dilemmas;

  })();

}).call(this);
