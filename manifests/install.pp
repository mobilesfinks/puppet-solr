# Class: solr::install
#
# This class installs solr
#
# == Variables
#
# Refer to solr class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly. It's automatically included by solr
#
class solr::install inherits solr {

  case $solr::install {

    package: {
      package { 'solr':
        ensure => $solr::manage_package,
        name   => $solr::package,
      }
    }

    source: {
      puppi::netinstall { 'netinstall_solr':
        url                 => $solr::install_source,
        destination_dir     => $solr::install_destination,
        extracted_dir       => $solr::install_destination,
        preextract_command  => $solr::install_precommand,
        postextract_command => $solr::install_postcommand,
      }
    }

    puppi: {
      puppi::project::archive { 'solr':
        source                   => $solr::install_source,
        deploy_root              => $solr::install_destination,
        predeploy_customcommand  => $solr::install_precommand,
        postdeploy_customcommand => $solr::install_postcommand,
        report_email             => 'root',
        auto_deploy              => true,
        enable                   => true,
      }
    }

  }

user { 'solr':
      name => $solr::user,
      comment => 'Solr system user',
      home    => $solr::install_destination,
      ensure  => present,
      #shell  => '/bin/bash',
      #uid    => '501',
      #gid    => '20'
    }

}
