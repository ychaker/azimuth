default_run_options[:pty] = true
set :application, "azimuth"
set :repository, "git@github.com:railsrumble/team-o19s.git"

role :app, "ychaker@li47-74.members.linode.com"
role :web, "ychaker@li47-74.members.linode.com"
role :db, "ychaker@li47-74.members.linode.com", :primary => true

set :deploy_to, "/var/www/apps/#{application}"
set :scm, :git
set :branch, "railsrumble"

namespace :deploy do
	desc "restart passenger" 
	task :restart, :roles => :app, :except => {:no_release => true} do
		run "touch #{current_path}/tmp/restart.txt"
	end
	
	[:start, :stop].each do |t|
	  desc "#{t} task is a no-op with passenger"
	  task t, :roles => :app do ; end
  end
  
  task :after_symlink do
    %w[database.yml].each do |c|
      run "ln -nsf #{shared_path}/system/config/#{c} #{current_path}/config/#{c}"
    end
  end
end