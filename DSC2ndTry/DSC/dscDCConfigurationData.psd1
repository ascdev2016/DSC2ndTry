# Configuration Data for AD  
@{
    AllNodes = @(
        @{
            NodeName="*"
            RetryCount = 20
            RetryIntervalSec = 30
            PSDscAllowPlainTextPassword=$true
            PSDscAllowDomainUser = $true
        },
        @{ 
            Nodename = "solutions-dc"
            Role = "DC"
        }
		        @{ 
            Nodename = "solutions-SQL"
            Role = "SQL"
        }
		        @{ 
            Nodename = "solutions-SP"
            Role = "SP"
        }
    )
}