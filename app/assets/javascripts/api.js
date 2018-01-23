$( document ).on('turbolinks:load', function() {

   $('select').change(function() {
      $(this)
      alert('Success');
      $.ajax({
         type: "POST",
         url: "/api",
         success: pushData,
         error: buttonError
      });
   });

   var pushData = function (jsonData) {
      var section_id = jsonData.section_id;
      var section_dom = $('[data-section_id='+ section_id +']');

      var course_number = jsonData.course_number;
      var schedules = jsonData.schedules;
      buildSchedules(course_number, schedules, section_dom);

      var bids = jsonData.bids;
      buildBids(bids, section_dom);

      var ratings = jsonData.ratings;
      buildRatings(ratings, section_dom);
   };

   var buildSchedules = function (course_number, schedules, section_dom) {
      count = schedules.length;
      var output = "";
      for (i = 0; i < count; i++) {
         output += "<div class='row vertical-align'><div class='col-xs-9'><div class='chip' title='" + course_number +"-" + schedules[i].section_number + "'><div class='chip-dot'>" + schedules[i].day + "</div>" + schedules[i].time + "</div></div><div class='col-xs-3'><div class='plan'><div class='add_plan'><div class='btn btn-link'><i class='fa fa-plus-square-o fa-lg' aria-hidden='true'></i></div></div></div></div></div>";
      };

      var schedule_div = $(section_dom).find('.schedule');
      $(schedule_div).html(output);
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
      $(div_rating).find('p#comms').after(comms);
      $(div_rating).find('p#engaging').after(engaging);
      $(div_rating).find('p#practical').after(practical);
      $(div_rating).find('p#amt_learned').after(amt_learned);
      $(div_rating).find('p#recommend').after(recommend);
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


   var buttonSuccess = function (jsonData) {
      alert('Success');
      var output = "<div class=\"row\"><div class=\"name col-md-3\">" + jsonData.name + "</div><div class=\"age\">" + jsonData.age + "</div></div>";

      $('#api_row').after(output);
   };

   var buttonError = function () {
      alert("There was an error!");
   };
});

var buildCard = function(cardData) {

   var output1 = "<div class=\"col-md-4 mb-2\"><div class=\"card\"><div class=\"card-header\"><ul class=\"nav nav-tabs card-header-tabs\"><li class=\"nav-item\" id=\"schedule\"><a class=\"nav-link\" href=\"javascript:void(0);\"><i class=\"fa fa-calendar-o\" aria-hidden=\"true\"></i>Schedule</a></li><li class=\"nav-item\" id=\"rating\"><a class=\"nav-link\" href=\"javascript:void(0);\"><i class=\"fa fa-star\" aria-hidden=\"true\"></i>Ratings</a></li><li class=\"nav-item\" id=\"bid\"><a class=\"nav-link\" href=\"javascript:void(0);\"><i class=\"fa fa-btc\" aria-hidden=\"true\"></i>Bid Data</a></li></ul></div><div class=\"card-body\"><h5 class=";


   var output2 = "\"card-title\" id=\"more\"><a href=\"javascript:void(0);\">COURSE NAME</a></h5><div class=\"section\" id=\"" + cardData.section_id + "\"><div class=\"prof\"><div class=\"schedule list-group list-group-flush\">";

   var count = cardData.schedules.length;

   var schedule_output = [];
   var output3;

   for (i=0; i < count; i++) {
      schedule_output[i] = "<div class=\"row vertical-align\"><div class=\"col-xs-9\"><div class=\"chip\" title=\"Course Number: " + cardData.schedules[i].section_number + "\"><div class=\"chip-dot\">" + cardData.schedules[i].day + "</div>" + cardData.schedules[i].time + "</div><div class=\"plan_form\"></div></div></div>";
      output3 += schedule_output[i];
   };
   var output4 = "</div>";

   var finalOutput = output1+output2+output3+output4;

   $('#api_row').after(finalOutput);


};
