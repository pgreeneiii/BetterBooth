$(document).on('turbolinks:load', function() {
   var carousels = $('.carousel');
   if (carousels.length > 0) {
      carousels.each(function(){
         $(this).attr("data-carousel_index", 0);
         $(this).find('.carousel-links .car-link').each(function(index){
            $(this).attr("data-link_index", index);
         });
         $(this).find('.carousel-item').each(function(index){
            $(this).attr("data-car_item_index", index);
            if (index > 0) {
               $(this).hide();
            };
         });
      });
   };

   $('.carousel .car-link').click(function(){
      // Initialize index variables
      var current = $(this).parents('.carousel').attr("data-carousel_index");
      var next = $(this).attr("data-link_index");

      if (current != next) {
         var currentCarouselItem = $(this).parents('.carousel').find(".carousel-item[data-car_item_index=" + current + "]");
         var nextCarouselItem = $(this).parents('.carousel').find(".carousel-item[data-car_item_index=" + next + "]");

         currentCarouselItem.hide(500);
         nextCarouselItem.show(500);

         $(this).parents('.carousel').attr("data-carousel_index", next);
      };
   });
});

// $('.carousel').click(function(){
//    var count = $(this).find(".carousel-item").length;
//    console.log(count);
//    var carousel_ids = buildArray(1, count);
//
//    var car_dex = $(this).attr("data-carousel_index");
//    console.log(car_dex);
//
//    $('#carousel_' + carousel_ids[car_dex]).slideToggle(1000);
//
//    var placeholder = (parseInt(car_dex) + 1);
//    if (placeholder == count) {
//       placeholder = 0
//    };
//
//    car_dex = placeholder.toString();
//
//    console.log(car_dex);
//    $('#carousel_' + carousel_ids[car_dex]).slideToggle(1000);
//    $(this).attr("data-carousel_index", car_dex);
// });
