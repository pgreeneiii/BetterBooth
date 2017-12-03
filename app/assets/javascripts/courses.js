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

// $.ajax({
//   type:"GET",
//   url:"sections/data",
//   dataType:"json",
//   data: {section: @section},
//   success:function(result){
//     alert(result);
//   }
// })

function drawChart() {
      // Define the chart to be drawn.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Element');
      data.addColumn('number', 'Percentage');
      data.addRows([
        ['Nitrogen', 0.78],
        ['Oxygen', 0.21],
        ['Other', 0.01]
      ]);

      // Instantiate and draw the chart.
      var chart = new google.visualization.PieChart(document.getElementById('myPieChart'));
      chart.draw(data, null);
}

function drawSeriesChart() {

    var data = google.visualization.arrayToDataTable([
      ['ID', 'Life Expectancy', 'Fertility Rate', 'Region',     'Population'],
      ['CAN',    80.66,              1.67,      'North America',  33739900],
      ['DEU',    79.84,              1.36,      'Europe',         81902307],
      ['DNK',    78.6,               1.84,      'Europe',         5523095],
      ['EGY',    72.73,              2.78,      'Middle East',    79716203],
      ['GBR',    80.05,              2,         'Europe',         61801570],
      ['IRN',    72.49,              1.7,       'Middle East',    73137148],
      ['IRQ',    68.09,              4.77,      'Middle East',    31090763],
      ['ISR',    81.55,              2.96,      'Middle East',    7485600],
      ['RUS',    68.6,               1.54,      'Europe',         141850000],
      ['USA',    78.09,              2.05,      'North America',  307007000]
    ]);

    var options = {
      title: 'Correlation between life expectancy, fertility rate ' +
             'and population of some world countries (2010)',
      hAxis: {title: 'Life Expectancy'},
      vAxis: {title: 'Fertility Rate'},
      bubble: {textStyle: {fontSize: 11}}
    };

    var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));
    chart.draw(data, options);
}
