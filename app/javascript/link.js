$(document).on('click', '.link', function(e) {
    e.preventDefault();
    var url = $(this).attr('href') 
    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'script',
      success: function(response) {
        history.pushState({}, "", url);
      },
    });
});
