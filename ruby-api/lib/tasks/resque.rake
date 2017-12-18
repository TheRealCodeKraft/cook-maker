require 'resque/tasks'
require 'resque/scheduler/tasks'
task 'resque:setup' => :environment
task 'resque:scheduler_setup' => :environment

task :schedule_and_work do
  if Process.fork
    sh "env VVERBOSE=1 TERM_CHILD=1 QUEUE=* bundle exec rake resque:work"
    #sh "rake environment resque:work"
  else
    sh "bundle exec rake resque:scheduler"
    Process.wait
  end
end
