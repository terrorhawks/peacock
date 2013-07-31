require 'aws-sdk'
require 'net/dns'

Capistrano::Configuration.instance(:must_exist).load do

  def staging_domain_name(name, *args)

    packet = Net::DNS::Resolver.start(name)
    all_cnames= packet.answer.reject { |p| !p.instance_of? Net::DNS::RR::CNAME }
    cname_record = all_cnames.find { |c| c.name == "#{name}."}
    current_elb = cname_record.value
    fqdn = cname_record.name

    aws_region= fetch(:aws_region, 'us-east-1')
    AWS.config(:access_key_id => fetch(:aws_access_key_id),
               :secret_access_key => fetch(:aws_secret_access_key),
               :ec2_endpoint => "ec2.#{aws_region}.amazonaws.com",
    :elb_endpoint => "elasticloadbalancing.#{aws_region}.amazonaws.com")

    hosted_zone = fetch(:hosted_zone)

    @r53 = AWS::Route53.new

    zone = zone("#{hosted_zone}.")
    record_sets = record_sets(zone)

    staging_prod_ref = find_record(fqdn, record_sets) do |record|
      record[:resource_records].all? { |r| r[:value]!=current_elb } &&
        record[:type]=='CNAME'
    end

    raise "Weighting is not 0 for production staging, please adjust dns weighting to zero before deploying" if staging_prod_ref[:weight].to_i > 0

    staging_prod_record = find_record(staging_prod_ref[:set_identifier], record_sets) do |record|
      record[:type]=='CNAME'
    end

    set(:domain) { staging_prod_record[:name] }
  end

  private

  def zone(hosted_zone)
    zone = @r53.client.list_hosted_zones[:hosted_zones].find { |hosted_zones| hosted_zones[:zone].downcase==hosted_zone.downcase}
    raise "Could not find hosted zone ${hosted_zone.downcase}" if zone.nil?
    zone
  end

  def find_record(hosted_zone, record_sets, &filter)
    raise "filter required" unless block_given?
    staging_prod = record_sets.find do |record|
      record[:name] == hosted_zone && filter.call(record)
    end
    raise "Staging Prod resource record not found (weight = 0, name = #{hosted_zone}, elb must not be current production elb #{current_prod_elb}" if staging_prod.nil?
    staging_prod
  end

  def record_sets(zone)
    record_sets = @r53.client.list_resource_record_sets({:hosted_zone_id => zone[:id]})
    raise "Could not find record sets for zone id #{zone[:id]}" if record_sets.nil?
    record_sets[:resource_record_sets]
  end

end


