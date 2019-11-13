Import-Module -Force $PSScriptRoot/../Source/Docker.Build.psm1
Import-Module -Global -Force $PSScriptRoot/Docker.Build.Tests.psm1
Import-Module -Global -Force $PSScriptRoot/MockReg.psm1

. "$PSScriptRoot\..\Source\Private\Invoke-Command.ps1"

Describe 'Build docker images' {

    BeforeEach {
        Initialize-MockReg
        $dockerFile = Join-Path $Global:DockerImagesDir "Linux.Dockerfile"
        Mock -CommandName "Invoke-Command" $Global:CodeThatReturnsExitCodeZero -Verifiable -ModuleName $Global:ModuleName
    }

    AfterEach {
        Assert-MockCalled -CommandName "Invoke-Command" -ModuleName $Global:ModuleName
    }

    Context 'Docker build with latest tag' {

        It 'creates correct docker build command' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile
            $result = GetMockValue -Key "command"
            $result | Should -BeExactly "docker build `"$Global:DockerImagesDir`" -t leeandrasmus:latest -f `"${dockerFile}`""
        }

        It 'Throws exception if exitcode is not 0' {
            Mock -CommandName "Invoke-Command" $Global:CodeThatReturnsExitCodeOne -Verifiable -ModuleName $Global:ModuleName
            $runner = { Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile }
            $runner | Should -Throw -ExceptionType ([System.Exception]) -PassThru
        }
    }

    Context 'Docker build with various registry parameters' {

        It 'creates correct docker build command, with valid registry parameter' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -Registry 'valid'
            $result = GetMockValue -Key "command"
            $result | Should -BeExactly "docker build `"$Global:DockerImagesDir`" -t valid/leeandrasmus:latest -f `"${dockerFile}`""
        }

        It 'creates correct docker build command, with $null registry parameter' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -Registry $null
            $result = GetMockValue -Key "command"
            $result | Should -BeLikeExactly "docker build `"$Global:DockerImagesDir`" -t leeandrasmus:latest -f `"${dockerFile}`""
        }
    }

    Context 'Docker build with the extra parameter' {

        It 'creates correct docker build command, with the extra parameter' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -ExtraParams '--cache-from garbage-in:garbage-out'
            $result = GetMockValue -Key "command"
            $result | Should -BeExactly "docker build `"$Global:DockerImagesDir`" -t leeandrasmus:latest -f `"${dockerFile}`" --cache-from garbage-in:garbage-out"
        }

        It 'creates correct docker build command, with the extra parameter and  $null registry parameter' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -Registry $null -ExtraParams '-m=4g'
            $result = GetMockValue -Key "command"
            $result | Should -BeLikeExactly "docker build `"$Global:DockerImagesDir`" -t leeandrasmus:latest -f `"${dockerFile}`" -m=4g"
        }

        It 'creates correct docker build command, with a longer extra parameter' {
            Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -ExtraParams '--cache-from garbage-in:garbage-out -m=4g'
            $result = GetMockValue -Key "command"
            $result | Should -BeExactly "docker build `"$Global:DockerImagesDir`" -t leeandrasmus:latest -f `"${dockerFile}`" --cache-from garbage-in:garbage-out -m=4g"
        }

        It 'throws exception if empty extra parameter is parsed' {
            $theCode = { Invoke-DockerBuild -ImageName "leeandrasmus" -Context $Global:DockerImagesDir -Dockerfile $dockerFile -ExtraParams '' }
            $theCode | Should -Throw -ExceptionType ([System.Management.Automation.ParameterBindingException]) -PassThru
        }
    }

    Context 'Pipeline execution' {

        BeforeEach {
            Initialize-MockReg
        }

        $pipedInput = {
            $input = [PSCustomObject]@{
                "ImageName" = "myimage";
            }
            return $input
        }

        It 'can consume arguments from pipeline' {
            & $pipedInput | Invoke-DockerBuild
        }

        It 'returns the expected pscustomobject' {
            $result = & $pipedInput | Invoke-DockerBuild
            $result.Dockerfile | Should -Not -BeNullOrEmpty
            $result.ImageName | Should -Not -BeNullOrEmpty
            $result.Registry | Should -Not -Be $null
            $result.Tag | Should -Not -BeNullOrEmpty
            $result.CommandResult | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Passthru execution' {

        It 'Captures the output of the command invoked' {
            $tempFile = New-TemporaryFile
            Invoke-DockerBuild -ImageName "leeandrasmus" -Dockerfile $dockerFile -Passthru 6> $tempFile
            $result = Get-Content $tempFile

            $result | Should -Be @('Hello', 'World')
        }
    }
}
