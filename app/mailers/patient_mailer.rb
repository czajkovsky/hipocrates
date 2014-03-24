class PatientMailer < ActionMailer::Base

  default from: "no-replay@#{SecretConfig.domain}/"

  def welcome_email(patient)
    @patient = patient
    mail(to: "#{patient.name} <#{patient.email}>", subject: 'Welcome to Hipocrates!')
  end

  def confirm_visit(visit)
    @visit = visit
    @patient = visit.patient
    mail(to: "#{visit.patient.name} <#{visit.patient.email}>", subject: 'Your visit status update')
  end

  def remind(visit)
    @visit = visit
    @patient = visit.patient
    mail(to: "#{visit.patient.name} <#{visit.patient.email}>", subject: 'Your visit reminder')
  end

end
