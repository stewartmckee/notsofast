class NotsofastRailtie < Rails::Railtie
  initializer "notsofast_railtine.configure_rails_initialization" do |app|
    app.middleware.use Notsofast::RateLimit
  end
end