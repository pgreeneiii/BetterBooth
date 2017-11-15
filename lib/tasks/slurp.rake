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

end
