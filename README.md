## Historical Map Geolocation Application

Using Ruby on Rails web-framework and PostgreSQL with PostGIS extenstion for storing information on maps.

## Dependencies

```ruby
gem 'mongoid'
gem 'bootstrap-generators'
gem 'kaminari'
gem 'openlayers-rails'
```

## Configuration
Run the following command to make symlink with data directory to public directory
```ln -s /var/data/hmage/system/ /home/ntb/repos/ELTE/hmage/public/```


## Database mapping
```yaml
---
name: 'cim'
processed: 'feldolgozott'
kind: 'tipus'
size: 'méretarány'
resolution: 'felbontas'
publisher: 'kiado'
year: 'ev'
section: 'szelvenyszam'
theme: 'tema'
projection: 'vetuletirendszer'
gridding: 'fokhalo'
description: 'tartalmi_leiras'
creator: 'letrehozo'
participante: 'kozremukodo'
language: 'nyelv'
remarks: 'megjegyzes'
physical_size: 'fizikai_meret'
source: 'forras'
```

## SAMBA Server configuration

User 'grid' have been added.
```sh
adduser grid

smbpasswd -a grid
```

Set shared folder for user 
**grid**  is  */var/data/maps/*
by editing */etc/samba/smb.conf*

```sh
[grid]
comment = Maps data directory
path = /var/data/maps
valid users = grid
public = no
writable = yes
```

Set **[global]** configuration to allow access from department network only. (mapw, mapwd, grid)
```sh
[global]
hosts allow .....
```

## Application server configuration
Create user credentials file at /etc/samba/username. Then add the following lines:
```sh
username=samba_user
password=samba_user_password
```

Change the permissions on the file for security:
```sh
sudo chmod 0400 /etc/samba/user # permissions of 0400 = read only
```

Create shared folder at /var/data/terkeptar
```sh
mkdir -p /var/data/terkeptar
```

Now, using any editor, and add a line to /etc/fstab for your SMB share as follows:
```sh
sudo cp /etc/fstab /etc/fstab.bak
nano /etc/fstab
```

Add a line for your SMB share:
```sh
//myserver_ip_address/myshare  /media/samba_share  cifs  credentials=/etc/samba/username,noexec  0 0
```

Mount the share now, without rebooting:
```sh
sudo mount /var/data/terkeptar
```
