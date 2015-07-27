namespace :init do

  if defined?(Rails) && (Rails.env == 'development')
    Rails.logger = Logger.new(STDOUT)
  end

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

    atlaszok = MapGroup.find_by_identifier(1)
    budreg = MapGroup.find_by_identifier(2)
    egyeb = MapGroup.find_by_identifier(3)
    eotr10 = MapGroup.find_by_identifier(4)
    eotr= MapGroup.find_by_identifier(5)
    gauss = MapGroup.find_by_identifier(8)
    hazai = MapGroup.find_by_identifier(10)
    katonai1 = MapGroup.find_by_identifier(11)
    katonai2 = MapGroup.find_by_identifier(12)
    oszk = MapGroup.find_by_identifier(14)
    tanszek = MapGroup.find_by_identifier(15)
    vilag = MapGroup.find_by_identifier(16)
    mapgroups = {
      "1" => atlaszok,
      "2" => budreg,
      "3" => egyeb,
      "4" => eotr10,
      "5" => eotr10,
      "8" => gauss,
      "10" => hazai,
      "11" => katonai1,
      "12" => katonai2,
      "14" => oszk,
      "15" => tanszek,
      "16" => vilag
    }

    # Read CSV File
    CSV.foreach(args[:csv_file_path], :headers => true) do |row|
      image_path = "#{args[:images_folder_path]}/#{row['map_id']}.#{row['grformat']}"
      if File.file?(image_path)
        map = mapgroups[row['group_id']].maps.new
        puts map
        #map = Map.new
        config.each do |key, value|
          map[key.to_sym] = row[value]
        end
        map.downloadable = false
        map.path = image_path
        map.image = File.new(image_path)
        map.image.reprocess!
        map.save!
      else
        puts image_path
      end
    end
  end

end
