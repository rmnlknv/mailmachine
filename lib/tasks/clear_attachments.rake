namespace :clear_attachments do
  path_to_folder = 'public/uploads/attachment/file'

  desc "Rename used attachment files"
  task :mark_files => :environment do
    attachments = Attachment.all
    attachments.each do |a|
      File.rename(a.file.path, a.file.path + '_rake_task_saved')
    end
  end

  desc "Delete all files without mark"
  task :delete_files => :environment do
    dirs = Dir.entries("#{Rails.root}/#{path_to_folder}").select {|entry| File.directory? File.join("#{Rails.root}/#{path_to_folder}",entry) and !(entry =='.' || entry == '..') }

    dirs.each do |dir|
      Dir.glob("#{Rails.root}/#{path_to_folder}/#{dir}/*") do |file|
        unless file.include? "_rake_task_saved"
          File.delete("#{file}")
          puts "Deleted: #{file}"
        end
      end
    end
  end

  desc "Remove all empty folders"
  task :delete_folders => :environment do
    Dir["#{Rails.root}/#{path_to_folder}/**/"].reverse_each { |d| Dir.rmdir d if Dir.entries(d).size == 2 }
  end

  desc "Rename marked files to origin names"
  task :origin_files => :environment do
    attachments = Attachment.all
    attachments.each do |a|
    File.rename(a.file.path + '_rake_task_saved', a.file.path)
    end
  end

  desc "Rake clear_attachments:all to execute whole procedure"
  task :all => [:mark_files, :delete_files, :delete_folders, :origin_files]
end
