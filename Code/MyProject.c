int counter ;
char display[]={0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20};
#define redWest portc.B0
#define yellowWest portc.B1
#define greenWest portc.B2

#define redSouth portc.B5
#define yellowSouth portc.B4
#define greenSouth portc.B3

#define autoFlag porta.B0
#define manualFlag porta.B1

#define westSeg portd.B0
#define southSeg portd.B1


void manualAutoCheck();
void automaticMode();
void manualMode();
 void main(){
      ADCON1=0x07; //or ADCON1=0x06; for using PortA & PortE as Digital Pins
 
      trisd = trisc = trisb = 0x00;
      portd = portc = portb = 0  ;
      redWest = 1 ;
      greenSouth = 1 ;
 
      trisA.b0 = trisA.b1 = 1;


      while(1){ // count from 0 to 9 and repeat
                if(autoFlag == 0)
                {
                  automaticMode();
                 }
                 else if(manualFlag ==0)
                 {
                  manualMode();
                 }
 }
 }
 
  void manualAutoCheck()
 {
       westSeg = southSeg = 0 ;
       if(manualFlag == 0 && autoFlag != 0 )
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
      westSeg = southSeg = 1 ;
      if(greenSouth == 1)
      {
           counter = 12 ;
          while(counter>=0)
          {
           portb = display[counter-1];
           delay_ms(350);
           counter--;
           }
           greenSouth = 0 ;
           yellowSouth = 1 ;
           counter = 3 ;
           while(counter>=0)
           {
            portb = display[counter-1];
            delay_ms(350);
            counter--;
            }
            greenWest = redSouth = 1 ;
            yellowSouth = redWest = 0 ;
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
             yellowWest = 1 ;
             greenWest = 0 ;
             counter = 3 ;
             while(counter >= 0)
             {
              portb = display[counter-1];
              delay_ms(350);
              counter--;
              }
              yellowWest = redSouth = 0 ;
              redWest = greenSouth = 1 ;
      }
  manualAutoCheck();
 }

 void manualMode()
 {
      westSeg = southSeg = 1 ;
      if(greenSouth == 1)
      {
              greenSouth = 0 ;
              yellowSouth = 1 ;
              counter = 3 ;
              while(counter>=0)
              {
                 portb = display[counter-1];
                 delay_ms(350);
                 counter--;
              }
              greenWest = redSouth = 1 ;
              yellowSouth = redWest = 0 ;
      }
      else if(manualFlag == 0)
      {
               yellowWest = 1 ;
               greenWest = 0 ;
               counter = 3 ;
               while(counter >= 0)
               {
                   portb = display[counter-1];
                   delay_ms(350);
                   counter--;
               }
               yellowWest = redSouth = 0 ;
               redWest = greenSouth = 1 ;
  }
  westSeg = southSeg = 0 ;
 }