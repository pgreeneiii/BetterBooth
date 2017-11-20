$( document ).on('turbolinks:load', function() {
   $('div.schedule').show();
   $('div.rating').hide();
   $('div.bid').hide();
   $('.chip').tooltip();

   $('.section').hide();
   $('.card').each(function(){
      $(this).find('div.section:first').show();
   })

    $('select').change(function () {
     $(this).parents('div.card').find('div.section').hide();
     var prof_id = $(this).val();
     var section_id = $(this).parents('div.card').find('div.prof#' + prof_id).parent().attr('id');
     $('#' + section_id).show();

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
