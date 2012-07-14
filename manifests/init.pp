# Class: cloudfuse
#
#   This module installs and configures the cloudfuse library so we can connect
#   to Rackspace Cloud Files.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-07-14
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#
# Actions:
#
#   Installs and configures the CloudFuse library.
#
# Requires:
#
# Sample Usage:
#
#   include cloudfuse
#
# [Remember: No empty lines between comments and class definition]
class cloudfuse (

  $libfuse_dev_version = $cloudfuse::params::libfuse_dev_version,
  $cloudfuse_source    = $cloudfuse::params::cloudfuse_source,
  $cloudfuse_revision  = $cloudfuse::params::cloudfuse_revision,

) inherits cloudfuse::params {

  $libfuse_dev_package = $cloudfuse::params::libfuse_dev_package

  $cloudfuse_repo      = $cloudfuse::params::cloudfuse_repo
  $test_cloudfuse_cmd  = "diff ${cloudfuse_repo}/.git/_COMMIT ${cloudfuse_repo}/.git/_COMMIT.last"

  #-----------------------------------------------------------------------------
  # Installation

  if ! $libfuse_dev_package or ! $libfuse_dev_version {
    fail('Cloudfuse package name and version must be defined')
  }
  package { 'libfuse-dev':
    name   => $libfuse_dev_package,
    ensure => $libfuse_dev_version,
  }

  git::repo { $cloudfuse_repo:
    source     => $cloudfuse_source,
    revision   => $cloudfuse_revision,
    require    => [ Class['git'], Package['libfuse-dev'] ],
  }

  Exec {
    cwd     => $cloudfuse_repo,
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  exec {
    'check-cloudfuse':
      command   => "git rev-parse HEAD > ${cloudfuse_repo}/.git/_COMMIT",
      require   => Class['git'],
      subscribe => Git::Repo[$cloudfuse_repo];

    'configure-cloudfuse':
      command   => './configure',
      unless    => $test_cloudfuse_cmd,
      subscribe => Exec['check-cloudfuse'];

    'make-cloudfuse':
      command   => 'make',
      unless    => $test_cloudfuse_cmd,
      subscribe => Exec['configure-cloudfuse'];

    'make-install-cloudfuse':
      command   => 'make install',
      unless    => $test_cloudfuse_cmd,
      subscribe => Exec['make-cloudfuse'];
  }

  file { "save-cloudfuse":
    path      => "${cloudfuse_repo}/.git/_COMMIT.last",
    source    => "${cloudfuse_repo}/.git/_COMMIT",
    subscribe => Exec['make-install-cloudfuse'],
  }

  #-----------------------------------------------------------------------------
  # Configuration


}
