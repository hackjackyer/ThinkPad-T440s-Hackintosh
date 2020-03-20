DefinitionBlock ("", "SSDT", 2, "T440", "PS2K", 0)
{
    External (_SB.PCI0, DeviceObj)
    External (_SB.PCI0.LPC, DeviceObj)
    External (_SB.PCI0.LPC.PS2K, DeviceObj)
    External (_SB.PCI0.LPC.EC, DeviceObj)
    
    Scope (_SB.PCI0.LPC.EC)
    {
        Method (_Q14, 0, NotSerialized)
        {
            Notify (PS2K, 0x0406)
        }
        Method (_Q15, 0, NotSerialized)
        {
            Notify (PS2K, 0x0405)
        }
        Method (_Q6A, 0, NotSerialized)
        {
            Notify (PS2K, 0x033E)
        }
        Method (_Q16, 0, NotSerialized)
        {
            Notify (PS2K, 0x046E)
        }
        Method (_Q64, 0, NotSerialized)
        {
            Notify (PS2K, 0x0342)
        }
        Method (_Q66, 0, NotSerialized)
        {
            Notify (PS2K, 0x0367)
        }
        Method (_Q67, 0, NotSerialized)
        {
            Notify (PS2K, 0x0368)
        }
        Method (_Q68, 0, NotSerialized)
        {
            Notify (PS2K, 0x0369)
        }
        Method (_Q69, 0, NotSerialized)
        {
            Notify (PS2K, 0x036A)
        }
    }
        
    Scope (_SB.PCI0.LPC.PS2K)
    {
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "T460",
            })
        }
        Name(RMCF, Package()
        {
            "Keyboard", Package()
            {
                "ActionSwipeLeft",  "37 d, 21 d, 21 u, 37 u",
                "ActionSwipeRight", "37 d, 1e d, 1e u, 37 u",
                "SleepPressTime",   "1500",
                "Swap command and option", ">y",
                "Custom PS2 Map", Package()
                {
                    Package() { },
                    "e037=64",
                },
            },
            "Synaptics TouchPad", Package()
            {
                "BogusDeltaThreshX", 800,
                "BogusDeltaThreshY", 800,
                "Clicking", ">y",
                "DragLockTempMask", 0x40004,
                "DynamicEWMode", ">n",
                "FakeMiddleButton", ">n",
                "HWResetOnStart", ">y",
                "PalmNoAction When Typing", ">y",
                "ScrollResolution", 800,
                "SmoothInput", ">y",
                "UnsmoothInput", ">y",
                "Thinkpad", ">y",
                "EdgeBottom", 0,
                "FingerZ", 30,
                "MaxTapTime", 100000000,
                "MouseMultiplierX", 2,
                "MouseMultiplierY", 2,
                "MouseScrollMultiplierX", 2,
                "MouseScrollMultiplierY", 2,
                "TrackpointScrollYMultiplier", 1,
                "TrackpointScrollXMultiplier", 1,
            },
        })
    }
}