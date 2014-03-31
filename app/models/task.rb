class Task
  require 'roo'

  def self.fetch_meds_from_excel
    ex = Roo::Excel.new("public/meds.xls")
    ex.default_sheet = ex.sheets[0]
    4.upto(10823) do |line|
      name = ex.cell(line, 'B')
      form = ex.cell(line, 'D')
      Med.create(name: name.downcase, form: form) if name.present? and form.present?
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

  def self.fetch_proceudres_from_excel
    ex = Roo::Excel.new('public/procedures.xls')
    ex.default_sheet = ex.sheets[0]
    2.upto(14568) do |line|
      icd9 = ex.cell(line, 'A')
      name = ex.cell(line, 'B')
      Procedure.create(icd9: icd9, name: name) if name.present? and icd9.present?
    end
  end

end
