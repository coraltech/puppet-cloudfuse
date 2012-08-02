
class cloudfuse::default {
  $dev_ensure         = 'present'
  $cloudfuse_source   = 'git://github.com/redbo/cloudfuse.git'
  $cloudfuse_revision = 'master'
  $gid                = 0
  $umask              = 007
  $auth_url           = 'https://auth.api.rackspacecloud.com/v1.0'
  $cache_timeout      = '300'
  $cloud_user         = ''
  $cloud_api_key      = ''
  $container          = 'public'
}
