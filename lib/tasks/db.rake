namespace :db do

  desc "Dumps the database to db/backups/dump"
  task :dump => :environment do
    `pg_dump #{ENV['DATABASE_URL']} -f db/backups/dump`
    `rm #{Rails.root}/db/backups/dump` if SupportMailer.send_dump("#{Time.now.strftime("%Y%m%d%H%M%S")}_dump", Time.now.strftime("%d-%m-%Y")).deliver
  end

end