

$( document ).on('turbolinks:load', function() {
   $('div.schedule').show();
   $('div.rating').hide();
   $('div.bid').hide();

   $('div.card').each(function(){
      var prof_id = this.select.value;
      var course_id = $(this).attr('id');
        $.ajax({
            url: '/fetch_schedules',
            data: { prof_id: prof_id, course_id: course_id },
        });
   })


   $('select').change(function () {
     var prof_id = this.value;
     var course_id = $(this).parents('div.card').attr('id');
        $.ajax({
            url: '/fetch_schedules',
            data: { prof_id: prof_id, course_id: course_id },
        });
    });

   $('.card').on('click', '#schedule', function () {
      $(this).parents('div.card').find('div.schedule').show();
      $(this).parents('div.card').find('div.rating').hide();
      $(this).parents('div.card').find('div.bid').hide();
   });

   $('.card').on('click', '#rating', function (){
      $(this).parents('div.card').find('div.schedule').hide();
      $(this).parents('div.card').find('div.rating').show();
      $(this).parents('div.card').find('div.bid').hide();
   });

   $('.card').on('click', '#bid', function (){
      $(this).parents('div.card').find('div.schedule').hide();
      $(this).parents('div.card').find('div.rating').hide();
      $(this).parents('div.card').find('div.bid').show();
   });


});
