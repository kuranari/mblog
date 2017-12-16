Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.template_engine false
  g.test_unit false
  g.test_framework :rspec, view_specs: false, helper_specs: false
end
