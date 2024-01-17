$(document).on("submit", ".form-mes-group", function (e) {
    e.preventDefault();
    let formData = new FormData(this);
    $.ajax({
      type: "POST",
      url: "/messages",
      data: formData,
      processData: false,
      contentType: false,
    });
  });

  $(document).on("submit", ".form-mes-update", function (e) {
    let mes_id = $(this).data("mes_id");
    e.preventDefault();
    let formData = new FormData(this);
    $.ajax({
      type: "PUT",
      url: "/messages/" + mes_id,
      data: formData,
      processData: false,
      contentType: false,
    });
  });

  $(document).on("submit", ".form-mes-user", function (e) {
    e.preventDefault();
    let formData = new FormData(this);
    $.ajax({
      type: "POST",
      url: "/messages" ,
      data: formData,
      processData: false,
      contentType: false,
    });
  });

  $(document).on("click", ".update_mes", function(e) {
    let mes_id = $(this).data("mes-id");
    let form_edit = $("#form_edit_mes_"+mes_id)
    if (form_edit) {
      $(".form_edit_mes").hide()
      form_edit.show()  
    }
  })

  $(document).on("click", ".delete_mes", function () {
    let mes_id = $(this).data("mes-id");
    $.ajax({
      url: "/messages/" + mes_id,
      type: "DELETE",
    });
  });
  
  var count = 0
  $(document).on("click", ".user-select", function(){
      if ($(this).prop('checked')) {
          count+=1
        $(".add-group").show()  
      }
      else {
          count-=1
          if(count <=0 ) {
            $(".add-group").hide()  
          }  
      }
  });

  $(document).on("click", ".add-group", function(){
    var room_id = $(this).data("group-id");
    var user_list = []
   $(".user-select").each(function(){
     if ($(this).prop('checked')) {
      user_list.push($(this).data("user-id"));
     }
   })
   $.ajax({
    url: '/conversations/add_user_to_group',
    type: "POST",
    data: {
      userId: user_list,
      room_id: room_id
     }
   })
  })

  $(document).on("click",".show-add-group",function (e) {
    var group  = $(this).data("show-id");
    $("#group-" + group).show();
});

 $(document).on("click",".close-add-group",function (e) {
  $(".group").hide();
 });
