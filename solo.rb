path = '/tmp/chef-test'
cookbook_path ["#{path}/chef"]
file_cache_path "#{path}/cache"
file_backup_path "#{path}/backup"
checksums_path "#{path}/checksums"
sandbox_path "#{path}/backup"
cache_options :path => "#{path}/cache"
