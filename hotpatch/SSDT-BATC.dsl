DefinitionBlock ("", "SSDT", 2, "T440", "BATT", 0)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.LPC, DeviceObj)
    External (_SB_.PCI0.LPC.EC, DeviceObj)
    External (_SB_.PCI0.LPC.EC.BAT0, DeviceObj)
    External (_SB_.PCI0.LPC.EC.BAT0._BIF, MethodObj)
    External (_SB_.PCI0.LPC.EC.BAT0._BST, MethodObj)
    External (_SB_.PCI0.LPC.EC.BAT0._HID, IntObj)
    External (_SB_.PCI0.LPC.EC.BAT0._STA, MethodObj)
    External (_SB_.PCI0.LPC.EC.BAT1, DeviceObj)
    External (_SB_.PCI0.LPC.EC.BAT1._BIF, MethodObj)
    External (_SB_.PCI0.LPC.EC.BAT1._BST, MethodObj)
    External (_SB_.PCI0.LPC.EC.BAT1._HID, IntObj)
    External (_SB_.PCI0.LPC.EC.BAT1._STA, MethodObj)
    External (_SB_.PCI0.LPC.EC.HFSP, FieldUnitObj)
    External (_SB_.PCI0.LPC.EC.TMP0, FieldUnitObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return (Or (Arg0, ShiftLeft (Arg1, 0x08)))
    }

    Method (B1B4, 4, NotSerialized)
    {
        Store (Arg3, Local0)
        Or (Arg2, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg1, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg0, ShiftLeft (Local0, 0x08), Local0)
        Return (Local0)
    }

    Scope (_SB.PCI0.LPC.EC)
    {
        Method (RE1B, 1, Serialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, One)
            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE)
        }

        Method (RECB, 2, Serialized)
        {
            ShiftRight (Arg1, 0x03, Arg1)
            Name (TEMP, Buffer (Arg1){})
            Add (Arg0, Arg1, Arg1)
            Store (Zero, Local0)
            While (LLess (Arg0, Arg1))
            {
                Store (RE1B (Arg0), Index (TEMP, Local0))
                Increment (Arg0)
                Increment (Local0)
            }

            Return (TEMP)
        }

        OperationRegion (ECO2, EmbeddedControl, Zero, 0x0100)
        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x36), 
            WAC0,   8, 
            WAC1,   8, 
            Offset (0x84), 
            HFN1,   8, 
            HFN2,   8
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BRC0,   8, 
            BRC1,   8, 
            BFC0,   8, 
            BFC1,   8, 
            BAE0,   8, 
            BAE1,   8, 
            BRS0,   8, 
            BRS1,   8, 
            BAC0,   8, 
            BAC1,   8, 
            BVO0,   8, 
            BVO1,   8, 
            BAF0,   8, 
            BAF1,   8, 
            BBS0,   8, 
            BBS1,   8
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BBM0,   8, 
            BBM1,   8
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BDC0,   8, 
            BDC1,   8, 
            BDV0,   8, 
            BDV1,   8, 
            BOM0,   8, 
            BOM1,   8, 
            BSI0,   8, 
            BSI1,   8, 
            BDT0,   8, 
            BDT1,   8, 
            BSN0,   8, 
            BSN1,   8
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BCH0,   8, 
            BCH1,   8, 
            BCH2,   8, 
            BCH3,   8
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BMNX,   128
        }

        Field (ECO2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0), 
            BDNX,   128
        }

        Method (XWAC, 0, NotSerialized)
        {
            Return (B1B2 (WAC0, WAC1))
        }

        Method (XBRC, 0, NotSerialized)
        {
            Return (B1B2 (BRC0, BRC1))
        }

        Method (XBFC, 0, NotSerialized)
        {
            Return (B1B2 (BFC0, BFC1))
        }

        Method (XBAC, 0, NotSerialized)
        {
            Return (B1B2 (BAC0, BAC1))
        }

        Method (XBVO, 0, NotSerialized)
        {
            Return (B1B2 (BVO0, BVO1))
        }

        Method (XBBM, 0, NotSerialized)
        {
            Return (B1B2 (BBM0, BBM1))
        }

        Method (XBDC, 0, NotSerialized)
        {
            Return (B1B2 (BDC0, BDC1))
        }

        Method (XBSN, 0, NotSerialized)
        {
            Return (B1B2 (BSN0, BSN1))
        }

        Method (XBDV, 0, NotSerialized)
        {
            Return (B1B2 (BDV0, BDV1))
        }

        Method (XBCH, 0, NotSerialized)
        {
            Return (B1B4 (BCH0, BCH1, BCH2, BCH3))
        }

        Method (XBMN, 0, NotSerialized)
        {
            Return (RECB (0xA0, 0x80))
        }

        Method (XBDN, 0, NotSerialized)
        {
            Return (RECB (0xA0, 0x80))
        }

        Device (BATC)
        {
            Name (_HID, EisaId ("PNP0C0A"))  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (Or (^^BAT0._STA (), ^^BAT1._STA ()))
            }

            Name (B0CO, Zero)
            Name (B1CO, Zero)
            Name (B0DV, Zero)
            Name (B1DV, Zero)
            Method (CVWA, 3, NotSerialized)
            {
                If (Arg2)
                {
                    Divide (Multiply (Arg0, 0x03E8), Arg1, , Arg0)
                }

                Return (Arg0)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Store (^^BAT0._BIF (), Local0)
                Store (^^BAT0._STA (), Local1)
                If (LEqual (Local1, 0x1F))
                {
                    Store (DerefOf (Index (Local0, One)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local1)
                    }

                    Store (DerefOf (Index (Local0, 0x02)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local1)
                    }

                    Store (DerefOf (Index (Local0, 0x04)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local1)
                    }
                }

                Store (^^BAT1._BIF (), Local2)
                Store (^^BAT1._STA (), Local3)
                If (LEqual (Local3, 0x1F))
                {
                    Store (DerefOf (Index (Local2, One)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local3)
                    }

                    Store (DerefOf (Index (Local2, 0x02)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local3)
                    }

                    Store (DerefOf (Index (Local2, 0x04)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local3)
                    }
                }

                If (LAnd (LNotEqual (Local1, 0x1F), LEqual (Local3, 0x1F)))
                {
                    Store (Local2, Local0)
                    Store (Local3, Local1)
                    Store (Zero, Local3)
                }

                If (LAnd (LEqual (Local1, 0x1F), LEqual (Local3, 0x1F)))
                {
                    Store (LNot (DerefOf (Index (Local0, Zero))), B0CO)
                    Store (LNot (DerefOf (Index (Local2, Zero))), B1CO)
                    Store (DerefOf (Index (Local0, 0x04)), B0DV)
                    Store (DerefOf (Index (Local2, 0x04)), B1DV)
                    Store (One, Index (Local0, Zero))
                    Add (CVWA (DerefOf (Index (Local0, One)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, One)), B1DV, B1CO), Index (Local0, One))
                    Add (CVWA (DerefOf (Index (Local0, 0x02)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, 0x02)), B1DV, B1CO), Index (Local0, 0x02))
                    Divide (Add (B0DV, B1DV), 0x02, , Index (Local0, 0x04))
                    Add (CVWA (DerefOf (Index (Local0, 0x05)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, 0x05)), B1DV, B1CO), Index (Local0, 0x05))
                    Add (CVWA (DerefOf (Index (Local0, 0x06)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, 0x06)), B1DV, B1CO), Index (Local0, 0x06))
                }

                Return (Local0)
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Store (^^BAT0._BST (), Local0)
                Store (^^BAT0._STA (), Local1)
                If (LEqual (Local1, 0x1F))
                {
                    Store (DerefOf (Index (Local0, 0x02)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local1)
                    }
                }

                Store (^^BAT1._BST (), Local2)
                Store (^^BAT1._STA (), Local3)
                If (LEqual (Local3, 0x1F))
                {
                    Store (DerefOf (Index (Local2, 0x02)), Local4)
                    If (LOr (LNot (Local4), LEqual (Local4, Ones)))
                    {
                        Store (Zero, Local3)
                    }
                }

                If (LAnd (LNotEqual (Local1, 0x1F), LEqual (Local3, 0x1F)))
                {
                    Store (Local2, Local0)
                    Store (Local3, Local1)
                    Store (Zero, Local3)
                }

                If (LAnd (LEqual (Local1, 0x1F), LEqual (Local3, 0x1F)))
                {
                    Store (DerefOf (Index (Local0, Zero)), Local4)
                    Store (DerefOf (Index (Local2, Zero)), Local5)
                    If (LOr (LEqual (Local4, 0x02), LEqual (Local5, 0x02)))
                    {
                        Store (0x02, Index (Local0, Zero))
                    }
                    ElseIf (LOr (LEqual (Local4, One), LEqual (Local5, One)))
                    {
                        Store (One, Index (Local0, Zero))
                    }
                    ElseIf (LOr (LEqual (Local4, 0x05), LEqual (Local5, 0x05)))
                    {
                        Store (0x05, Index (Local0, Zero))
                    }
                    ElseIf (LOr (LEqual (Local4, 0x04), LEqual (Local5, 0x04)))
                    {
                        Store (0x04, Index (Local0, Zero))
                    }

                    Add (CVWA (DerefOf (Index (Local0, One)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, One)), B1DV, B1CO), Index (Local0, One))
                    Add (CVWA (DerefOf (Index (Local0, 0x02)), B0DV, B0CO), CVWA (DerefOf (Index (Local2, 0x02)), B1DV, B1CO), Index (Local0, 0x02))
                    Divide (Add (DerefOf (Index (Local0, 0x03)), DerefOf (Index (Local2, 0x03))), 0x02, , Index (Local0, 0x03))
                }

                Return (Local0)
            }
        }

        Device (SMCD)
        {
            Name (_HID, "FAN00000")
            Name (TACH, Package (0x02)
            {
                "System Fan", 
                "FAN0"
            })
            Name (TEMP, Package (0x02)
            {
                "CPU Heatsink", 
                "TCPU"
            })
            Method (FAN0, 0, NotSerialized)
            {
                Store (B1B2 (\_SB.PCI0.LPC.EC.HFN1, \_SB.PCI0.LPC.EC.HFN2), Local0)
                Return (Local0)
            }

            Method (TCPU, 0, NotSerialized)
            {
                Store (\_SB.PCI0.LPC.EC.TMP0, Local0)
                Return (Local0)
            }
        }
    }
}