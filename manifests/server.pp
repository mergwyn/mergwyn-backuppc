# @summary
#   Configures the backuppc server. 
#
# @param apache_allow_from
#   A space seperated list of hostnames, ip addresses and networks that are
#   permitted to access the backuppc interface.
#
# @param apache_configuration
#   Boolean. Whether to install the apache configuration file that creates an
#   alias for the /backuppc url.  Disable this if you intend to install backuppc
#   as a virtual host yourself.
#
# @param apache_require_ssl
#   This directive forbids access unless HTTP over SSL (i.e. HTTPS) is used.
#   Relies on mod_ssl.
#
# @param archive_info_keep_cnt
#   Number of archive logs to keep. BackupPC remembers information about each
#   archive request.  This number per archive client will be kept around before
#   the oldest ones are pruned.
#
# @param backup_zero_files_is_fatal
#   Boolean. A backup of a share that has zero files is considered fatal. This
#   is used to catch miscellaneous Xfer errors that result in no files being
#   backed up. If you have shares that might be empty (and therefore an empty
#   backup is valid) you should set this to false.
#
# @param pool_v3_enabled
#   If a V3 pool exists (ie: an upgrade) set this to 1.  This causes the
#   V3 pool to be checked for matches if there are no matches in the V4
#    pool.
#   For new installations, this should be set to 0.
#
# @param backuppc_nightly_period
#   How many days (runs) it takes BackupPC_nightly to traverse the entire
#   pool. Normally this is 1, which means every night it runs, it does
#   traverse the entire pool removing unused pool files.
#
# @param pool_size_nightly_update_period
#   Sets how many nights it takes to completely update the V4 pool size.
#
# @param pool_nightly_digest_check_percent
#   Integrity check the pool files by confirming the md5 digest of the
#   contents matches their file name.  Because the pool is very large,
#   only check a small random percentage of the pool files each night.
#
# @param backuppc_password
#   Password for the backuppc user used to access the web interface.
#
# @param blackout_good_cnt
#   PCs that are always or often on the network can be backed up after hours, to
#   reduce PC, network and server load during working hours. For each PC a count
#   of consecutive good pings is maintained. Once a PC has at least
#   $Conf{BlackoutGoodCnt} consecutive good pings it is subject to "blackout"
#   and not backed up during hours and days specified by $Conf{BlackoutPeriods}.
#
# @param blackout_periods
#   Periods in which backups do not take place.
#
# @param cgi_admin_users
# @param cgi_admin_user_group
#   The administrative users are the union of the unix/linux
#   group $Conf{CgiAdminUserGroup} and the manual list of users,
#   separated by spaces, in $Conf{CgiAdminUsers}.
#   If you don't want a group or manual list of users set the
#   corresponding configuration setting to undef or an empty string.
#
# @param cgi_date_format_mmdd
#   Date display format for CGI interface. A value of 1 uses US-style dates
#   (MM/DD), a value of 2 uses full YYYY-MM-DD format, and zero for
#   international dates (DD/MM).
#
# @param cgi_image_dir_url
#   URL (without the leading http://host) for BackupPC's image directory.
#   The CGI script uses this value to serve up image files.
#   Example:
#       $Conf{CgiImageDirURL} = '/BackupPC';
#
# @param cgi_url
#    URL of the BackupPC_Admin CGI script. Used for email messages.
#
# @param df_max_usage_pct
#   Maximum threshold for disk utilization on the __TOPDIR__ filesystem. If the
#   output from $Conf{DfPath} reports a percentage larger than this number then
#   no new regularly scheduled backups will be run. However, user requested
#   backups (which are usually incremental and tend to be small) are still
#   performed, independent of disk usage. Also, currently running backups will
#   not be terminated when the disk usage exceeds this number.
#
# @param email_admin_user_name
#   Destination address to an administrative user who will receive a nightly
#   email with warnings and errors.
#
# @param email_from_user_name
#   Name to use as the "from" name for email.
#
# @param email_headers
#   Additional email headers.
#
# @param email_notify_min_days
#   Minimum period between consecutive emails to a single user. This tries to
#   keep annoying email to users to a reasonable level.
#
# @param email_notify_old_backup_days
#   How old the most recent backup has to be before notifying user. When there
#   have been no backups in this number of days the user is sent an email.
#
# @param ensure
#   Present or absent
#
# @param full_age_max
#   Very old full backups are removed after $Conf{FullAgeMax} days. However, we
#   keep at least $Conf{FullKeepCntMin} full backups no matter how old they are.
#
# @param full_keep_cnt
#   Number of full backups to keep.
#
# @param full_period
#   Minimum period in days between full backups. A full dump will only be done
#   if at least this much time has elapsed since the last full dump, and at
#   least $Conf{IncrPeriod} days has elapsed since the last successful dump.
#
# @param incr_age_max
#   Very old incremental backups are removed after $Conf{IncrAgeMax} days.
#   However, we keep at least $Conf{IncrKeepCntMin} incremental backups no
#   matter how old they are.
#
# @param incr_fill
#   Boolean. Whether incremental backups are filled. "Filling" means that the
#   most recent fulli (or filled) dump is merged into the new incremental dump
#   using hardlinks. This makes an incremental dump look like a full dump.
#
# @param incr_keep_cnt
#   Number of incremental backups to keep.
#
# @param incr_levels
#   A full backup has level 0. A new incremental of level N will backup all files
#   that have changed since the most recent backup of a lower level.
#
# @param incr_period
#   Minimum period in days between incremental backups (a user requested
#   incremental backup will be done anytime on demand).
#
# @param language
#   Language to use. See lib/BackupPC/Lang for the list of
#   supported languages, which include English (en), French (fr),
#   Spanish (es), German (de), Italian (it), Dutch (nl), Polish (pl),
#   Portuguese Brazillian (pt_br) and Chinese (zh_CH).
#   cz, de, en, es, fr, it, nl, pl, pt_br, zh_CN
#
#   Currently the Language setting applies to the CGI interface and email
#   messages sent to users. Log files and other text are still in English.
#
# @param max_backuppc_nightly_jobs
#   How many BackupPC_nightly processes to run in parallel. Each night,
#   at the first wakeup listed in $Conf{WakeupSchedule}, BackupPC_nightly
#   is run. Its job is to remove unneeded files in the pool, ie: files that
#   only have one link. To avoid race conditions, BackupPC_nightly and
#   BackupPC_link cannot run at the same time. Starting in v3.0.0,
#   BackupPC_nightly can run concurrently with backups (BackupPC_dump).
#
# @param max_backups
#   Maximum number of simultaneous backups to run. If
#   there are no user backup requests then this is the
#   maximum number of simultaneous backups.
#
# @param max_old_log_files
#   Maximum number of log files we keep around in log directory. These files are
#   aged nightly. A setting of 14 means the log directory will contain about 2
#   weeks of old log files, in particular at most the files LOG, LOG.0, LOG.1,
#   ... LOG.13 (except today's LOG, these files will have a .z extension if
#   compression is on).
#
# @param max_pending_cmds
#   Maximum number of pending link commands. New backups will only
#   be started if there are no more than $Conf{MaxPendingCmds} plus
#   $Conf{MaxBackups} number of pending link commands, plus running
#   jobs. This limit is to make sure BackupPC doesn't fall too far
#   behind in running BackupPC_link commands.
#
# @param max_user_backups
#   Additional number of simultaneous backups that users
#   can run. As many as $Conf{MaxBackups} + $Conf{MaxUserBackups}
#   requests can run at the same time.
#
# @param partial_age_max
#   A failed full backup is saved as a partial backup. The rsync XferMethod can
#   take advantage of the partial full when the next backup is run. This
#   parameter sets the age of the partial full in days: if the partial backup is
#   older than this number of days, then rsync will ignore (not use) the partial
#   full when the next backup is run. If you set this to a negative value then
#   no partials will be saved. If you set this to 0, partials will be saved, but
#   will not be used by the next backup.
#
# @param ping_max_msec
#   Maximum RTT value (in ms) above which backup won't be started. Default to
#   20ms
#
# @param restore_info_keep_cnt
#   Number of restore logs to keep. BackupPC remembers information about each
#   restore request. This number per client will be kept around before the
#   oldest ones are pruned.
#
# @param service_enable
#   Boolean. Will enable service at boot
#   and ensure a running service.
#
# @param topdir
#   Overwrite package default location for backuppc.
#
# @param trash_clean_sleep_sec
#   How long BackupPC_trashClean sleeps in seconds between each check of the
#   trash directory.
#
# @param user_cmd_check_status
#    Whether the exit status of each PreUserCmd and PostUserCmd is checked.  If
#    set and the Dump/Restore/Archive Pre/Post UserCmd returns a non-zero exit
#    status then the dump/restore/archive is aborted. To maintain backward
#    compatibility (where the exit status in early versions was always ignored),
#    this flag defaults to 0.  If this flag is set and the Dump/Restore/Archive
#    PreUserCmd fails then the matching Dump/Restore/Archive PostUserCmd is not
#    executed. If DumpPreShareCmd returns a non-exit status, then
#    DumpPostShareCmd is not executed, but the DumpPostUserCmd is still run
#    (since DumpPreUserCmd must have previously succeeded).  An example of a
#    DumpPreUserCmd that might fail is a script that snapshots or dumps a
#    database which fails because of some database error.
#
# @param wakeup_schedule
#   Times at which we wake up, check all the PCs, and schedule necessary
#   backups. Times are measured in hours since midnight. Can be fractional if
#
# @param dhcp_address_ranges
#   List of DHCP address ranges we search looking for PCs to backup. This is an
#   array of hashes for each class C address range. This is only needed if hosts
#   in the conf/hosts file have the dhcp flag set.
#
# @param email_user_dest_domain
#   Destination domain name for email sent to users.
#
# @param rsync_args_extra
#   Additional arguments to rsync for backup.
#
# @param package
#   The name of the backuppc package.
#
# @param service
#   The name of the backuppc service.
#
# @param config_directory
#   The location of the backuppc configuration
#
# @param topdir
#   he backuppc data directory, below which all the BackupPC data is stored.
#   This needs to have enough capacity for your backups.
#
# @param config
#   The name of the main configuration file. This sets the defaults for all
#   hosts/clients.
#
# @param hosts
#   The name of the hosts file. This contains the list of clients to backup.
#
# @param install_directory
#   Install location for BackupPC scripts, libraries and documentation.
#
# @param cgi_directory
#   Location for BackupPC CGI script. This will usually be below Apache's
#   cgi-bin directory.
#
# @param cgi_image_dir
#   The directory where BackupPC's images are stored so that Apache can serve
#   them. You should ensure this directory is readable by Apache and create a
#   symlink to this directory from the BackupPC CGI bin Directory.
#
# @param cgi_image_dir_url
#   URL (without the leading http://host) for BackupPC's image directory. The
#   CGI script uses this value to serve up image files.
#
# @param log_directory
#   Location for log files.
#
# @param config_apache
#   The file where the backuppc specifc config for apache is stored.
#
# @param group_apache
#   BackupPC config files are set to this group.
#
# @param par_path
#   Path to par executable
#
# @param gzip_path
#   Path to gzip executable
#
# @param bzip2_path
#   Path to bzip2 executable
#
# @param tar_path
#   Path to tar executable
#
# @param preseed_file
#   The location for the preseed file to support BackupPC installation by
#   providing preset answers.
#
class backuppc::server (
  Stdlib::Absolutepath $config_directory                    = '/etc/backuppc',
  Stdlib::Absolutepath $topdir                              = '/var/lib/backuppc',
  String $apache_allow_from                                 = 'all',
  Boolean $apache_configuration                             = true,
  Boolean $apache_require_ssl                               = false,
  Integer $archive_info_keep_cnt                            = 10,
  Integer $backuppc_nightly_period                          = 1,
  Integer $pool_size_nightly_update_period                  = 16,
  Integer[0,3] $ref_cnt_fsck                                = 1,
  Integer[0,100] $pool_nightly_digest_check_percent         = 1,
  String $backuppc_password                                 = '',
  Boolean $backup_zero_files_is_fatal                       = true,
  Boolean $pool_v3_enabled                                  = false,
  Integer $blackout_good_cnt                                = 7,
  Backuppc::BlackoutPeriods $blackout_periods = [ { hourBegin => 7.0, hourEnd => 19.5, weekDays => [1,2,3,4,5], }, ],
  Stdlib::Absolutepath $bzip2_path                          = '/bin/bzip2',
  String $cgi_admin_user_group                              = 'backuppc',
  String $cgi_admin_users                                   = 'backuppc',
  Integer[0,2] $cgi_date_format_mmdd                        = 1,
  Stdlib::Absolutepath $cgi_directory                       = "${install_directory}/cgi-bin",
  Stdlib::Absolutepath $cgi_image_dir                       = "${install_directory}/image",
  Stdlib::Absolutepath $cgi_image_dir_url                   = '/backuppc/image',
  Stdlib::HTTPUrl $cgi_url                                  = "http://${facts['networking']['fqdn']}/backuppc/index.cgi",
  Stdlib::Absolutepath $config_apache                       = '/etc/apache2/conf.d/backuppc.conf',
  Stdlib::Absolutepath $config                              = "${config_directory}/config.pl",
  Integer $df_max_usage_pct                                 = 95,
  Backuppc::DhcpAddressRange $dhcp_address_ranges           = [],
  String $email_admin_user_name                             = 'backuppc',
  String $email_from_user_name                              = 'backuppc',
  Hash $email_headers = { 'MIME-Version' => 1.0, 'Content-Type' => 'text/plain; charset="iso-8859-1"', },
  Numeric $email_notify_min_days                            = 2.5,
  Integer $email_notify_old_backup_days                     = 7,
  Enum['present','absent'] $ensure                          = 'present',
  Integer $full_age_max                                     = 90,
  Variant[Integer,Array[Integer]] $full_keep_cnt            = 1,
  Numeric $full_period                                      = 6.97,
  String[1] $group_apache                                   = 'www-data',
  Stdlib::Absolutepath $gzip_path                           = '/bin/gzip',
  Stdlib::Absolutepath $hosts                               = "${config_directory}/hosts",
  Stdlib::Absolutepath $htpasswd_apache                     = "${config_directory}/htpasswd",
  Integer $incr_age_max                                     = 30,
  Boolean $incr_fill                                        = false,
  Integer $incr_keep_cnt                                    = 6,
  Array[Integer] $incr_levels                               = [1],
  Numeric $incr_period                                      = 0.97,
  Stdlib::Absolutepath $install_directory                   = '/usr/share/backuppc',
  String $language                                          = 'en',
  Stdlib::Absolutepath $log_directory                       = "${topdir}/log",
  Integer $max_backuppc_nightly_jobs                        = 2,
  Integer $max_backups                                      = 4,
  Integer $max_old_log_files                                = 14,
  Integer $max_pending_cmds                                 = 15,
  Integer $max_user_backups                                 = 4,
  String[1] $package                                        = 'backuppc',
  Integer $partial_age_max                                  = 3,
  Integer $ping_max_msec                                    = 20,
  Integer $restore_info_keep_cnt                            = 10,
  Stdlib::Absolutepath $rsync_path                          = '/bin/rsync',
  Stdlib::Absolutepath $rsync_bpc_path                      = '/usr/libexec/backuppc-rsync/rsync_bpc',
  String[1] $service                                        = 'backuppc',
  Boolean $service_enable                                   = true,
  Stdlib::Absolutepath $tar_path                            = '/bin/tar',
  Integer $trash_clean_sleep_sec                            = 300,
  Boolean $user_cmd_check_status                            = true,
  Array[Backuppc::Hours] $wakeup_schedule = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23],
  Optional[Backuppc::Domain] $email_user_dest_domain        = undef,
  Optional[Stdlib::Absolutepath] $par_path                  = '/usr/bin/par2',
  Optional[Hash] $preseed_file                              = {
    '/var/cache/debconf/backuppc.seeds' => {
      ensure => 'present',
      content => "template('backuppc/Debian-preeseed.erb')"
    }
  },
  Optional[Array[String]] $rsync_args_extra                 = undef,
) {

  if empty($backuppc_password) {
    fail('Please provide a password for the backuppc user. This is used to login to the web based administration site.')
  }

  $real_incr_fill  = bool2num($incr_fill)
  $real_bzfif      = bool2num($backup_zero_files_is_fatal)
  $real_uccs       = bool2num($user_cmd_check_status)
  $real_v3_enabled = bool2num($pool_v3_enabled)

  $real_topdir = $topdir ? {
    ''      => lookup('backuppc::server::topdir'),
    default => $topdir,
  }

  $directory_ensure = $ensure ? {
    'present' => 'directory',
    default => 'absent',
  }

  # On Debian, adapt log_directory to $topdir value
  $real_log_directory = $facts['os']['family'] ? {
    'Debian' => "${topdir}/log",
    default  => $log_directory,
  }

  # If topdir is changed, create a symlink between "default" topdir and the custom
  # This permit "facter/backuppc_pubkey_rsa" to work properly.
  if $real_topdir != lookup('backuppc::server::topdir') {
    file { $topdir:
      ensure => link,
      target => $real_topdir,
    }
  }

  # Set up dependencies
  Package['backuppc'] -> File['config.pl'] -> Service['backuppc']

  # Include preseeding for debian packages
  unless empty ($preseed_file) {
    create_resources(file, $preseed_file)
  }

  # BackupPC package and service configuration
  package { 'backuppc':
    ensure => $ensure,
    name   => $package,
  }

  service { 'backuppc':
    ensure    => $service_enable,
    name      => $service,
    enable    => $service_enable,
    hasstatus => true,
    pattern   => 'BackupPC'
  }

  file { 'config.pl':
    ensure  => $ensure,
    path    => $config,
    owner   => 'backuppc',
    group   => $group_apache,
    mode    => '0640',
    content => template('backuppc/config.pl.erb'),
    notify  => Service['backuppc']
  }

  file { 'config_directory':
    ensure  => $directory_ensure,
    path    => $config_directory,
    owner   => 'backuppc',
    group   => $group_apache,
    require => Package['backuppc'],
  }

  file { 'pc_directory_symlink':
    ensure  => link,
    path    => "${config_directory}/pc",
    target  => $config_directory,
    require => Package['backuppc'],
  }

  $topdir_defaults = {
    ensure  => $directory_ensure,
    owner   => 'backuppc',
    group   => $group_apache,
    mode    => '0640',
    require => Package['backuppc'],
  }

  file {
    default:
      * => $topdir_defaults,;

    'topdir':
      path   => $real_topdir,
      ignore => 'BackupPC.sock',;

    'topdir_ssh':
      path => "${real_topdir}/.ssh",;
  }

  # Workaround for client exported resources that are
  # on a different osfamily. Maintain a symlink to alternative
  # config directory targets.
  case $facts['os']['family'] {
    'Debian': {
      file { '/etc/BackupPC':
        ensure => link,
        target => $config_directory,
      }
    }
    'RedHat': {
      file { '/etc/backuppc':
        ensure => link,
        target => $config_directory,
      }
    }
    default: {
      notify { "If you've added support for ${facts['os']['name']} you'll need to extend this case statement to.":
      }
    }
  }

  exec { 'backuppc-ssh-keygen':
    command => "ssh-keygen -f ${real_topdir}/.ssh/id_rsa -C 'BackupPC on ${facts['networking']['fqdn']}' -N ''",
    user    => 'backuppc',
    unless  => "test -f ${real_topdir}/.ssh/id_rsa",
    path    => ['/usr/bin','/bin'],
    require => [
      Package['backuppc'],
      File["${real_topdir}/.ssh"],
    ],
  }

  # BackupPC apache configuration
  if $apache_configuration {
    file { 'apache_config':
      ensure  => $ensure,
      path    => $config_apache,
      content => template("backuppc/apache_${facts['os']['family']}.erb"),
      require => Package['backuppc'],
    }

    # Create the default admin account
    backuppc::server::user { 'backuppc':
      password => $backuppc_password
    }
  }

  # Export backuppc's authorized key to all clients
  # TODO don't rely on facter to obtain the ssh key.
  if $facts['backuppc_pubkey_rsa'] != undef {
    @@ssh_authorized_key { "backuppc_${facts['networking']['fqdn']}":
      ensure => present,
      key    => $facts['backuppc_pubkey_rsa'],
      name   => "backuppc_${facts['networking']['fqdn']}",
      user   => 'root',
      type   => 'ssh-rsa',
      tag    => "backuppc_${facts['networking']['fqdn']}",
    }
  }

  # Hosts
  File <<| tag == "backuppc_config_${facts['networking']['fqdn']}" |>> {
    group   => $group_apache,
    notify  => Service['backuppc'],
    require => File['pc_directory_symlink'],
  }

  Augeas <<| tag == "backuppc_hosts_${facts['networking']['fqdn']}" |>> {
    notify  => Service['backuppc'],
    require => Package['backuppc'],
  }

  Sshkey <<| tag == "backuppc_sshkeys_${facts['networking']['fqdn']}" |>>
}
