module ExamEvaluationsHelper

    def get_course_label(course_id)
        "#{Course.find(course_id).name} Marks"
    end
end
