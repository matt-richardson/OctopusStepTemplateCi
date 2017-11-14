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
    New-ScriptValidationTest.Tests

.SYNOPSIS
    Pester tests for New-ScriptValidationTest
#>

$ErrorActionPreference = "Stop";
Set-StrictMode -Version "Latest";

Describe "New-ScriptValidationTest" {

   It "Should throw an exception if the script validation test exists" {
       New-Item "TestDrive:\test.ScriptValidationTest.ps1" -ItemType File | Out-Null;
       {
           $result = New-ScriptValidationTest -Name "test" -Path "TestDrive:\";
       } | Should Throw;
   }
   
   It "Should create a new script validation test file" {
       $result = New-ScriptValidationTest -Name "test1" -Path "TestDrive:\";
       "TestDrive:\test1.ScriptValidationTest.ps1" | Should Exist;
   }

   It "Should output a message to the user" {
       $result = New-ScriptValidationTest -Name "test2" -Path "TestDrive:\";
       $result | Should BeOfType [string];
   }

}