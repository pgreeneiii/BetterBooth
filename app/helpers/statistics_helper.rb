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
   def convert_quarter(quarter)
      if quarter == 1
         return "Winter"
      elsif quarter == 2
         return "Spring"
      elsif quarter == 3
         return "Summer"
      elsif quarter == 4
         return "Fall"
      else
         return "Error"
      end
   end

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

   def check_closed(price)
      if price < 0
         return "Closed"
      else
         return price
      end
   end

   def prices_data
      p1_data = Hash.new
      p2_data = Hash.new
      p3_data = Hash.new
      p4_data = Hash.new

      @section.bids.order(year: :asc, quarter_id: :asc, time_id: :asc).each do |bid|
         time = convert_time(bid.time_id)
         quarter = convert_quarter(bid.quarter_id)
         year = bid.year.to_s
         time_quarter_year = time + " " + quarter + " " + year

         p1_data[time_quarter_year] = check_closed(bid.p1_price)
         p2_data[time_quarter_year] = check_closed(bid.p2_price)
         p3_data[time_quarter_year] = check_closed(bid.p3_price)
         p4_data[time_quarter_year] = check_closed(bid.p4_price)
      end

      charts = [{:name => "Phase 1", :data => p1_data}, {:name => "Phase 2", :data => p2_data}, {:name => "Phase 3", :data => p3_data}, {:name => "Phase 4", :data => p4_data}]

      return charts

   end

   def phase_1_data
      p1_data = Hash.new

      @section.bids.where(:year => 2017).order(quarter_id: :asc, time_id: :asc).each do |bid|
         time = convert_time(bid.time_id)
         quarter = convert_quarter(bid.quarter_id)

         p1_data[time] = check_closed(bid.p1_price)
         charts.push({:name => quarter, :data => {time => bid.p1_price}})
      end

      charts = [{:name => "Phase 1", :data => p1_data}, {:name => "Phase 2", :data => p2_data}, {:name => "Phase 3", :data => p3_data}, {:name => "Phase 4", :data => p4_data}]

      return charts

   end

end
