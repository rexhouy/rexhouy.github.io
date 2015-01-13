(function(window, $){

  var match = function(src, searchTxt) {
    return new RegExp(searchTxt).test(src);
  };

  var filter = function(searchTxt) {
    $("#list_group a").each(function(){
      var item = $(this);
      var content = item.find(".list-group-item-heading").html();
      if (match(content, searchTxt)) {
        item.show();
      } else {
        item.hide();
      }
    });
  };

  /**
   * Filter list by search text
   */
  $(function(){
    $("#search").keyup(function() {
      filter(this.value);
    });
  });
})(window, jQuery);
