$( document ).on('turbolinks:load', function() {
   $('div.rating').hide();
   $('div.bid').hide();
   // $('.card').click(function(){
   //    var prof_id = $(this).find('select').val();
   //    var course_id = $(this).attr('data-course_id');
   //    alert(prof_id);
   //    alert(course_id);
   //    $.ajax({
   //       type: "POST",
   //       url: "/api",
   //       data: {prof_id: prof_id, course_id: course_id},
   //       success: pushData,
   //       error: buttonError
   //    });
   // });




   $('select').change(function() {
      // alert('selectChanged!');
      var prof_id = $(this).val();
      var course_id = $(this).parents('.card').attr('data-course_id');

      $.ajax({
         type: "GET",
         url: "/api",
         data: {prof_id: prof_id, course_id: course_id},
         success: pushData,
         error: buttonError
      });
   });

   var pushData = function (jsonData) {
      // alert('pushData');
      $(this);
      var course_id = jsonData.course_id;
      var course_dom = $('[data-course_id=' + course_id + ']');
      var section_dom = $(course_dom).find('.section');

      var course_number = jsonData.course_number;
      var schedules = jsonData.schedules;
      var course_sched_count = jsonData.course_sched_count;
      buildSchedules(course_number, schedules, course_sched_count, section_dom);

      if (jsonData.bid_status == 1) {
         var bids = jsonData.bids;
         buildBids(bids, section_dom);
      } else {
         noBids();
      }

      if (jsonData.rating_status == 1) {
         var ratings = jsonData.ratings;
         buildRatings(ratings, section_dom);
      } else {
         noRatings();
      }
      setLinks(jsonData.section_id, course_dom);
   };

   var setLinks = function (section_id, course_dom) {
      $(course_dom).find('h5#more a').attr('href', '/sections/' + section_id);
   };

   var noRatings = function () {
      // alert('No Ratings');
   };

   var noBids = function () {
      // alert('No Bids');
   };

   var buildSchedules = function (course_number, schedules, course_sched_count, section_dom) {
      count = schedules.length;
      // var output = "";
      for (i = 0; i < count; i++) {
         var schedule_div = $(section_dom).find('[data-schedule_count='+ i +']');
         $(schedule_div).show();
         title = "Course Number: " + course_number + "-" + schedules[i].section_number;
         $(schedule_div).find('.chip').attr("title", title);
         $(schedule_div).find('.chip-dot').text(schedules[i].day);
         $(schedule_div).find('.time-dot').text(schedules[i].time);
         //
         // output += "<div class='row vertical-align'><div class='col-xs-9'><div class='chip' title='Course Number: " + course_number +"-" + schedules[i].section_number + "'><div class='chip-dot'>" + schedules[i].day + "</div>" + schedules[i].time + "</div></div><div class='col-xs-3'><div class='plan'><div class='add_plan'><div class='btn btn-link'><i class='fa fa-plus-square-o fa-lg' aria-hidden='true'></i></div></div></div></div></div>";
      };
      // var schedule_div = $(section_dom).find('.schedule');
      // $(schedule_div).html(output);
      for (i = course_sched_count; i >= count; i--) {
         $(section_dom).find('[data-schedule_count='+ i + ']').hide();
      };
   };

   var buildBids = function(bids, section_dom) {
      header = 'Latest Bids (' + bids.quarter + ' ' + bids.year + ')';
      var bid_div = $(section_dom).find('.bid');
      $(bid_div).find('th#qrt_year').text(header);

      var p1 = bids.p1_price;
      var p2 = bids.p2_price;
      var p3 = bids.p3_price;
      var p4 = bids.p4_price;

      if (p1 < 0) {
         p1 = "Closed";
      }

      if (p2 < 0) {
         p2 = "Closed";
      }

      if (p3 < 0) {
         p3 = "Closed";
      }

      if (p4 < 0) {
         p4 = "Closed";
      }

      $(bid_div).find('td#p1').text(p1);
      $(bid_div).find('td#p2').text(p2);
      $(bid_div).find('td#p3').text(p3);
      $(bid_div).find('td#p4').text(p4);
   };

   var buildRatings = function(ratings, section_dom) {
      var header = '<p>Latest Ratings Data (' + ratings.quarter + ' ' + ratings.year + ')</p>';
      var comms = buildStars(ratings.comms_median);
      var engaging = buildStars(ratings.engaging_median);
      var practical = buildStars(ratings.practical_median);
      var amt_learned = buildStars(ratings.amt_learned_median);
      var recommend = buildStars(ratings.recommend_median);
      var avg_hours = 'Avg. Hours: ' + ratings.avg_hours;

      var div_rating = $(section_dom).find('.rating');

      $(div_rating).find('div#rating_header').html(header);
      $(div_rating).find('#comms').html(comms);
      $(div_rating).find('#engaging').html(engaging);
      $(div_rating).find('#practical').html(practical);
      $(div_rating).find('#amt_learned').html(amt_learned);
      $(div_rating).find('#recommend').html(recommend);
      $(div_rating).find('strong#avg_hours').text(avg_hours);

   };

   var buildStars = function(score) {
      var output = "";

      for (i = 0; i < score; i++) {
         output += "<i class='fa fa-star' aria-hidden='true'></i>";
      };

      for (i = 5; i > score; i--) {
         output += "<i class='fa fa-star fa-star-o' aria-hidden='true'></i>";
      };

      return (output);
   };

   var buttonError = function () {
      // alert("There was an error making the ajax request!");
   };

   $('.card').each(function() {
      var prof_id = $(this).find('select').val();
      var course_id = $(this).attr('data-course_id');
      $.ajax({
         type: "GET",
         url: "/api",
         data: {prof_id: prof_id, course_id: course_id},
         success: pushData,
         error: buttonError
      });
   });
});
