if node[:mysql][:version] == 5.5
  dev_package    = "mysql55-mysql-devel"
elsif node[:mysql][:version] == 5.6
  dev_package    = "mysql-community-devel"
end

package dev_package
