Facter.add('backuppc_pubkey_rsa') do
  confine 'osfamily' => ['RedHat', 'Debian']
  setcode do
    sshkey_path ||= case Facter.value(:osfamily)
                    when 'RedHat'
                      '/var/lib/BackupPC/.ssh/id_rsa.pub'
                    when 'Debian'
                      '/var/lib/backuppc/.ssh/id_rsa.pub'
                    end

    if File.exist?(sshkey_path)
      File.read(sshkey_path).split(' ')[1]
    end
  end
end
