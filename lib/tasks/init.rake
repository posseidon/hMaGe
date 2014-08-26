namespace :init do

  desc "Create thumbnail from original image"
  task :thumbnail, [:root_folder, :thumbnail_size] do |t, args|
    puts "TODO: Not implemented."
  end

  desc "Load Images from directory recursively into Map Model"
  task :images, [:root_folder] => :environment do |t, args|
    # Run with  rake init:load["/home/ntb/Downloads/source_images"]
    begin
      Dir["#{args[:root_folder]}/*"].map{|folder|
        Dir["#{folder}/*"].map{|file|
          if File.file?(file)
            map = Map.new(:name => '', :path => file)
            map.image = File.new(file)
            map.image.reprocess!
            map.save!
          end
          #else # Thumbnail folder
          #  Dir.glob("#{file}/*.gif") do |thumbnail_file|
          #    puts thumbnail_file
          #  end
          #end
        }
      }
    rescue Exception => e
      puts e
    end
  end

  desc "Load Data from CSV and YML configuration mapping file"
  task :maps, [:csv_file_path, :yml_file_path, :images_folder_path] => :environment do |t, args|
    # Run with  rake init:maps["/home/hmage/terkeptar_export.csv","/home/hmage/mapping.yml","/var/data/images_folder"]
    # rake init:maps["/home/ntb/Downloads/hMaGe/hmage.csv","/home/ntb/Downloads/hMaGe/hmage.yml","/home/ntb/Downloads/hMaGe/images"]
    require 'csv'
    require 'yaml'

    # Read YML File
    config = YAML::load(File.open(args[:yml_file_path]))

    # Read CSV File
    CSV.foreach(args[:csv_file_path], :headers => true) do |row|
      image_path = "#{args[:images_folder_path]}/#{row['File_nev']}"
      if File.file?(image_path)
        map = Map.new
        config.each do |key, value|
          map[key.to_sym] = row[value]
        end
        map.downloadable = false
        map.path = image_path
        map.image = File.new(image_path)
        map.image.reprocess!
        map.save!
      end
    end
  end

end
