class Task
  require 'roo'

  def self.fetch_meds_from_excel
    ex = Roo::Excel.new("public/meds.xls")
    ex.default_sheet = ex.sheets[0]
    4.upto(10823) do |line|
      name = ex.cell(line, 'B')
      form = ex.cell(line, 'D')
      Med.create(name: name, form: form) if name.present? and form.present?
    end
  end

  def self.fetch_recognitions_from_excel
    ex = Roo::Excel.new('public/recognitions.xls')
    ex.default_sheet = ex.sheets[1]
    2.upto(34342) do |line|
      icd10 = ex.cell(line, 'A')
      name = ex.cell(line, 'B')
      Recognition.create(icd10: icd10, name: name) if name.present? and icd10.present?
    end
  end

end
