# Historical Map Geolocation Application

Using Ruby on Rails web-framework and PostgreSQL with PostGIS extenstion for storing information on maps.

# Dependencies

```ruby
gem 'mongoid'
gem 'bootstrap-generators'
gem 'kaminari'
gem 'openlayers-rails'
```
# Database mapping
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

