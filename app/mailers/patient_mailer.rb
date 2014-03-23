class PatientMailer < ActionMailer::Base

  default from: "no-replay@#{SecretConfig.domain}/"

  def welcome_email(patient)
    @patient = patient
    mail(to: "#{patient.name} <#{patient.email}>", subject: 'Welcome to Hipocrates!')
  end

end
