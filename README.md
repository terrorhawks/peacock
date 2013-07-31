# Peacock

Peacock is a Capistrano plugin for deploying using green blue
deployments to an AWS Elastic Load Balancer (ELB)

In the cloud, your web instances are forever changing. This Gem allows you to define in
your cap file that a host is using an ELB and it will detect the EC2 instances and deploy
your app to each of them.

## Installation

Add this line to your application's Gemfile:

    gem 'peacock'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install peacock

## Usage

In your `deploy.rb`

    require 'peacock/capistrano'

`peacock` requires your aws credentials, set them in your `deploy.rb`

    set :aws_access_key_id, 'YOUR_ACCESS_KEY_ID'
    set :aws_secret_access_key, 'YOUR_SECRET_ACCESS_KEY'
    set :hosted_zone, "YOUR ROOT DOMAIN'

Tell `peacock` that a host is using an ELB by specifying the
`staging_domain_name`
configuration in in your `deploy.rb`. The first argument is the host name followed
by a list of roles.

    elastic_load_balancer staging_domain_name(example.com), :app, :web

The host name is expected to be a CNAME for the ELB public DNS, as such a DNS looked is
performed against the host name.

By default the ELB is assumed to be in the AWS region `us-east-1`. You can use a
different region by setting the following in your `deploy.rb`

    set :aws_region, 'ap-southeast-2'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
