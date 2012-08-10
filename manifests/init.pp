# Class: cloudfuse
#
#   This module installs and configures the cloudfuse library so we can connect
#   to Rackspace Cloud Files.
#
#   Supports Hiera!
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-07-14
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
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

  $repo         = $cloudfuse::params::os_cloudfuse_repo,
  $source       = $cloudfuse::params::cloudfuse_source,
  $revision     = $cloudfuse::params::cloudfuse_revision,
  $dev_packages = $cloudfuse::params::os_dev_packages,
  $dev_ensure   = $cloudfuse::params::dev_ensure,

) inherits cloudfuse::params {

  include global

  #-----------------------------------------------------------------------------
  # Installation

  global::make { $repo:
    source       => $source,
    revision     => $revision,
    dev_packages => $dev_packages,
    dev_ensure   => $dev_ensure,
  }
}
