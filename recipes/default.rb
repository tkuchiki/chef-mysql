if node[:mysql][:version] == 5.5
  package "centos-release-SCL"

  client_package = "mysql55-mysql"
  dev_package    = "mysql55-mysql-devel"
  server_package = "mysql55-mysql-server"
  service_name   = "mysql55-mysqld"
elsif node[:mysql][:version] == 5.6
  repo_rpm = "http://repo.mysql.com/mysql-community-release-el%s.noarch.rpm" % node[:platform_version].gsub(".", "-")
  rpm      = "#{Chef::Config[:file_cache_path]}/mysql-community-release.noarch.rpm"

  remote_file rpm do
    source repo_rpm
  end

  rpm_package rpm do
    action :install

    not_if "rpm -q mysql-community-release"
  end

  file rpm do
    action :delete
  end

  client_package = "mysql-community-client"
  dev_package    = "mysql-community-devel"
  server_package = "mysql-community-server"
  service_name   = "mysqld"
end

if node[:mysql][:roles].include?("client")
  package client_package
end

if node[:mysql][:roles].include?("dev")
  package dev_package
end

if node[:mysql][:roles].include?("server")
  package server_package

  service service_name do
    action [:enable, :start]
  end
end

node[:mysql][:packages].each do |mysql_package|
  package mysql_package
end
