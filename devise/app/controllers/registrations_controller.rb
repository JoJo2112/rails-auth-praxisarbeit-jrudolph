class RegistrationsController < Devise::RegistrationsController
  def create
    time = Benchmark.measure do
      super
    end
    Rails.logger.info("Benchmark für Benutzer-Login: #{time}")
  end
end
