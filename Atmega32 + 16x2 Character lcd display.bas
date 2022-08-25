'======================================================================='

' Title: LCD Display frequency meter
' Last Updated :  01.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega32 + 16x2 Character lcd display

'======================================================================='

$regfile = "m32def.dat"
$crystal = 8000000

Config Lcd = 16 * 2
Config Lcdpin = Pin , Rs = Porta.0 , E = Porta.1 , Db4 = Porta.2 , Db5 = _
Porta.3 , Db6 = Porta.4 , Db7 = Porta.5
Cursor Off

Config Timer1 = Counter , Edge = Rising
Ddrb.1 = 0
Portb.1 = 1

Config Timer0 = Timer , Prescale = 1024

Enable Timer1
Enable Timer0
Enable Interrupts

On Ovf1 Pulse_counter
On Ovf0 Main

Dim A As Long
Dim B As Byte
Dim I As Long
B = 0

'-----------------------------------------------------------

Cls
Start Timer0
Do
Loop
End                                                         'end program

''''''''''''''''''''''''''''''

Main:
Incr I
If I > 30 Then
Stop Timer0
Cls
Home
A = B * 65536
A = A + Counter1
Lcd "frequency:"
Locate 2 , 1
Lcd A ; " HZ"

B = 0
I = 0
Counter1 = 0
Start Timer0
End If
Return

''''''''''''''''''''''''''''''

Pulse_counter:
Incr B
Counter1 = 0
Return

'-----------------------------------------------------------

