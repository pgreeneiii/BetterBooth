# usage:
# rake capture:sections:all => export all users to ./user.csv
# rake csv:users:range start=1757 offset=1957 => export users whose id are    between 1757 and 1957
# rake csv:users:last number=3   => export last 3 users
require 'csv'

namespace :capture do
   desc "TODO"

   namespace :sections do
      desc "export all sections to a csv file"
      task :all => :environment do
         export_to_csv Section.all
      end

      def export_to_csv(sections)
         CSV.open("./section.csv", "w") do |csv|
         csv << Section.attribute_names
            sections.each do |section|
               csv << section.attributes.values
            end
         end
      end
   end

   namespace :courses do
      desc "export all courses to a csv file"
      task :all => :environment do
         export_to_csv Course.all
      end

      def export_to_csv(courses)
         CSV.open("./course.csv", "w") do |csv|
         csv << Course.attribute_names
            courses.each do |course|
               csv << course.attributes.values
            end
         end
      end
   end

   namespace :professors do
      desc "export all professors to a csv file"
      task :all => :environment do
         export_to_csv Professor.all
      end

      def export_to_csv(professors)
         CSV.open("./professor.csv", "w") do |csv|
         csv << Professor.attribute_names
            professors.each do |professor|
               csv << professor.attributes.values
            end
         end
      end
   end

end
