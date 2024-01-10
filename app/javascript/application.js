// // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
//import "./controllers"

import "./src/jquery";

$(document).ready(function () {
  $(document).on("click", ".delete-user-button", function () {
    let user_id = $(this).data("user-id"); //lấy ở html data-user-id
    $.ajax({
      url: "users/destroy",
      type: "DELETE",
      data: { user_id_delete: user_id },
    });
  });

  $(document).on("click", ".delete-mic-button", function () {
    let mic_id = $(this).data("mic-id");

    $.ajax({
      url: "/microposts/destroy",
      type: "DELETE",
      data: { mic_id_delete: mic_id },
    });
  });

  $(document).on("click", ".unfollow", function () {
    let user_uf = $(this).data("user-id");

    $.ajax({
      url: "/relationships/destroy",
      type: "DELETE",
      data: { user_id: user_uf },
    });
  });

  $(document).on("click", ".delete-comment", function () {
    let comment_uf = $(this).data("comment-id");
    $.ajax({
      url: "/comments/" + comment_uf,
      type: "DELETE",
    });
  });

  $(document).on("click", ".delete-reply", function () {
    let reply_uf = $(this).data("reply-id");
    $.ajax({
      url: "/comments/" + reply_uf,
      type: "DELETE",
    });
  });

  $(document).on("submit", ".form-post", function (e) {
    e.preventDefault();
    let formData = new FormData(this);
    $.ajax({
      type: "POST",
      url: "/comments",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log(response);
      },
      error: function (error) {
        console.log(error);
      },
    });
  });

  $(document).on("submit", ".form-post-update", function (e) {
    let commentId = this.id.split("-")[3];
    e.preventDefault();
    let formData = new FormData(this);
    $.ajax({
      type: "PUT",
      url: "/comments/" + commentId,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        console.log(response);
      },
      error: function (error) {
        console.log(error);
      },
    });
  });

  $("#micropost_image").on("change", function () {
    const size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
      alert("Maximum file size is 5MB. Please choose a smaller file.");
      $("#micropost_image").val("");
    }
  });
});

$(document).ready(function () {
  function show(elementClass, elementIdPrefix, element) {
    $(document).on("click", elementClass, function () {
      let commentId = this.id.split("-")[1];
      let formToDisplay = $("#" + elementIdPrefix + commentId);

      if (formToDisplay.length) {
        $(element).hide();
        formToDisplay.show();
      }
    });
  }

  show(".feedback", "form-reply-", ".form-reply");
  show(".edit-reply", "form-comment-", ".form-reply-edit");
  show(".edit-comment", "form-comment-", ".form-edit");

  $(document).on("input", "textarea", function () {
    let commentId = this.id.split("-")[2];
    let submitButton = $("#button-comment-content-" + commentId);

    if ($(this).val() === "") {
      submitButton.hide();
    } else {
      submitButton.show();
    }
  });
});
