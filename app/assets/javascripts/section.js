$( document ).on('turbolinks:load', function() {
   $(".bidFormToggle").click(function(){
      $(".schedule_list").slideToggle(500);
      $(".sectionPlanForm").slideToggle(500);
      $(".buttonDisplay").toggle();
   });
});
