(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.Dilemma = (function() {

    function Dilemma(attrs) {
      this.delete_con = __bind(this.delete_con, this);
      this.delete_pro = __bind(this.delete_pro, this);
      var _this = this;
      if (attrs.reasons == null) attrs.reasons = [];
      this.id = attrs.id;
      this.name = ko.observable(attrs.name);
      this.pros = ko.observableArray(DilemmasHelper.select_reasons(attrs.reasons, "pro"));
      this.cons = ko.observableArray(DilemmasHelper.select_reasons(attrs.reasons, "con"));
      this.dilemma = ko.computed(function() {
        return {
          id: _this.id,
          name: _this.name(),
          reasons: $.merge(DilemmasHelper.stringify_array(_this.pros()), DilemmasHelper.stringify_array(_this.cons()))
        };
      });
      this.new_reason = ko.observable("");
    }

    Dilemma.prototype.add_pro = function() {
      this.pros.push({
        text: this.new_reason(),
        type: "pro"
      });
      return this.new_reason("");
    };

    Dilemma.prototype.add_con = function() {
      this.cons.push({
        text: this.new_reason(),
        type: "con"
      });
      return this.new_reason("");
    };

    Dilemma.prototype.add_both = function() {
      this.pros.push({
        text: this.new_reason(),
        type: "pro"
      });
      this.cons.push({
        text: this.new_reason(),
        type: "con"
      });
      return this.new_reason("");
    };

    Dilemma.prototype.delete_pro = function(pro) {
      return this.pros.remove(pro);
    };

    Dilemma.prototype.delete_con = function(con) {
      return this.cons.remove(con);
    };

    Dilemma.prototype.save_dilemma = function(dilemma) {
      return $.ajax({
        url: "/dilemmas/" + (this.dilemma().id),
        type: "PUT",
        data: this.dilemma(),
        success: function() {
          $("#dilemmas").slideDown();
          return $("#edit-dilemma").slideUp();
        }
      });
    };

    Dilemma.prototype.cancel_edit = function(dilemma) {
      $("#dilemmas").slideDown();
      return $("#edit-dilemma").slideUp();
    };

    return Dilemma;

  })();

}).call(this);
