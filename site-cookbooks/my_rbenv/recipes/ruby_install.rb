execute "rbenv install #{node['my_rbenv']['version']}" do
  command "/usr/local/rbenv/bin/rbenv install #{node['my_rbenv']['vesion']}"
  user node['my_rbenv']['user']
  group node['my_rbenv']['group']
  not_if { File.exsits?("/use/local/rbenv/versions/#{node['my_rbenv']['version']}")}
end

execute "rbenv global #{node['my_rbenv']['version']}" do
  command "/usr/local/rbenv/bin/rbenv global #{node['my_rbenv']['version']}"
  user node['my_rbenv']['user']
  group node['my_rbenv']['group']
end

%w{rbenv-rehash bundler}.each do |gem|
  execute "gem install #(gem)" do
    command "/usr/local/rbenv/shims/gem install #{gem}"
    user node['my_rbenv']['user']
    group node['my_rbenv']['group']
    not_if "/usr/local/rbenv/shims/gem list | grep #{gem}"
  end
end
