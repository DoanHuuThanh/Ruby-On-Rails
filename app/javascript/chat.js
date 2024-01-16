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
    let mes_id = this.id.split("-")[3];
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
    let mes_id = this.id.split("_")[2]
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
