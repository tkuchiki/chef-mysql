case node[:platform]
when "centos"
  if node[:mysql][:use_scl]
    package "centos-release-SCL"
    package "mysql55-mysql"
    package "mysql55-mysql-devel"
    package "mysql55-mysql-libs"

    node[:mysql][:packages].each do |pkg|
      package pkg
    end
  else
    rpm        = "#{Chef::Config[:file_cache_path]}/#{File.basename(node[:mysql][:rpm_uri])}"
    is_install = "rpm -q mysql#{node[:mysql][:version_without_dot]}-community-release"

    remote_file rpm do
      source node[:mysql][:rpm_uri]

      not_if is_install
    end

    rpm_package rpm do
      action :install

      not_if is_install
    end

    file rpm do
      action :delete
    end

    disablerepo = (%W{5.5 5.6 5.7} - [node[:mysql][:version].to_s]).map{|ver| "mysql#{ver.delete('.')}-community"}.join(",")

    (%W{mysql-community-client mysql-community-devel
       mysql-community-libs mysql-community-libs-compat
    } + node[:mysql][:packages]).each do |pkg|
      yum_package pkg do
        action  :install
        options "--enablerepo=mysql#{node[:mysql][:version_without_dot]}-community --disablerepo=#{disablerepo}"
      end
    end
  end
when "amazon"
  package "mysql#{node[:mysql][:version_without_dot]}"
  package "mysql#{node[:mysql][:version_without_dot]}-devel"
  package "mysql#{node[:mysql][:version_without_dot]}-libs"

  node[:mysql][:packages].each do |pkg|
    package pkg
  end
end
