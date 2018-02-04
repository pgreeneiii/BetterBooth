module CoursesHelper
   def query_profs(course_id, quarter, query)
      if query.nil?
         Professor.joins(:courses, :schedules).where('courses.id = :course_id AND schedules.quarter = :quarter', {course_id: course_id, quarter: quarter}).distinct
      else
         if (query['schedules_day_eq'].empty?)
            Professor.joins(:courses, :schedules).where('courses.id = :course_id AND schedules.quarter = :quarter AND (first_name LIKE :name OR last_name LIKE :name)', {course_id: course_id, quarter: quarter, name: "%#{query['professors_first_name_or_professors_last_name_cont']}%"}).distinct
         else
            Professor.joins(:courses, :schedules).where('courses.id = :course_id AND schedules.quarter = :quarter AND (first_name LIKE :name OR last_name LIKE :name) AND schedules.day = :day', {course_id: course_id, quarter: quarter, name: "%#{query['professors_first_name_or_professors_last_name_cont']}%", day: query['schedules_day_eq']}).distinct
         end
      end
   end
end
