// // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
 //import "./controllers"


   import "./src/jquery"


   
$(document).ready(function () {
   $('.delete-user-button').on('click', function(){ 
     var user_id = $(this).data('user-id') //lấy ở html data-user-id 
    
        $.ajax({
        url: 'users/destroy',
        type: 'DELETE',
        data: {user_id_delete: user_id}
           
        })

   })

   $('.delete-mic-button').on('click', function(){ 
      var mic_id = $(this).data('mic-id') //lấy ở html data-user-id 

         $.ajax({
         url: '/microposts/destroy',
         type: 'DELETE',
         data: {mic_id_delete: mic_id}
            
         })
   
    })

    $('.unfollow').on('click', function(){ 
      var user_uf = $(this).data('user-id') //lấy ở html data-user-id 

         $.ajax({
         url: '/relationships/destroy',
         type: 'DELETE',
         data: {user_id: user_uf}   
         })
    })


    $('.delete-comment').on('click', function(){ 
      var comment_uf = $(this).data('comment-id') 

         $.ajax({
         url: '/comments/destroy',
         type: 'DELETE',
         data: {comment_id: comment_uf}   
         })
    })

    $('.delete-reply').on('click', function(){ 
      var reply_uf = $(this).data('reply-id') 

         $.ajax({
         url: '/replies/destroy',
         type: 'DELETE',
         data: {reply_id: reply_uf}   
         })
    })

    $("#micropost_image").on("change", function(){ 
      //Sự kiện change trong JavaScript xảy ra khi một giá trị của phần 
      //tử như form (tạo bởi thẻ input) hoặc menu lựa chọn (tạo bởi thẻ select) được thay đổi bởi thao tác của người dùng
       const size_in_megabytes = this.files[0].size/1024/1024 
       //this ở đây là thẻ input mà sự kiên change xảy ra
       //this.files[0] Truy cập vào danh sách các tệp được chọn thông qua phần tử input
       // 1024 / 1024: Chia kích thước của tệp cho 1024 hai lần để chuyển từ byte sang megabyte. Vì 1 megabyte bằng 1024 kilobyte, và 1 kilobyte bằng 1024 byte.
       if(size_in_megabytes > 5) {
         alert("Maximum file size is 5MB. Please choose a smaller file.");
         $("#micropost_image").val("");
       }

    })

  
  })


  function show(elementClass, elementIdPrefix, element) {
    document.addEventListener('DOMContentLoaded', function() {
      var feedbackButtons = document.querySelectorAll(elementClass);
      feedbackButtons.forEach(function(feedbackButton) {
        feedbackButton.addEventListener('click', function() {
          var commentId = this.id.split('-')[1];
  
          var formToDisplay = document.getElementById(elementIdPrefix + commentId);
          if (formToDisplay) {
            var allForms = document.querySelectorAll(element);
  
            allForms.forEach(function(form) {
              form.style.display = 'none';
            });
  
            formToDisplay.style.display = 'block';
          }
        });
      });
    });
  }
  
  show('.feedback', 'form-reply-', '.form-reply');
  show('.edit-reply', 'form-reply-edit-', '.form-reply-edit');
  show('.edit-comment', 'form-comment-', '.form-edit');
  