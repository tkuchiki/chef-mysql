if node[:mysql][:version] == 5.5
  package "centos-release-SCL"

  client_package = "mysql55-mysql"
elsif node[:mysql][:version] == 5.6
  repo_rpm   = "http://repo.mysql.com/mysql-community-release-el%s.noarch.rpm" % [node[:platform_version].gsub(".", "-")]
  rpm        = "#{Chef::Config[:file_cache_path]}/#{File.basename(repo_rpm)}"
  is_install = "rpm -q mysql-community-release"

  remote_file rpm do
    source repo_rpm

    not_if is_install
  end

  rpm_package rpm do
    action :install

    not_if is_install
  end

  file rpm do
    action :delete
  end

  client_package = "mysql-community-client"
end

package client_package

node[:mysql][:packages].each do |mysql_package|
  package mysql_package
end
