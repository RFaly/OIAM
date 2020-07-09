CarrierWave.configure do |config|
  carrierwave_gem = Bundler.rubygems.find_name('carrierwave').first
  I18n.load_path.prepend(File.join(carrierwave_gem.full_gem_path, 'lib', 'carrierwave', 'locale', "en.yml")) if carrierwave_gem.present?
end
