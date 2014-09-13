if node[:mysql][:version] == 5.5
  server_package = "mysql55-mysql-server"
  service_name   = "mysql55-mysqld"
elsif node[:mysql][:version] == 5.6
  server_package = "mysql-community-server"
  service_name   = "mysqld"
end

package server_package

service service_name do
  action [:enable, :start]
end
