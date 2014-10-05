## (unreleased)
* Add integration tests for environment/node recipes

## v0.2.3
* Use bag_format for node's config key

## v0.2.2
* Fix encrypted_data_bag_merge chef object inconsistency

## v0.2.1
* Change format to bag_format to not conflict with reserved definition attribute

## v0.2.0
* Change environment/node recipes to use default_override format by default
* Add fatal error if default_override format includes unexpected keys

## v0.1.4
* Add ability to change the format of the attributes to merge in

## v0.1.3
* Create new release to fix package gzipping.

## v0.1.2
* Fix issue with attribute names and data bag item keys
* Convert environment and node names to use only supported characters

## v0.1.1
* Fix documentation typos
* Correct encrypted_data_bag_merge definition to use node.default

## v0.1.0
* Added definitions and recipes for merging data bag items
