require 'spec_helper'

describe 'apt_mirror::mirror' do

  let :default_params do
    {
      :os         => 'ubuntu',
      :release    => ['precise'],
      :components => ['main', 'contrib', 'non-free'],
      :source     => 'true',
    }
  end

  context 'Mirror without http:// ' do
    mirror           = 'apt.puppetlabs.com'
    safe_name        = mirror.gsub(/[:\/\n]/, '_')
    safe_target_name = '/etc/apt/mirror.list'.gsub(/[\/\n]/, '_')
    concatdir        = '/var/lib/puppet/concat'
    fragdir          = "#{concatdir}/#{safe_target_name}"

    let(:title) { mirror }
    let :params do
      default_params.merge({
        :mirror => mirror
      })
    end

    it do
      should contain_concat__fragment(mirror).with({
        :target => '/etc/apt/mirror.list',
        :order   => '02',
      })
    end

    it do
      should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb http:\/\/#{mirror}/)
      should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-src http:\/\/#{mirror}/)
    end

  end

  context 'Mirror with http:// ' do
    mirror           = 'http://apt.puppetlabs.com'
    safe_name        = mirror.gsub(/[:\/\n]/, '_')
    safe_target_name = '/etc/apt/mirror.list'.gsub(/[\/\n]/, '_')
    concatdir        = '/var/lib/puppet/concat'
    fragdir          = "#{concatdir}/#{safe_target_name}"

    let(:title) { mirror }
    let :params do
      default_params.merge({
        :mirror => mirror
      })
    end

    it do
      should contain_concat__fragment(mirror).with({
        :target => '/etc/apt/mirror.list',
        :order   => '02',
      })
    end

    it do
      should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb #{mirror}/)
      should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-src #{mirror}/)
    end

  end

end
