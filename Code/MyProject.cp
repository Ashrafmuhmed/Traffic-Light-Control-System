#line 1 "D:/CCE/CCE Year 2/Summer College training/Final Embedded project/Code/MyProject.c"
int counter ;
char display[]={0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20};
#line 18 "D:/CCE/CCE Year 2/Summer College training/Final Embedded project/Code/MyProject.c"
void manualAutoCheck();
void automaticMode();
void manualMode();
 void main(){
 ADCON1=0x07;

 trisd = trisc = trisb = 0x00;
 portd = portc = portb = 0 ;
  portc.B0  = 1 ;
  portc.B3  = 1 ;

 trisA.b0 = trisA.b1 = 1;


 while(1){
 if( porta.B0  == 0)
 {
 automaticMode();
 }
 else if( porta.B1  ==0)
 {
 manualMode();
 }
 }
 }

 void manualAutoCheck()
 {
  portd.B0  =  portd.B1  = 0 ;
 if( porta.B1  == 0 &&  porta.B0  != 0 )
 {
 manualMode();
 }
 else
 {
 return ;
 }
 }

 void automaticMode()
 {
  portd.B0  =  portd.B1  = 1 ;
 if( portc.B3  == 1)
 {
 counter = 12 ;
 while(counter>=0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B3  = 0 ;
  portc.B4  = 1 ;
 counter = 3 ;
 while(counter>=0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B2  =  portc.B5  = 1 ;
  portc.B4  =  portc.B0  = 0 ;
 }
 else
 {
 counter = 20 ;
 while(counter >= 0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B1  = 1 ;
  portc.B2  = 0 ;
 counter = 3 ;
 while(counter >= 0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B1  =  portc.B5  = 0 ;
  portc.B0  =  portc.B3  = 1 ;
 }
 manualAutoCheck();
 }

 void manualMode()
 {
  portd.B0  =  portd.B1  = 1 ;
 if( portc.B3  == 1)
 {
  portc.B3  = 0 ;
  portc.B4  = 1 ;
 counter = 3 ;
 while(counter>=0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B2  =  portc.B5  = 1 ;
  portc.B4  =  portc.B0  = 0 ;
 }
 else if( porta.B1  == 0)
 {
  portc.B1  = 1 ;
  portc.B2  = 0 ;
 counter = 3 ;
 while(counter >= 0)
 {
 portb = display[counter-1];
 delay_ms(350);
 counter--;
 }
  portc.B1  =  portc.B5  = 0 ;
  portc.B0  =  portc.B3  = 1 ;
 }
  portd.B0  =  portd.B1  = 0 ;
 }
