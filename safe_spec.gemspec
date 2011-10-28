Gem::Specification.new do |s|
  s.name = 'safe_spec'
  s.version = '0.1'
  s.date = '2011-10-25'

  s.summary = "Safer Rspec testing"
  s.description = "Raises NoMethodError if object does not respond to method when stubbing or setting expectations"

  s.authors = ["Jacob Richardson"]
  s.email = 'jacob.ninja.dev@gmail.com'

  s.require_paths = %w[lib]

  s.add_dependency('rspec')

  # = MANIFEST =
  s.files = %w[
    safe_spec.gemspec
    lib/safe_spec.rb
    lib/rspec_safe_spec_monkeypatch.rb
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
end
