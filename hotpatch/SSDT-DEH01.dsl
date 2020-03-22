DefinitionBlock ("", "SSDT", 2, "T440", "DEH01", 0)
{
    External (_SB.PCI0.EH01, DeviceObj)
    External (_SB.PCI0.LPCB, DeviceObj)

    Scope (_SB.PCI0.EH01)
    {
        OperationRegion (RMP1, PCI_Config, 0x54, 2)
        Field (RMP1, WordAcc, NoLock, Preserve)
        {
            PSTE, 2
        }
    }
    Scope (_SB.PCI0.LPCB)
    {
        OperationRegion (RMP1, PCI_Config, 0xF0, 4)
        Field (RMP1, DWordAcc, NoLock, Preserve)
        {
            RCB3, 32,
        }
        OperationRegion (FDM1, SystemMemory, (RCB3 & Not ((1<<14)-1)) + 0x3418, 4)
        Field (FDM1, DWordAcc, NoLock, Preserve)
        {
            ,15,
            FDE1,1,
        }
    }
    Device (_SB.PCI0.RMD3)
    {
        Name (_HID, "RMD30000")
        Method (_INI)
        {
            ^^EH01.PSTE = 3
            ^^LPCB.FDE1 = 1
        }
    }
}