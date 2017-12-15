namespace :slurp do
  desc "Seeds Databases from CSV Files"
  task courses: :environment do
     require "csv"

     csv_text = File.read(Rails.root.join("lib", "csvs", "course.csv"))
     # puts csv_text
     csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
     csv.each do |row|
        t = Course.new
        t.course_number = row["number"]
        t.course_name = row["name"]
        t.save

        puts "#{t.course_number}, #{t.course_name} saved"
     end

     puts "There are now #{Course.count} rows in the transactions table"
  end

  task professors: :environment do
     require "csv"

     csv_text = File.read(Rails.root.join("lib", "csvs", "professor.csv"))
     # puts csv_text
     csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol, :encoding => 'ISO-8859-1')
     csv.each do |row|
        t = Professor.new
        t.first_name = row[:first]
        t.last_name = row[:last]
        t.email = row[:email]
        t.photo_url = row[:url]
        t.save

        puts "#{t.first_name}, #{t.last_name}, #{t.email}, #{t.photo_url} saved"
     end

     puts "There are now #{Professor.count} rows in the transactions table"
  end

  task schedules: :environment do
     require "csv"

     csv_text = File.read(Rails.root.join("lib", "csvs", "schedule.csv"))
     # puts csv_text
     csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol, :encoding => 'ISO-8859-1')
     csv.each do |row|
        t = Schedule.new
        t.section_id = row[:section_id]
        t.section_number = row[:section_number]
        t.quarter = row[:quarter]
        t.day = row[:day]
        t.time = row[:time]
        t.half_credit = row[:half_credit]
        t.save

        puts "#{t.section_id}, #{t.section_number}, #{t.quarter}, #{t.day}, #{t.time}, #{t.half_credit} saved"
     end

     puts "There are now #{Schedule.count} rows in the schedule table"
  end

  task bids: :environment do
     require "csv"

     csv_text = File.read(Rails.root.join("lib", "csvs", "bid.csv"))
     # puts csv_text
     csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol, :encoding => 'ISO-8859-1')
     csv.each do |row|
        t = Bid.new
        t.section_id = row[:section_id]
        t.quarter_id = row[:quarter_id]
        t.year = row[:year]
        t.day_id = row[:day_id]
        t.time_id = row[:time_id]
        t.p1_price = row[:p1_price]
        t.p2_price = row[:p2_price]
        t.p3_price = row[:p3_price]
        t.p4_price = row[:p4_price]
        t.new_student_p1_price = row[:new_students_p1_price]
        t.new_student_p2_price = row[:new_students_p2_price]
        t.save

        puts "#{t.section_id}, #{t.quarter_id}, #{t.year}, #{t.day_id}, #{t.time_id}, #{t.p1_price}, #{t.p2_price}, #{t.p3_price}, #{t.p4_price}, #{t.new_student_p1_price}, #{t.new_student_p2_price} saved"
     end

     puts "There are now #{Bid.count} rows in the bid table"
  end

  task ratings: :environment do
     require "csv"

     csv_text = File.read(Rails.root.join("lib", "csvs", "rating.csv"))
     # puts csv_text
     csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol, :encoding => 'ISO-8859-1')
     csv.each do |row|
        t = Rating.new
        t.section_id = row[:section_id]
        t.quarter_id = row[:quarter_id]
        t.year = row[:year]
        t.section_number = row[:section_number]
        t.responses = row[:responses]
        t.enrollment = row[:enrollment]
        t.avg_hours = row[:avg_hours]
        t.comms_mean = row[:comms_mean]
        t.engaging_mean = row[:engaging_mean]
        t.practical_mean = row[:practical_mean]
        t.amt_learned_mean = row[:amt_learned_mean]
        t.recommend_mean = row[:recommend_mean]
        t.comms_median = row[:comms_median]
        t.engaging_median = row[:engaging_median]
        t.practical_median = row[:practical_median]
        t.amt_learned_median = row[:amt_learned_median]
        t.recommend_median = row[:recommend_median]
        t.save
     end

     puts "There are now #{Rating.count} rows in the bid table"
  end

end
