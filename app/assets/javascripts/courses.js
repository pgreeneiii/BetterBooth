$( document ).on('turbolinks:load', function() {
   // Initial Set-up of view
   $('div.schedule').show();
   $('div.rating').hide();
   $('div.bid').hide();
   $('.chip').tooltip();
   $('.section').hide();

   // Show all first sections for each card
   $('.card').each(function(){
      $(this).find('div.section:first').show();
      var section_id = $(this).find('div.section:first').attr('id')
      $(this).find('#more a').attr('href', '/sections/' + section_id);
   })

   // Change which section data is shown based on professor selection
   $('select').change(function () {
      $(this).parents('div.card').find('div.section').hide();
      var prof_id = $(this).val();
      var section_id = $(this).parents('div.card').find('div.prof#' + prof_id).parent().attr('id');
      $('#' + section_id).show();
      $(this).parents('div.card').find('#more a').attr('href', '/sections/' + section_id);
   });

   // Show Schedule data when schedule is clicked
   $('.card').on('click', '#schedule', function () {
      $(this).parents('div.card').find('div.schedule').show();
      $(this).parents('div.card').find('div.rating').hide();
      $(this).parents('div.card').find('div.bid').hide();
   });

   // Show Rating data when rating is clicked
   $('.card').on('click', '#rating', function (){
      $(this).parents('div.card').find('div.schedule').hide();
      $(this).parents('div.card').find('div.rating').show();
      $(this).parents('div.card').find('div.bid').hide();
   });

   // Show Bid data when bid is clicked
   $('.card').on('click', '#bid', function (){
      $(this).parents('div.card').find('div.schedule').hide();
      $(this).parents('div.card').find('div.rating').hide();
      $(this).parents('div.card').find('div.bid').show();
   });
});
