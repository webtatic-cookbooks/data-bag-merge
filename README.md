data-bag-merge Cookbook
=======================
This cookbook gives you the ability to store environment and node configuration
in data bags (including encrypted ones).

No cookbook would then need changing to support getting credentials from data bag,
as it will be able to read the merged attributes from the data bag.

Encrypting sensitive environment and node configuration is important, as you
shouldn't allow anyone to access this information, including VCS (Version control systems)

The encryption secret key can then be stored elsewhere, and data bags decrypted
by it at the point of chef converge.


Attributes
----------

#### data-bag-merge::environment
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['environments']['data_bag_name']</tt></td>
    <td>String</td>
    <td>Name of the data bag to fetch environment data from</td>
    <td><tt>environments</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['environments']['encrypted']</tt></td>
    <td>String</td>
    <td>Flag to determine whether to try to access as an encrypted data bag</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['environments']['bag_format']</tt></td>
    <td>String</td>
    <td>Option to change style of attributes (default/override/default_override)',</td>
    <td><tt>default_override</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['environments']['secret_path']</tt></td>
    <td>String</td>
    <td>Optional path to the secret file that decrypts the encrypted data bag, nil will use the path supplied in the chef config</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

#### data-bag-merge::node
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['nodes']['data_bag_name']</tt></td>
    <td>String</td>
    <td>Name of the data bag to fetch node data from</td>
    <td><tt>nodes</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['nodes']['encrypted']</tt></td>
    <td>String</td>
    <td>Flag to determine whether to try to access as an encrypted data bag</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['nodes']['bag_format']</tt></td>
    <td>String</td>
    <td>Option to change style of attributes (default/override/default_override)',</td>
    <td><tt>default_override</tt></td>
  </tr>
  <tr>
    <td><tt>['data-bag-merge']['nodes']['secret_path']</tt></td>
    <td>String</td>
    <td>Optional path to the secret file that decrypts the encrypted data bag, nil will use the path supplied in the chef config</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### data-bag-merge::environment

Include `data-bag-merge::environment` in your node's `run_list` at the very top
of the run-list and define the node's environment

Node

```json
{
  "name":"my_node",
  "environment": "production",
  "run_list": [
    "recipe[data-bag-merge::environment]"
  ],
  "item_with_normal": "normal value",
  "item_with_override": "normal value"
}
```

Encrypted Data Bag `environments/production`

```json
{
  "id": "production",
  "default_attributes": {
    "item_with_default": "default value",
    "item_with_normal": "default value"
  },
  "override_attributes": {
    "item_with_override": "override value"
  }
}
```

Result

```json
{
  "item_with_default": "default value",
  "item_with_normal": "normal value",
  "item_with_override": "override value"
}
```

This will access the data bag `environments/production`, merging it's data into
the node's defaults.

#### data-bag-merge::node

Include `data-bag-merge::node` in your node's `run_list` at the very top of the
run-list and define the node's environment

Node

```json
{
  "name":"my_node",
  "environment": "production",
  "run_list": [
    "recipe[data-bag-merge::node]"
  ],
  "item_with_normal": "normal value",
  "item_with_override": "normal value"
}
```

Encrypted Data Bag `nodes/my_node`

```json
{
  "id": "production",
  "default_attributes": {
    "item_with_default": "default value",
    "item_with_normal": "default value"
  },
  "override_attributes": {
    "item_with_override": "override value"
  }
}
```

Result

```json
{
  "item_with_default": "default value",
  "item_with_normal": "normal value",
  "item_with_override": "override value"
}
```

This will access the data bag `nodes/my_node`, merging it's data into the node's
defaults.

### definitions

Chef definitions are provided for additionally providing custom data bag merges

e.g.

```
data_bag_merge "my-custom-bag/my-bag-item"
```

```
encrypted_data_bag_merge "my-custom-bag/my-bag-item"
```

The following additional attributes are supported:

```
data_bag_merge "custom" do
  data_bag "my-custom-bag"        # The data bag to get the data from
  item 'my-bag-item'              # The data bag item to get the data from
  bag_format 'default'            # The format of the data
                                  # 'default' - merge all keys into node.default
                                  # 'override' - merge all keys into node.override
                                  # 'default_override' 
                                  #   - merge all keys in 'default_attributes'
                                  #     into node.default
                                  #   - merge all keys in 'override_attributes'
                                  #     into node.override
end
```

```
encrypted_data_bag_merge "custom" do
  data_bag "my-custom-bag"        # The data bag to get the data from
  item 'my-bag-item'              # The data bag item to get the data from
  secret_path nil                 # The path to the secret key.
                                  # nil - default chef encrypted_data_bag_key setting
  bag_format 'default'            # The format of the data
                                  # 'default' - merge all keys into node.default
                                  # 'override' - merge all keys into node.override
                                  # 'default_override' 
                                  #   - merge all keys in 'default_attributes'
                                  #     into node.default
                                  #   - merge all keys in 'override_attributes'
                                  #     into node.override
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT
Authors: Andy Thompson
