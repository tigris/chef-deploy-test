::Chef::Recipe.send(:include, Helpers)

definition_test 'definition_test OUTSIDE of migrate works'
library_test 'library_test OUTSIDE of migrate works'

dir = '/tmp/chef-deploy-test'

directory "#{dir}/shared" do
  action :create
end

deploy dir do
  repo 'https://github.com/tigris/chef-test'
  symlinks Hash.new
  symlink_before_migrate Hash.new
  before_migrate do
    definition_test 'definition_test inside of migrate works'
    library_test 'library_test inside of migrate works'
  end
end
