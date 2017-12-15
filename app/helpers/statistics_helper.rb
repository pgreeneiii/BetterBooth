module StatisticsHelper
   # def p1_price_by_year
   #   line_chart p1_price_by_year_charts_path, library: {
   #       title: {text: 'Phase 1 Price by year', x: -20},
   #       yAxis: {
   #           crosshair: true,
   #           title: {
   #               text: 'Bid Price'
   #           }
   #       },
   #       xAxis: {
   #           crosshair: true,
   #           title: {
   #               text: 'Year'
   #           }
   #       }
   #   }
   # end

   # Function to convert quarter_id into appropriate string value
   def convert_quarter(quarter)
      if quarter == 4
         return "Winter"
      elsif quarter == 1
         return "Spring"
      elsif quarter == 2
         return "Summer"
      elsif quarter == 3
         return "Fall"
      else
         return "Error"
      end
   end

   # Function to convert time_id into appropriate string value
   def convert_time(time)
      if time == 1
         return "Morning"
      elsif time == 2
         return "Afternoon"
      elsif time == 3
         return "Evening"
      else
         return "Other"
      end
   end
end
