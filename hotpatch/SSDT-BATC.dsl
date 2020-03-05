DefinitionBlock ("", "SSDT", 2, "T440S", "BATC", 0)
{
    External (_SB.PCI0.LPC.EC, DeviceObj)

    Scope (_SB.PCI0.LPC.EC)
    {
        External (BAT0, DeviceObj)
        External (BAT0._HID, IntObj)
        External (BAT0._STA, MethodObj)
        External (BAT0._BIF, MethodObj)
        External (BAT0._BST, MethodObj)
        External (BAT1, DeviceObj)
        External (BAT1._HID, IntObj)
        External (BAT1._STA, MethodObj)
        External (BAT1._BIF, MethodObj)
        External (BAT1._BST, MethodObj)
        External (BATM, MutexObj)
        External (HIID, FieldUnitObj)
        
        Device (BATC)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            
            Method (_INI)
            {
                ^^BAT0._HID = 0
                ^^BAT1._HID = 0
            }
            
            Method (CVWA, 3)
            {
                If (Arg2)
                {
                    Arg0 = (Arg0 * 1000) / Arg1
                }
                Return (Arg0)
            }
            
            Method (_STA)
            {
                Return (^^BAT0._STA() | ^^BAT1._STA())
            }
            
            Name (B0CO, 0)
            Name (B1CO, 0)
            Name (B0DV, 0)
            Name (B1DV, 0)
            
            Method (_BST)
            {

                Local0 = ^^BAT0._BST()
                Local2 = ^^BAT0._STA()
                If (0x1f == Local2)
                {
                    Local4 = DerefOf (Local0[2])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                }
                Local1 = ^^BAT1._BST()
                Local3 = ^^BAT1._STA()
                If (0x1f == Local3)
                {
                    Local4 = DerefOf (Local1[2])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                }
                If (0x1f != Local2 && 0x1f == Local3)
                {
                    Local0 = Local1
                    Local2 = Local3
                    Local3 = 0
                }
                If (0x1f == Local2 && 0x1f == Local3)
                {
                    Local4 = DerefOf (Local0[0])
                    Local5 = DerefOf (Local1[0])
                    If (Local4 == 2 || Local5 == 2)
                    {
                        Local0[0] = 2
                    }
                    ElseIf (Local4 == 1 || Local5 == 1)
                    {
                        Local0[0] = 1
                    }
                    ElseIf (Local4 == 5 || Local5 == 5)
                    {
                        Local0[0] = 5
                    }
                    ElseIf (Local4 == 4 || Local5 == 4)
                    {
                        Local0[0] = 4
                    }

                    Local0[1] = CVWA (DerefOf (Local0[1]), B0DV, B0CO) + CVWA (DerefOf (Local1[1]), B1DV, B1CO)
                    Local0[2] = CVWA (DerefOf (Local0[2]), B0DV, B0CO) + CVWA (DerefOf (Local1[2]), B1DV, B1CO)
                    Local0[3] = (DerefOf (Local0[3]) + DerefOf(Local1[3])) / 2
                }
                Return (Local0)
            }
            
            Method (_BIF)
            {
                Local0 = ^^BAT0._BIF()
                Local2 = ^^BAT0._STA()
                If (0x1f == Local2)
                {
                    Local4 = DerefOf (Local0[1])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                    Local4 = DerefOf(Local0[2])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                    Local4 = DerefOf(Local0[4])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                }
                Local1 = ^^BAT1._BIF()
                Local3 = ^^BAT1._STA()
                If (0x1f == Local3)
                {
                    Local4 = DerefOf (Local1[1])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                    Local4 = DerefOf (Local1[2])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                    Local4 = DerefOf (Local1[4])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                }
                If (0x1f != Local2 && 0x1f == Local3)
                {
                    Local0 = Local1
                    Local2 = Local3
                    Local3 = 0
                }
                If (0x1f == Local2 && 0x1f == Local3)
                {
                    B0CO = !DerefOf (Local0[0])
                    B1CO = !DerefOf (Local1[0])
                    Local0[0] = 1
                    B0DV = DerefOf (Local0[4])
                    B1DV = DerefOf (Local1[4])
                    Local0[1] = CVWA (DerefOf (Local0[1]), B0DV, B0CO) + CVWA (DerefOf (Local1[1]), B1DV, B1CO)
                    Local0[2] = CVWA (DerefOf (Local0[2]), B0DV, B0CO) + CVWA (DerefOf (Local1[2]), B1DV, B1CO)
                    Local0[4] = (B0DV + B1DV) / 2
                    Local0[5] = CVWA (DerefOf (Local0[5]), B0DV, B0CO) + CVWA (DerefOf (Local1[5]), B1DV, B1CO)
                    Local0[6] = CVWA (DerefOf (Local0[6]), B0DV, B0CO) + CVWA (DerefOf (Local1[6]), B1DV, B1CO)
                }
                Return (Local0)
            }
        }
        
        Method (B1B2, 2, NotSerialized)
        {
            Return (Or (Arg0, ShiftLeft (Arg1, 8)))
        }
        
        Method (B1B4, 4, NotSerialized)
        {
            Store (Arg3, Local0)
            Or (Arg2, ShiftLeft (Local0, 8), Local0)
            Or (Arg1, ShiftLeft (Local0, 8), Local0)
            Or (Arg0, ShiftLeft (Local0, 8), Local0)
            Return (Local0)
        }
        
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, 1)
            Field (ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Return (BYTE)
        }
        
        Method (RECB, 2, Serialized)
        {
            ShiftRight (Arg1, 3, Arg1)
            Name (TEMP, Buffer(Arg1) { })
            Add (Arg0, Arg1, Arg1)
            Store (0, Local0)
            While (LLess (Arg0, Arg1))
            {
                Store (RE1B (Arg0), Index (TEMP, Local0))
                Increment (Arg0)
                Increment (Local0)
            }
            Return (TEMP)
        }
        
        Method (WE1B, 2, NotSerialized)
        {
            OperationRegion (ERAM, EmbeddedControl, Arg0, 1)
            Field (ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Store (Arg1, BYTE)
        }
        
        Method (WECB, 3, Serialized)
        {
            ShiftRight (Add (Arg1,7), 3, Arg1)
            Name (TEMP, Buffer (Arg1) { })
            Store (Arg2, TEMP)
            Add (Arg0, Arg1, Arg1)
            Store (0, Local0)
            While (LLess (Arg0, Arg1))
            {
                WE1B (Arg0, DerefOf (Index (TEMP, Local0)))
                Increment (Arg0)
                Increment (Local0)
            }
        }
        
        OperationRegion (ECR1, EmbeddedControl, 0x00, 0x0100)
        Field (ECR1, ByteAcc, NoLock, Preserve)
        {
            Offset (0x84),
            SPD0, 8,SPD1, 8,
        }
        Field (ECR1, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BRC0, 8,BRC1, 8,
            BFC0, 8,BFC1, 8,
            BAC0, 8,BAC1, 8,
            BVO0, 8,BVO1, 8,
        }
        Field (ECR1, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BBM0, 8,BBM1, 8,
        }
        Field (ECR1, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BDC0, 8,BDC1, 8,
            BDV0, 8,BDV1, 8,
            BSN0, 8,BSN1, 8,
        }
        Field (ECR1, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),
            BCH0, 8,BCH1, 8,BCH2, 8,BCH3, 8,
        }
        
        Method (GBIF, 3, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            If (Arg2)
            {
                Or (Arg0, 0x01, HIID)
                Store (B1B2(BBM0,BBM1), Local7)
                ShiftRight (Local7, 0x0F, Local7)
                XOr (Local7, 0x01, Index (Arg1, 0x00))
                Store (Arg0, HIID)
                If (Local7)
                {
                    Multiply (B1B2 (BFC0, BFC1), 0x0A, Local1)
                }
                Else
                {
                    Store (B1B2 (BFC0, BFC1), Local1)
                }
                
                Store (Local1, Index (Arg1, 0x02))
                Or (Arg0, 0x02, HIID)
                If (Local7)
                {
                    Multiply (B1B2 (BDC0, BDC1), 0x0A, Local0)
                }
                Else
                {
                    Store (B1B2 (BDC0, BDC1), Local0)
                }
                
                Store (Local0, Index (Arg1, 0x01))
                Divide (Local1, 0x14, Local2, Index (Arg1, 0x05))
                If (Local7)
                {
                    Store (0xC8, Index (Arg1, 0x06))
                }
                ElseIf (B1B2 (BDV0, BDV1))
                {
                    Divide (0x00030D40,B1B2(BDV0, BDV1), Local2, Index (Arg1, 0x06))
                }
                Else
                {
                    Store (0x00, Index (Arg1, 0x06))
                }
                
                Store (B1B2 (BDV0, BDV1), Index (Arg1, 0x04))
                Store (B1B2 (BSN0, BSN1), Local0)
                Name (SERN, Buffer (0x06)
                {
                    "     "
                })
                Store (0x04, Local2)
                While (Local0)
                {
                    Divide (Local0, 0x0A, Local1, Local0)
                    Add (Local1, 0x30, Index (SERN, Local2))
                    Decrement (Local2)
                }
                
                Store (SERN, Index (Arg1, 0x0A))
                Or (Arg0, 0x06, HIID)
                Store (RECB(0xA0,128), Index (Arg1, 0x09))
                Or (Arg0, 0x04, HIID)
                Name (BTYP, Buffer (0x05)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00
                })
                Store (B1B4(BCH0,BCH1,BCH2,BCH3), BTYP)
                Store (BTYP, Index (Arg1, 0x0B))
                Or (Arg0, 0x05, HIID)
                Store (RECB(0xA0,128), Index (Arg1, 0x0C))
            }
            Else
            {
                Store (0xFFFFFFFF, Index (Arg1, 0x01))
                Store (0x00, Index (Arg1, 0x05))
                Store (0x00, Index (Arg1, 0x06))
                Store (0xFFFFFFFF, Index (Arg1, 0x02))
            }
            
            Release (BATM)
            Return (Arg1)
        }
        
        Method (GBST, 4, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            If (And (Arg1, 0x20))
            {
                Store (0x02, Local0)
            }
            ElseIf (And (Arg1, 0x40))
            {
                Store (0x01, Local0)
            }
            Else
            {
                Store (0x00, Local0)
            }
            
            If (And (Arg1, 0x07)){}
            Else
            {
                Or (Local0, 0x04, Local0)
            }
            
            If (LEqual (And (Arg1, 0x07), 0x07))
            {
                Store (0x04, Local0)
                Store (0x00, Local1)
                Store (0x00, Local2)
                Store (0x00, Local3)
            }
            Else
            {
                Store (Arg0, HIID)
                Store (B1B2 (BVO0, BVO1), Local3)
                If (Arg2)
                {
                    Multiply (B1B2 (BRC0, BRC1), 0x0A, Local2)
                }
                Else
                {
                    Store (B1B2 (BRC0, BRC1), Local2)
                }
                
                Store (B1B2 (BAC0, BAC1), Local1)
                If (LGreaterEqual (Local1, 0x8000))
                {
                    If (And (Local0, 0x01))
                    {
                        Subtract (0x00010000, Local1, Local1)
                    }
                    Else
                    {
                        Store (0x00, Local1)
                    }
                }
                ElseIf (LNot (And (Local0, 0x02)))
                {
                    Store (0x00, Local1)
                }
                
                If (Arg2)
                {
                    Multiply (Local3, Local1, Local1)
                    Divide (Local1, 0x03E8, Local7, Local1)
                }
            }
            
            Store (Local0, Index (Arg3, 0x00))
            Store (Local1, Index (Arg3, 0x01))
            Store (Local2, Index (Arg3, 0x02))
            Store (Local3, Index (Arg3, 0x03))
            Release (BATM)
            Return (Arg3)
        }
        
        Device (SMCD)
        {
            Name (_HID, "MON0000")
            Method (FAN0, 0, NotSerialized)
            {
                Store (B1B2 (\_SB.PCI0.LPC.EC.SPD0, \_SB.PCI0.LPC.EC.SPD1), Local0)
                Return (Local0)
            }
        }
    }
}