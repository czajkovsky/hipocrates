class Task
  require 'roo'

  def self.fetch_meds_from_excel
    ex = Roo::Excel.new("public/meds.xls")
    ex.default_sheet = ex.sheets[0]
    4.upto(10823) do |line|
      name = ex.cell(line,'B')
      form = ex.cell(line,'D')
      Med.create(name: name, form: form) if name.present? and form.present?
    end
  end

end
