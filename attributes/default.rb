default[:mysql] = {
  :version  => 5.7,
  :base_uri => "https://dev.mysql.com/get/mysql57-community-release-el%{platform_version}-7.noarch.rpm",
  :roles    => ["client", "server", "dev"],
  :packages => [],
  :use_scl  => false,
}

default[:mysql][:version_without_dot] = node[:mysql][:version].to_s.delete('.')

default[:mysql][:rpm_uri] = node[:mysql][:base_uri] % {
  :platform_version => node[:platform_version].to_i,
}
