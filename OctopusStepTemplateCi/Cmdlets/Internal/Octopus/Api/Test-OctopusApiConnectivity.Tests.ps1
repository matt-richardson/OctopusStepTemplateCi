<#
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
#>

<#
.NAME
    Test-OctopusApiConnectivity.Tests

.SYNOPSIS
    Pester tests for Test-OctopusApiConnectivity.
#>

$ErrorActionPreference = "Stop";
Set-StrictMode -Version "Latest";

InModuleScope "OctopusStepTemplateCi" {

    Describe "Test-OctopusApiConnectivity" {

        It "Should throw an exception if the octopus uri does not exist" {
           {
               Test-OctopusApiConnectivity -OctopusUri $null -OctopusApiKey "fake-key";
           } | Should Throw "The OctopusUri environment variable is not set, please set this variable and execute again.";
        }

        It "Should throw an exception if the octopus api key does not exist" {
           {
               Test-OctopusApiConnectivity -OctopusUri "fakeurl" -OctopusApiKey $null;
           } | Should Throw "The OctopusApiKey environment variables is not set, please set this variable and execute again.";
        }

        It "Should not make a test api call to the octopus server if not requested" {

           Mock -CommandName "Invoke-OctopusApiOperation" `
                -MockWith {} `
                -Verifiable;

           Test-OctopusApiConnectivity -OctopusUri "na" -OctopusApiKey "na";

           Assert-MockCalled Invoke-OctopusApiOperation -times 0;

        }

        It "Should make a test api call to the octopus server (if requested) to see if it is responding" {

           Mock -CommandName "Invoke-OctopusApiOperation" `
                -MockWith { return @{ "Application" = "Octopus Deploy" }; };

           Test-OctopusApiConnectivity -OctopusUri "na" -OctopusApiKey "na" -TestConnection;

           Assert-MockCalled Invoke-OctopusApiOperation -times 1;

        }

        It "Should throw an exception if test connection is requested and the test api call doesn't return an object" {

            Mock -CommandName "Invoke-OctopusApiOperation" `
                 -MockWith {};

            {
                Test-OctopusApiConnectivity -OctopusUri "na" -OctopusApiKey "na" -TestConnection;
            } | Should Throw "Octopus Deploy Api is not responding correctly";

        }

    }

}
