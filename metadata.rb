name 'chef-attributes'
maintainer 'Rodel Manalo Talampas'
maintainer_email 'rodel.talampas@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures chef-attributes'
long_description 'Installs/Configures chef-attributes'
version '0.1.0'
chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'centos', '>= 7.2'
supports 'centos', '>= 16.04'
supports 'windows'

depends 'ohai', '>= 4.0.0'
depends 'rubygems', '~> 1.1.1'
depends 'build-essential', '~> 8.1.1'
