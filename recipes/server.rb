case node[:platform]
when "centos"
  if node[:mysql][:use_scl]
    service_name = "mysql55-mysqld"

    package "mysql55-mysql-server" do
      action :install
    end
  else
    service_name = "mysqld"

    disablerepo = (%W{5.5 5.6 5.7} - [node[:mysql][:version].to_s]).map{|ver| "mysql#{ver.delete('.')}-community"}.join(",")

    yum_package "mysql-community-server" do
      action  :install
      options "--enablerepo=mysql#{node[:mysql][:version_without_dot]}-community --disablerepo=#{disablerepo}"
    end
  end
when "amazon"
  service_name = "mysqld"

  package "mysql#{node[:mysql][:version_without_dot]}-server" do
    action :install
  end
end

file "/usr/my.cnf" do
  action :delete
end

template "/etc/my.cnf" do
  source "my#{node[:mysql][:version_without_dot]}.cnf.erb"
end

service service_name do
  action [:enable, :start]
end
