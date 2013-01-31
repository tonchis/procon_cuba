(function() {

  ko.bindingHandlers.executeOnEnter = {
    init: function(element, valueAccessor, allBindingsAccessor, viewModel) {
      var allBindings;
      allBindings = allBindingsAccessor();
      return $(element).keypress(function(event) {
        var keyCode;
        keyCode = (event.which ? event.which : event.keyCode);
        if (keyCode === 13) {
          allBindings.executeOnEnter.call(viewModel);
          return false;
        }
        return true;
      });
    }
  };

}).call(this);
