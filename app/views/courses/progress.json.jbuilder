course_data  = Course.all.map{|c| {course_id: c.id, course: c.name,company: c.company.name}}


json.teacherColumns Teacher.is_active.map(&:id_and_name)
json.userColumns User.all.map(&:name)
json.columnSorting true
json.manualColumnResize true
json.currentRowClassName 'currentRow'
json.currentColClassName 'currentCol'
json.maxRows @periods.length

json.data do
  json.array! (@periods) do |p|
    json.id p.id
    json.course(p.course.name)
    json.company p.course.company.name
    json.day p.day
    json.teacher p.teacher.id_and_name
    json.responsible p.course.responsible
    json.observer p.user.name if p.user.present?
  end
end
