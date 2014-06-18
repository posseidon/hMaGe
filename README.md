# Historical Map Geolocation Application

Using Ruby on Rails web-framework and MongoDB for storing information on maps.

# Dependencies

```ruby
gem 'mongoid'
gem 'bootstrap-generators'
gem 'kaminari'
gem 'openlayers-rails'
```

# Installation MongoDB

Current operating system is Ubuntu 14.04 LTS. Follow the following steps to install MongoDB:
```bash
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
$ echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
$ sudo apt-get update
$ sudo apt-get install mongodb-org
```

Reference to [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/) installation guide.

> **Start** Server: `sudo service mongod start`


> **Stop** Server:  `sudo service mongod stop`


> **Restart** Server: `sudo service mongod restart`


> Mongod **log**:   `/var/log/mongodb/mongod.log`

## Rails configuration
Running `rails generate mongoid:config` will generate the following file
+ config/mongoid.yml
Where the following parameters must be set:
