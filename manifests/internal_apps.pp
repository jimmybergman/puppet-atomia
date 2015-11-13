## Atomia internal_apps

### Deploys and configures Atomia Internal Apps

### Variable documentation
#### repository: The repository name to install the application from

### Validations
##### repository(advanced): ^(PublicRepository|TestRepository)+


class atomia::internal_apps (
  $repository = "PublicRepository",){

  # Set ip correctly when on ec2
  if $ec2_public_ipv4 {
    $public_ip = $ec2_public_ipv4
  } else {
    $public_ip = $ipaddress_eth0
  }

	File { source_permissions => ignore }


	if($repository == 'PublicRepository')
	{
		#Atomia Admin Panel
		#Atomia Billing APIs

		exec {'install-actiontrail':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository PublicRepository -application "Atomia ActionTrail"',
			require   => [Exec['install-setuptools'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\ActionTrail',
		}
		->
		exec {'install-billingapis':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository PublicRepository -application "Atomia Billing APIs"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\BillingAPIs',
		}
		->
		exec {'install-automationserver':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository PublicRepository -application "Atomia Automation Server"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AutomationServer',
		}
		->
		exec {'install-cloudhostingpack':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository PublicRepository -application "Atomia CloudHosting Modules"',
			require   => [Exec['install-automationserver'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AutomationServer\Common\Modules',
		}
		->
		exec {'install-adminpanel':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository PublicRepository -application "Atomia Admin Panel"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AdminPanel',
		}

	}
	else
	{
		exec {'install-actiontrail':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository TestRepository -application "Atomia ActionTrail"',
			require   => [Exec['install-setuptools'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\ActionTrail',
		}
		->
		exec {'install-billingapis':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository TestRepository -application "Atomia Billing APIs"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\BillingAPIs',
		}
		->
		exec {'install-automationserver':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository TestRepository -application "Atomia Automation Server"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AutomationServer',
		}
		->
		exec {'install-cloudhostingpack':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository TestRepository -application "Atomia CloudHosting Modules"',
			require   => [Exec['install-automationserver'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AutomationServer\Common\Modules',
		}
		->
		exec {'install-adminpanel':
			command	=> 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File c:/install/install_atomia_application.ps1 -repository TestRepository -application "Atomia Admin Panel"',
			require   => [Exec['install-actiontrail'],File['unattended.ini']],
			creates => 'C:\Program Files (x86)\Atomia\AdminPanel',
		}
	}

	file { 'C:\ProgramData\PuppetLabs\facter\facts.d\atomia_role_internal.txt':
	  content => 'atomia_role_1=atomia_internal_apps',
	}
}
