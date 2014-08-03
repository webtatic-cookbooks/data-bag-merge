name             'data-bag-merge'
maintainer       'Andy Thompson'
maintainer_email 'andy@webtatic.com'
license          'MIT'
description      'Installs/Configures data-bag-merge'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
recipe           'environment', 'Merge an environments databag based on chef environment'
recipe           'node', 'Merge a nodes databag based on chef node name'

attribute 'data-bag-merge',
  :display_name => 'data-bag-merge Hash',
  :description => 'Hash of data-bag-merge attributes',
  :type => 'hash'

attribute 'data-bag-merge/environments',
  :display_name => 'environments Hash',
  :description => 'Hash of environment recipe attributes',
  :type => 'hash'

attribute 'data-bag-merge/environments/data_bag_name',
  :display_name => 'Environments data bag name',
  :description => 'Name of the data bag to fetch environment data from',
  :default => 'environments'

attribute 'data-bag-merge/environments/encrypted',
  :display_name => 'Environments encrypted flag',
  :description => 'Flag to determine whether to try to access as an encrypted data bag',
  :default => 'true'

attribute 'data-bag-merge/environments/format',
  :display_name => 'Environments data bag format',
  :description => 'Option to change style of attributes (default/override/default_override)',
  :default => 'default'

attribute 'data-bag-merge/environments/secret_path',
  :display_name => 'Environments secret path',
  :description => 'Optional path to the secret file that decrypts the encrypted data bag, nil will use the path supplied in the chef config',
  :default => 'nil'

attribute 'data-bag-merge/nodes',
  :display_name => 'nodes Hash',
  :description => 'Hash of nodes recipe attributes',
  :type => 'hash'

attribute 'data-bag-merge/nodes/data_bag_name',
  :display_name => 'Nodes data bag name',
  :description => 'Name of the data bag to fetch node data from',
  :default => 'environments'

attribute 'data-bag-merge/nodes/encrypted',
  :display_name => 'Nodes encrypted flag',
  :description => 'Flag to determine whether to try to access as an encrypted data bag',
  :default => 'true'

attribute 'data-bag-merge/nodes/format',
  :display_name => 'Nodes data bag format',
  :description => 'Option to change style of attributes (default/override/default_override)',
  :default => 'default'

attribute 'data-bag-merge/nodes/secret_path',
  :display_name => 'Nodes secret path',
  :description => 'Optional path to the secret file that decrypts the encrypted data bag',
  :default => 'nil'
