namespace :update do
   namespace :stats do
      desc "Updates course statistics table with mean of ratings and bids for sorting purposes"
      task all: :environment do
         Course.all.each do |course|
            stat = Stat.new
            stat.quarter = 0
            save_check = 0

            if course.ratings.present?
               save_check += 1
               stat.course_id = course.id
               stat.ratings_count = course.ratings.count
               stat.hours = course.ratings.average(:avg_hours).to_f.round(2)
               stat.comms = course.ratings.average(:comms_mean).to_f.round(2)
               stat.engage = course.ratings.average(:engaging_mean).to_f.round(2)
               stat.practical = course.ratings.average(:practical_mean).to_f.round(2)
               stat.amt_learned = course.ratings.average(:amt_learned_mean).to_f.round(2)
               stat.recommend = course.ratings.average(:recommend_mean).to_f.round(2)
               stat.enrollment = course.ratings.average(:enrollment).to_f.round(0)
            end

            if course.bids.present?
               save_check += 1
               stat.bids_count = course.bids.count
               stat.p1 = course.bids.average(:p1_price).to_f.round(0)
               stat.p2 = course.bids.average(:p2_price).to_f.round(0)
               stat.p3 = course.bids.average(:p3_price).to_f.round(0)
               stat.p4 = course.bids.average(:p4_price).to_f.round(0)
            end

            if save_check > 0
               stat.save
            end
         end

         task spring: :environment do
            quarter = 3

            Course.all.each do |course|
               sections = Section.joins(:course, :schedules).where("courses.id = :id AND schedules.quarter = :quarter", {id: course.id, quarter: quarter}).joins(:ratings, :bids).distinct

               if sections.present?

                  stat = Stat.new
                  stat.quarter = quarter

                  stat.course_id = course.id

                  ratings_count = 0
                  bids_count = 0
                  sections.each do |section|
                     ratings_count += section.ratings.count
                     bids_count += section.bids.count
                  end

                  stat.ratings_count = ratings_count
                  stat.bids_count = bids_count

                  stat.hours = sections.average("ratings.avg_hours").to_f.round(2)
                  stat.comms = sections.average("ratings.comms_mean").to_f.round(2)
                  stat.engage = sections.average("ratings.engaging_mean").to_f.round(2)
                  stat.practical = sections.average("ratings.practical_mean").to_f.round(2)
                  stat.amt_learned = sections.average("ratings.amt_learned_mean").to_f.round(2)
                  stat.recommend = sections.average("ratings.recommend_mean").to_f.round(2)
                  stat.enrollment = sections.average("ratings.enrollment").to_f.round(0)


                  stat.p1 = sections.average("bids.p1_price").to_f.round(0)

                  stat.p2 = sections.average("bids.p2_price").to_f.round(0)

                  stat.p3 = sections.average("bids.p3_price").to_f.round(0)

                  stat.p4 = sections.average("bids.p4_price").to_f.round(0)

               if save_check > 0
                  stat.save
               end
            end
         end

      end
   end
end
