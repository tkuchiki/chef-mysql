# chef-mysql
Chef cookbook for MySQL

# Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
`[:mysql][:version]` | MySQL version (Amazon Linux `5.1` `5.5` `5.6`, CentOS [567] `5.5` `5.6` `5.7`) | String or Float | `5.7`
`[:mysql][:version_without_dot]` | MySQL version (without dot) | String | `57`
`[:mysql][:base_uri]` | base RPM URI (for CentOS) | String | `https://dev.mysql.com/get/mysql57-community-release-el%{platform_version}-7.noarch.rpm`
`[:mysql][:rpm_uri]` | RPM URI (for CentOS) | String | CentOS 6 : `https://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm`
`[:mysql][:packages]` | yum packages | Array | []
`[:mysql][:use_scl]` | use centos-release-scl (for CentOS) | Boolean | false


# Example

## Attributes

```
{
  "mysql": {
    "packages": [
      "mysql-community-embedded"
    ],
    "version: 5.6
  }
}
```
