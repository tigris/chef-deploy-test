This is a simple repo to demonstrate an issue I am seeing with deploy callbacks
not having access to the libraries

    $ cd /tmp
    $ git clone git@github.com:tigris/chef-deploy-test
    $ cd /tmp/chef-deploy-test
    $ sudo chef-solo -c solo.rb -j node.json

The output from running this is here:

    [2012-07-29T13:55:26+10:00] INFO: *** Chef 10.12.0 ***
    [2012-07-29T13:55:27+10:00] INFO: Setting the run_list to "recipe[main]" from JSON
    [2012-07-29T13:55:27+10:00] INFO: Run List is [recipe[main]]
    [2012-07-29T13:55:27+10:00] INFO: Run List expands to [main]
    [2012-07-29T13:55:27+10:00] INFO: Starting Chef Run for cushy.local
    [2012-07-29T13:55:27+10:00] INFO: Running start handlers
    [2012-07-29T13:55:27+10:00] INFO: Start handlers complete.
    [2012-07-29T13:55:27+10:00] INFO: ####################### definition_test OUTSIDE of migrate works
    [2012-07-29T13:55:27+10:00] INFO: ####################### library_test OUTSIDE of migrate works
    [2012-07-29T13:55:27+10:00] INFO: Processing directory[/tmp/chef-deploy-test/shared] action create (main::default line 8)
    [2012-07-29T13:55:27+10:00] INFO: Processing deploy[/tmp/chef-deploy-test] action deploy (main::default line 12)
    [2012-07-29T13:55:29+10:00] INFO: deploy[/tmp/chef-deploy-test] copied the cached checkout to /tmp/chef-deploy-test/releases/20120729035527
    [2012-07-29T13:55:29+10:00] INFO: deploy[/tmp/chef-deploy-test] running callback before_migrate
    [2012-07-29T13:55:29+10:00] INFO: ####################### definition_test inside of migrate works
    [2012-07-29T13:55:29+10:00] ERROR: deploy[/tmp/chef-deploy-test] (main::default line 12) has had an error
    [2012-07-29T13:55:29+10:00] ERROR: deploy[/tmp/chef-deploy-test] (/tmp/chef-test/chef/main/recipes/default.rb:12:in `from_file') had an error:
    deploy[/tmp/chef-deploy-test] (main::default line 12) had an error: NameError: Cannot find a resource for library_test on ubuntu version 12.04
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_platform_map.rb:126:in `get'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource.rb:667:in `resource_for_platform'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource.rb:684:in `resource_for_node'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/mixin/recipe_definition_dsl_core.rb:58:in `method_missing'
    /tmp/chef-test/chef/main/recipes/default.rb:18:in `from_file'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider.rb:75:in `instance_eval'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider.rb:75:in `recipe_eval'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider/deploy.rb:147:in `callback'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider/deploy.rb:124:in `deploy'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider/deploy.rb:74:in `action_deploy'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider/deploy.rb:382:in `with_rollback_on_error'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/provider/deploy.rb:73:in `action_deploy'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource.rb:454:in `send'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource.rb:454:in `run_action'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/runner.rb:49:in `run_action'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/runner.rb:85:in `converge'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/runner.rb:85:in `each'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/runner.rb:85:in `converge'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection.rb:94:in `execute_each_resource'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection/stepable_iterator.rb:116:in `call'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection/stepable_iterator.rb:116:in `call_iterator_block'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection/stepable_iterator.rb:85:in `step'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection/stepable_iterator.rb:104:in `iterate'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection/stepable_iterator.rb:55:in `each_with_index'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/resource_collection.rb:92:in `execute_each_resource'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/runner.rb:80:in `converge'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/client.rb:330:in `converge'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/client.rb:163:in `run'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/application/solo.rb:207:in `run_application'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/application/solo.rb:195:in `loop'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/application/solo.rb:195:in `run_application'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/../lib/chef/application.rb:70:in `run'
    /var/lib/gems/1.8/gems/chef-10.12.0/bin/chef-solo:25
    /usr/local/bin/chef-solo:19:in `load'
    /usr/local/bin/chef-solo:19
    [2012-07-29T13:55:29+10:00] ERROR: Running exception handlers
    [2012-07-29T13:55:29+10:00] ERROR: Exception handlers complete
    [2012-07-29T13:55:29+10:00] FATAL: Stacktrace dumped to /tmp/chef-test/cache/chef-stacktrace.out
    [2012-07-29T13:55:29+10:00] FATAL: NameError: deploy[/tmp/chef-deploy-test] (main::default line 12) had an error: NameError: Cannot find a resource for library_test on ubuntu version 12.04
    
