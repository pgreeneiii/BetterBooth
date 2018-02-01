$( document ).on('turbolinks:load', function() {
   $('div.rating').hide();
   $('div.bid').hide();

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
   $('.card #bid').click(function(){
      $(this).parents('div.card').find('div.schedule').hide();
      $(this).parents('div.card').find('div.rating').hide();
      $(this).parents('div.card').find('div.bid').show();
   });

   // On Clicking Add to Plan, show form to submit bid plan
   $(".toggle_plan.btn-link").click(function() {
      var sched_dom = $(this).parents('.schedule');
      console.log(sched_dom);
      $(sched_dom).find('.schedule_data').slideToggle(500);
      $(sched_dom).find('.plan_form').slideToggle(500);
   });

   $(".plan_submit").click(function() {
      var sched_dom = $(this).parents('.schedule');
      $(sched_dom).attr("id", "latest_plan");

      // console.log(sched_dom);
      // $(sched_dom).find('.plus_icon').html("<i class='fa fa-times fa-lg' aria-hidden='true'></i>");
      // $(button).after("Hi");
      // .html("<i class='fa fa-times fa-lg' aria-hidden='true'></i>");
      // $(sched_dom).find('.schedule_data').slideToggle(500);
      // $(sched_dom).find('.plan_form').slideToggle(500);
   });

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

   data = {};
   card_count = 0;
   $('.card').each(function(index) {
      var prof_id = $(this).find('select').val();
      var course_id = $(this).attr('data-course_id');
      data[index] = [prof_id, course_id];
      card_count++;
   });
   data.card_count = card_count;
   if (card_count > 0) {
      $.ajax({
         type: "GET",
         url: "/init_api",
         data: data,
         success: multi_alert,
         error: buttonError
      });
   };


   // $('.page-header').click(function(){
   //    // alert("Page Header clicked!");
   //    data = {};
   //    card_count = 0;
   //    $('.card').each(function(index) {
   //       var prof_id = $(this).find('select').val();
   //       var course_id = $(this).attr('data-course_id');
   //       data[index] = [prof_id, course_id];
   //       card_count++;
   //    });
   //    data.card_count = card_count;
   //    $.ajax({
   //       type: "GET",
   //       url: "/init_api",
   //       data: data,
   //       success: multi_alert,
   //       error: buttonError
   //    });
   // });


   $('select.prof_select').change(function() {
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


});

// ********************************************
// Main json function to build all card data
// ********************************************
var pushData = function (jsonData) {
   console.log(jsonData);
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
      noBids(section_dom);
   }

   if (jsonData.rating_status == 1) {
      var ratings = jsonData.ratings;
      buildRatings(ratings, section_dom);
   } else {
      noRatings(section_dom);
   }
   setLinks(jsonData.section_id, course_dom);
   // alert("Sent to setLinks");
};

// ********************************************
// Set's href links to go to section show view
// ********************************************
var setLinks = function (section_id, course_dom) {
   $(course_dom).find('h5#more a').attr('href', '/sections/' + section_id);
   // alert("Push Data complete");
};


// ********************************************
// Rating Display if no rating data
// ********************************************
var noRatings = function (section_dom) {
   // alert('No Ratings');
   $(section_dom).find('.rating .no-rating-data').show();
   $(section_dom).find('.rating .rating-data').hide();

};


// ********************************************
// Bid Display if no bid data
// ********************************************
var noBids = function (section_dom) {
   // alert('No Bids');
   $(section_dom).find('.bid .no-bid-data').show();
   $(section_dom).find('.bid .bid-data').hide();
};


// ********************************************
// Schedules Display
// ********************************************
var buildSchedules = function (course_number, schedules, course_sched_count, section_dom) {
   count = schedules.length;
   // var output = "";
   for (k = 0; k < course_sched_count; k++) {
      var this_section = 0;
      var schedule_div = $(section_dom).find('[data-schedule_count='+ k +']');
      for (j = 0; j < count; j++) {
         var sched_id = $(schedule_div).attr("data-schedule_id");
         console.log(schedules[j]);
         if (sched_id == schedules[j].id) {
            this_section = 1;
            $(schedule_div).removeClass("hidden");
            // $(schedule_div).show();
            title = "Course Number: " + course_number + "-" + schedules[j].section_number;
            $(schedule_div).find('.chip').attr("title", title);
            $(schedule_div).find('.chip-dot').text(schedules[j].day);
            $(schedule_div).find('.time-dot').text(schedules[j].time);

            if (schedules[j].plan == 0) {
               addPlanButton(schedule_div);
            } else {
               addDeletePlanButton(schedule_div, schedules[j].plan);
            };
         };
         if (this_section == 0) {
            $(schedule_div).addClass("hidden");
         };
      };
   };
};


var addPlanButton = function(schedule_div) {
   var addButton = "<i class='far fa-calendar-plus'></i>";
   $(schedule_div).find('.plan .toggle_plan').html(addButton);
};

var addDeletePlanButton = function(schedule_div, plan) {
   var deleteButton = "<div class='btn btn-link'><a href='/delete_plan/"+ plan + "'><i class='fas fa-times'></i></a></div>";
   $(schedule_div).find('.plan').html(deleteButton);
};


// ********************************************
// Bid Display
// ********************************************
var buildBids = function(bids, section_dom) {
   $(section_dom).find('.bid .no-bid-data').hide();
   $(section_dom).find('.bid .bid-data').show();
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
   $(section_dom).find('.rating .no-rating-data').hide();
   $(section_dom).find('.rating .rating-data').show();

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


// ********************************************
// Sets stars based on median scores provided
// ********************************************
var buildStars = function(score) {
   var output = "";

   for (stars = 0; stars < score; stars++) {
      output += "<i class='fas fa-star'></i>";
   };

   for (stars = 5; stars > score; stars--) {
      output += "<i class='far fa-star'></i>";
   };

   return (output);
};


// ********************************************
// Error function if AJAX fails
// ********************************************
var buttonError = function () {
   alert("There was an error making the ajax request!");
};

// $('.card').each(function() {
//    var prof_id = $(this).find('select').val();
//    var course_id = $(this).attr('data-course_id');
//    $.ajax({
//       type: "GET",
//       url: "/api",
//       data: {prof_id: prof_id, course_id: course_id},
//       success: pushData,
//       error: buttonError
//    });
// });


// ********************************************
// Initial page load of cards data
// ********************************************
var multi_alert = function(jsonData) {
   for (i = 0; i < jsonData.card_count; i++) {
      // alert("Index: " + i + " | Card Count: " + jsonData.card_count);
      string = "card_" + i;
      data = jsonData[string];
      pushData(data);
      // alert(string);
      console.log(i, string);
   };
   // alert("Exited For Loop");
};


// ********************************************
// AJAX Test for Success function
// ********************************************
var successAlert = function(jsonData) {
   var course_id = jsonData.card_0.course_id;
   alert(course_id);
};
