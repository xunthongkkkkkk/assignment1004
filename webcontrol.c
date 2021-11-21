#include <stdio.h>
#include <wiringPi.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

//gpio number
#define RED_LED 0
#define GREEN_LED 2

void loops(int);

int main(int argc, char *argv[]){
    //if initialise wiringPi failed
    if(wiringPiSetup() == -1){
        printf("setup wiringPi failed");
        exit(1);
    }
    
    int LED_BUTTON = atoi(argv[1]); //return 0 is button is clicked
    int choice = atoi(argv[2]);
    //1. On Red light; 2. Blink Red Light; 3. Off Red light
    //4. On Green Light; 5. Blink Green Light; 6. Blink Green Light

    //set led as output mode and button as input mode
    pinMode(RED_LED, OUTPUT);
    pinMode(GREEN_LED, OUTPUT);

    //set led initially on light
    digitalWrite(RED_LED, HIGH);
    digitalWrite(GREEN_LED, HIGH);

    //if button has been pressed
    while(LED_BUTTON == 0){
        //for red led
        if(choice >= 1 && choice <= 3){
            digitalWrite(GREEN_LED, digitalRead(GREEN_LED));
            if(choice == 1){
                //on red led light
                digitalWrite(RED_LED, LOW);
                LED_BUTTON = 1;
                
            } else if(choice == 2){
                //blink red led light
                LED_BUTTON = 1;
                //call loops function such that if 2 or 5 has been passed as argument, 
                //red or green led will blink
                loops(2);

            } else{
                //off red led light
                digitalWrite(RED_LED, HIGH);
                LED_BUTTON = 1;
            }
        //for green led
        } else{
            digitalWrite(RED_LED, digitalRead(RED_LED));
            if(choice == 4){
                //on green led light
                digitalWrite(GREEN_LED, LOW);
                LED_BUTTON = 1;

            } else if(choice == 5){
                //blink green led light
                LED_BUTTON = 1;
                //call loops function such that if 2 or 5 has been passed as argument, 
                //red or green led will blink
                loops(5);

            } else if(choice == 6){
                //off green led light
                digitalWrite(GREEN_LED, HIGH);
                LED_BUTTON = 1;
                
            }
        }
    }
    return 0;
}
void loops(int choice){
    for(int i = 0; i < 2; i++){
        //if choice == 2, blink red led for 2 times
        if(choice == 2){
            digitalWrite(RED_LED, LOW);
            delay(500);
            digitalWrite(RED_LED, HIGH);
            delay(500);
            digitalWrite(RED_LED, LOW);
            delay(500);

        //if choice == 5, blink green led for 2 times
        } else if(choice == 5){
            digitalWrite(GREEN_LED, LOW);
            delay(500);
            digitalWrite(GREEN_LED, HIGH);
            delay(500);
            digitalWrite(GREEN_LED, LOW);
            delay(500);
        }
    }
}
