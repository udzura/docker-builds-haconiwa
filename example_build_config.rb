def gem_config(conf)
  # be sure to include this gem (the cli app)
  conf.gem File.expand_path(File.dirname(__FILE__))

  # Add your custom gems
  conf.gem github: 'matsumotory/mruby-uname'
  conf.gem github: 'matsumotory/mruby-localmemcache'
end

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.enable_bintest
  conf.enable_debug
  conf.enable_test

  gem_config(conf)
end

# Just build for Linux...
MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  toolchain :gcc

  conf.enable_debug

  gem_config(conf)
end

MRuby::Build.new('x86_64-pc-linux-gnu_mirb') do |conf|
  toolchain :gcc

  gem_config(conf)
  conf.gem core: 'mruby-bin-mirb'
  conf.bins = ["mirb"]
end
