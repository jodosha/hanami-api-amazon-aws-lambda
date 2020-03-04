# frozen_string_literal: true

require "rake"
require "rspec/core/rake_task"

namespace :spec do
  RSpec::Core::RakeTask.new(:all) do |task|
    file_list = FileList["spec/**/*_spec.rb"]

    task.pattern = file_list
  end

  RSpec::Core::RakeTask.new(:unit) do |task|
    file_list = FileList["spec/**/*_spec.rb"]
    file_list = file_list.exclude("spec/{integration,requests}/**/*_spec.rb")

    task.pattern = file_list
  end

  RSpec::Core::RakeTask.new(:requests) do |task|
    file_list = FileList["spec/**/*_spec.rb"]
    file_list = file_list.exclude("spec/{integration,unit}/**/*_spec.rb")

    task.pattern = file_list
  end
end

task default: "spec:all"
