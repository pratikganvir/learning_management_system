module FactoryHelpers
    extend self
    def add_classmate(student,batch)
      classmate = FactoryBot.create(:student, school_id: student.school_id)
      FactoryBot.create(:enrollment, student_id: student.id, batch_id: batch.id, status: 'approved')
      FactoryBot.create(:enrollment, student_id: classmate.id, batch_id: batch.id, status: 'approved')
    end
end