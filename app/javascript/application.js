// // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
 //import "./controllers"


   import "./src/jquery"

$('p').click(function() {
    $('h1').css('color', 'red') 
})
   
$(document).ready(function () {
   $('.delete-user-button').on('click', function(){ 
     var user_id = $(this).data('user-id') //lấy ở html data-user-id 
    
        $.ajax({
        url: 'users/destroy',
        type: 'DELETE',
        data: {user_id_delete: user_id}
           
        })

   })
  
  })
   
  