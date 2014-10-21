require 'spec_helper'

describe 'apt_mirror' do

  let :default_params do
    {
      :ensure                    => 'present',
      :enabled                   => 'true',
      :base_path                 => '/var/spool/apt-mirror',
      :mirror_path               => '/var/spool/apt-mirror/mirror',
      :var_path                  => '/var/spool/apt-mirror/var',
      :defaultarch               => 'amd64',
      :cleanscript               => '/var/spool/apt-mirror/var/clean.sh',
      :postmirror_script         => '/var/spool/apt-mirror/var/postmirror.sh',
      :run_postmirror            => 0,
      :nthreads                  => 20,
      :tilde                     => 0,
      :wget_limit_rate           => 'undef',
      :wget_auth_no_challenge    => 'false',
      :wget_no_check_certificate => 'false',
      :wget_unlink               => 'false',
    }
  end

  context "With default parameters" do
    let :params do
      default_params
    end

    it { should contain_package('apt-mirror') }

    it do
      should contain_concat('/etc/apt/mirror.list').with({
        :owner => 'root',
        :group => 'root',
        :mode  => '0644',
      })
    end

    it do
      should contain_concat__fragment('mirror.list header').with({
        :target  => '/etc/apt/mirror.list',
        :order   => '01',
      })
    end

    it do
      should contain_cron('apt-mirror').with({
        :ensure => 'present',
        :user   => 'root',
        :command => '/usr/bin/apt-mirror /etc/apt/mirror.list',
        :minute  => 0,
        :hour    => 4,
      })
    end

  end
end
