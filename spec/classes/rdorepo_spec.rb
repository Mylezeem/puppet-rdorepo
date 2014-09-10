require 'spec_helper'

describe 'rdorepo' do

  ['Fedora', 'RedHat', 'CentOS'].each do |operatingsystem|
    ['icehouse', 'havana'].each do |release|

    context "Operating System #{operatingsystem} / OpenStack Release #{release}" do

      case operatingsystem
      when 'Fedora'
        repo   = 'fedora'
        os_ver = '$releasever'
      when 'RedHat'
        repo   = 'epel'
        os_ver = '6'
      when 'CentOS'
        repo   = 'epel'
        os_ver = '7'
      end

      let :facts do {
        :operatingsystem => operatingsystem
      }
      end

      let :params do {
        :enabled => true,
        :release => release
      }
      end

      it {
        should contain_yumrepo("openstack-#{release}").with({
          'name'                => "OpenStack #{release} Repository",
          'baseurl'             => "http://repos.fedorapeople.org/repos/openstack/openstack-#{release}/#{repo}-#{os_ver}/",
          'gpgkey'              => "/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-#{release}",
          'gpgcheck'            => 1,
          'enabled'             => 1,
          'skip_if_unavailable' => 0,
          'priority'            => 98,
        })
      }

      end
    end

  end

end
