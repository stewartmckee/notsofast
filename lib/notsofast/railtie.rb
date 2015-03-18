class NotsofastRailtie < Rails::Railtie
  initializer "notsofast_railtie.configure_rails_initialization" do |app|
    app.middleware.use Notsofast::RateLimit
  end
end