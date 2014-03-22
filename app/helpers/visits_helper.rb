module VisitsHelper

  def doctors_collection
    User.by_role(:doctor).map{ |u| ["dr #{u.name} #{u.surname}", u.id.to_s, { data: { spec: u.specialities.map{ |s| s.id }.join(' ') } }] }
  end

end
