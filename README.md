# Octopus Step Template CI
[![Build status](https://ci.appveyor.com/api/projects/status/lxkpk7itkcmho5a8?svg=true)](https://ci.appveyor.com/project/paulmarsy/octopussteptemplateci)

A set of cmdlets that enable Continuous Integration (CI) patterns for Octopus Deploy step templates and script modules.

## Installation

### [PowerShellGet](https://technet.microsoft.com/en-us/library/dn807169.aspx) / PowerShell 5
1. Configure PowerShellGet for use with [PowerShell Gallery](https://www.powershellgallery.com/GettingStarted)
2. Install OctopusStepTemplateCi `PowerShellGet\Install-Module -Name OctopusStepTemplateCi`

### [PsGet](http://psget.net) ###
1. Install PsGet `(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex`
2. Import PsGet `Import-Module PsGet`
2. Install OctopusStepTemplateCi [`PsGet\Install-Module -Module OctopusStepTemplateCi`](http://psget.net/directory/OctopusStepTemplateCi/)

### Manual ###
1. Download the code as a zip file 
2. If required, unblock the zip file
3. Extract the zip file to a folder called OctopusStepTemplateCi under your modules folder (usually `%USERPROFILE%\Documents\WindowsPowerShell\Modules`)
4. To confirm its installed, start a new powershell session, and run `Get-Module -ListAvailable -Name OctopusStepTemplateCi`, which will show the module

## Usage

In a powershell window, run `Import-Module OctopusStepTemplateCi`. From there, you can start exploring the available commands.

In a CI tool, you are most likely to use `Invoke-TeamCityCiUpload`. In a development environment you are most likely to use `Invoke-OctopusScriptTestSuite`.

The default setup expects a directory structure similar to:

```
- StepTemplates
  - *.steptemplate.ps1
  - *.steptemplate.tests.ps1
- ScriptTemplates
  - *.scriptmodule.ps1 
  - *.scriptmodule.tests.ps1
```

## Commands

`Invoke-OctopusScriptTestSuite` - This will run the Pester tests written specifically for the step tempate / script module, along with Pester tests to confirm that the format of the step template / script module file is correct.

`Invoke-TeamCityCiUpload` - This will take a number of step template & script modules, run the octopus script tests against them, if the tests pass then they will be uploaded into Octopus if they are different to the version that currently exists within Octopus. This is designed to be run from within TeamCity and therefore formats output in a TeamCity specific format.

`Sync-ScriptModule` - Uploads the script module into Octopus if it has changed.

`Sync-StepTemplate` - Uploads the step template into Octopus if it has changed.

`New-StepTemplate` - This will create a step template powershell file and Pester test file as a starting point for a new Octopus Step Template.

`New-ScriptModule` - This will create a script module powershell file and Pester test file as a starting point for a new Octopus Script Module.

`New-ScriptValidationTest` - This will create a stub script validation test powershell file as a starting point for a new test.

## Examples

### Step Template

`ExampleStepTemplate.ps1`:
```powershell
$StepTemplateName = 'Example Step Template'
$StepTemplateDescription = 'An example step template to demonstrate OctopusStepTemplateCI'
$StepTemplateParameters = @(
    @{
        'Name' = 'Example Parameter';
        'Label' = 'Example Parameter';
        'HelpText' = "A placeholder parameter example";
        'DefaultValue' = $null;
        # values for DisplaySettings can be discovered by watching the structure used via
        # the Octopus portal in your browsers dev tools
        "DisplaySettings" = @{ }
    }
)
Set-StrictMode -Version Latest

throw "Step Template not implemented"
```

`ExampleStepTemplate.Tests.ps1`:
```powershell
Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Example Step Template" {
    It "does something useful" {
        $true | Should Be $false
    }
}
```

### Script Module

`ExampleScriptModule.ps1`:
```powershell
$ScriptModuleName = "Example Script Module"
$ScriptModuleDescription = "An example script module to demonstrate OctopusStepTemplateCI"
Set-StrictMode -Version Latest

throw "Script Module not implemented"
```

`ExampleScriptModule.Tests.ps1`:
```powershell
Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Example Script Module" {
    It "does something useful" {
        $true | Should Be $false
    }
}
```

## License

Copyright 2016 ASOS.com Limited

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
