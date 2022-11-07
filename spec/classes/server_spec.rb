require 'spec_helper'

describe 'backuppc::server' do
  on_supported_os.each do |os, facts|
    let(:node) { 'testhost.test.com' }

    context "on #{os}" do
      let(:facts) { facts }
      let(:default_params) do
        case facts[:os]['family']
        when 'RedHat'
          { group_apache: 'apache',
            config_directory: '/etc/BackupPC',
            topdir: '/var/lib/BackupPC' }
        when 'Debian'
          { group_apache: 'www-data',
            config_directory: '/etc/backuppc',
            topdir: '/var/lib/backuppc',
            'preseed_file' => { '/var/cache/debconf/backuppc.seeds' => { 'ensure' => 'present' } } }
        end
      end

      context 'with OS defaults' do
        let(:default_params) do
          super().merge(backuppc_password: 'test_password')
        end
        let(:htpasswd_command) do
          "test -f #{default_params[:config_directory]}/htpasswd   || OPT='-c';htpasswd -bs ${OPT}   #{default_params[:config_directory]}/htpasswd backuppc 'test_password'"
        end

        context 'with defaults' do
          let(:params) { default_params }

          it { is_expected.to contain_class('backuppc::server') }
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('backuppc') }
          it do
            is_expected.to contain_file('config_directory').with(
              ensure: 'directory',
              group: default_params[:group_apache],
            )
          end
          it do
            is_expected.to contain_file('config.pl').with(
              ensure: 'present',
              group: default_params[:group_apache],
              mode: '0640',
            )
          end
          it { is_expected.to contain_file('pc_directory_symlink').with_ensure('link') }
          it { is_expected.to contain_service('backuppc').with_ensure(true) }
          it { is_expected.to contain_file('topdir').with_ensure('directory') }
          it { is_expected.to contain_file('topdir_ssh').with_ensure('directory') }
          it { is_expected.to contain_file('apache_config').with_ensure('present') }
          it { is_expected.to contain_backuppc__server__user('backuppc').with_password('test_password') }
          it { is_expected.to contain_exec(htpasswd_command).with_command(htpasswd_command) }

          it {
            is_expected.to contain_exec('backuppc-ssh-keygen').with_command(
              "ssh-keygen -f #{default_params[:topdir]}/.ssh/id_rsa -C 'BackupPC on #{node}' -N ''",
            )
          }

          case facts[:os]['family']
          when 'Debian'
            it { is_expected.to contain_file('/var/cache/debconf/backuppc.seeds').with_ensure('present') }
          end

          # Workaround for imported resourcses
          case facts[:os]['family']
          when 'RedHat'
            it { is_expected.to contain_file('/etc/backuppc').with_ensure('link') }
          when 'Debian'
            it { is_expected.to contain_file('/etc/BackupPC').with_ensure('link') }
          end
        end

        context 'config.pl content' do
          test_params = {
            'wakeup_schedule' => [1, 2, 3, 4],
            'max_backups' => 3,
            'max_user_backups' => 5,
            'language' => 'de',
            'max_pending_cmds' => 12,
            'max_backuppc_nightly_jobs' => 5,
            'backuppc_nightly_period' => 2,
            'pool_size_nightly_update_period' => 12,
            'ref_cnt_fsck' => 3,
            'pool_nightly_digest_check_percent' => 10,
            'max_old_log_files' => 7,
            'df_max_usage_pct' => 89,
            'df_max_inode_usage_pct' => 89,
            'trash_clean_sleep_sec' => 299,
            'cmd_queue_nice' => 1,
            'pool_v3_enabled' => false,
            'full_period' => 13.97,
            'full_keep_cnt' => [4, 2, 3],
            'full_age_max' => 89,
            'incr_period' => 0.57,
            'fill_cycle' => 10,
            'incr_keep_cnt' => 5,
            'incr_age_max' => 29,
            'restore_info_keep_cnt' => 11,
            'archive_info_keep_cnt' => 11,
            'blackout_good_cnt' => 5,
            'cgi_url' => 'http://localhost/backuppc/',
            'backup_zero_files_is_fatal' => false,
            'email_notify_min_days' => 2.1,
            'email_from_user_name' => 'backup_user',
            'email_admin_user_name' => 'backup_user',
            'email_user_dest_domain' => '@example.com',
            'email_notify_old_backup_days' => 11,
            'cgi_image_dir_url' => '/images',
            'cgi_admin_users' => 'backup',
            'cgi_admin_user_group' => 'backup',
            'cgi_date_format_mmdd' => 2,
            'user_cmd_check_status' => false,
            'ping_max_msec' => 4,
            'rsync_args_extra' => ['--testargs'],
            'rsync_full_args_extra' => ['--testfullargs'],
            'rsync_incr_args_extra' => ['--testincrargs'],
            'rsync_restore_args_extra' => ['--testrestoreargs'],
            'rsync_ssh_args' => ['--test', 'args'],
          }
          test_params.each do |tparam, tvalue|
            context "with #{tparam} = #{tvalue}" do
              let(:params) { default_params.merge(tparam => tvalue) }

              content = config_content(tparam, tvalue)
              it { is_expected.to contain_file('config.pl').with_content(content) }
            end
          end
        end

        test_params = {
          'apache_configuration' => false,
        }
        test_params.each do |tparam, tvalue|
          context "with #{tparam} = #{tvalue}" do
            let(:params) { default_params.merge(tparam => tvalue) }

            it { is_expected.not_to contain_file('apache_config') }
            it { is_expected.not_to contain_backuppc__server__user('backuppc') }
          end
        end
      end
    end
  end
end
