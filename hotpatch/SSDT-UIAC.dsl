DefinitionBlock ("", "SSDT", 2, "T440", "UIAC", 0)
{
    Device (UIAC)
    {
        Name (_HID, "UIA00000")
        Name (RMCF, Package()
        {
            "AppleBusPowerController", Package()
            {
                "kUSBSleepPortCurrentLimit", 3000,
                "kUSBWakePortCurrentLimit", 3000,
            },
            "XHC", Package()
            {
                "port-count", Buffer() { 0x0B, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HS01", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                      "HS02", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HS07", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x07, 0x00, 0x00, 0x00 },
                      },
                      "HS08", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x08, 0x00, 0x00, 0x00 },
                      },
                      "SS01", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0A, 0x00, 0x00, 0x00 },
                      },
                      "SS02", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0B, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
    
    External (_SB.PCI0.XHC, DeviceObj)
    
    Method (_SB.PCI0.XHC.ESEL) {}
}
