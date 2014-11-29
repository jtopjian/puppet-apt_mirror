require 'spec_helper'

describe 'apt_mirror::mirror' do

  let :default_params do
    {
      :os         => 'ubuntu',
      :release    => ['precise'],
      :components => ['main', 'contrib', 'non-free'],
      :source     => 'true',
      :alt_arch   => ['i386'],
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

    it {  should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb http:\/\/#{mirror}/) }
    it {  should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-src http:\/\/#{mirror}/) }
    it {  should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-i386 http:\/\/#{mirror}/) }

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

    it { should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb #{mirror}/) }
    it { should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-src #{mirror}/) }
    it { should contain_file("#{fragdir}/fragments/02_#{safe_name}").with_content(/deb-i386 #{mirror}/) }

  end

end
