#include <stdio.h>
#include <wiringPi.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

//gpio number
#define LED_BUTTON 27
#define RED_LED 0
#define GREEN_LED 2

int main(void){
    //if initialise wiringPi failed
    if(wiringPiSetup() == -1){
            printf("setup wiringPi failed");
            exit(1);
    }

    //set led as output mode and button as input mode
    pinMode(RED_LED, OUTPUT);
    pinMode(GREEN_LED, OUTPUT);
    pinMode(LED_BUTTON, INPUT);

    //make button pull up to 3.3 voltage
    pullUpDnControl(LED_BUTTON, PUD_UP);

    printf("\nPress button to turn on LED.\n");

    //set led initially off light
    digitalWrite(RED_LED, HIGH);
    digitalWrite(GREEN_LED, HIGH);

    int tries = 0;
    int blinking = 1;

    for(;;){
        //if button has been pressed
        if(digitalRead(LED_BUTTON) == 0){
            if(digitalRead(RED_LED) == HIGH && tries == 0){
                //on led light
                digitalWrite(RED_LED, LOW);
                digitalWrite(GREEN_LED, LOW);
                tries = 1;
                printf("\nLED is on.\n");
                printf("\nPress button to blink LED.\n");
                delay(500);
            }
            else if(tries == 1){
                //blink led light
                blinking = 0;
                printf("\nLED is blinking.\n");
                printf("\nPress button to turn off LED.\n");
                while(blinking == 0){
                digitalWrite(RED_LED, LOW);
                digitalWrite(GREEN_LED, LOW);
                delay(500);
                digitalWrite(RED_LED, HIGH);
                digitalWrite(GREEN_LED, HIGH);
                delay(500);
                    if(digitalRead(LED_BUTTON) == 0){
                        blinking = 1;
                        break;
                    }
                }
                tries = 2;
            }
            else if(tries == 2){
                //off led light
                digitalWrite(RED_LED, HIGH);
                digitalWrite(GREEN_LED, HIGH);
                tries = 0;
                printf("\nLED is off.\n");
                printf("\nPress button to turn LED on.\n");
                delay(500);
            }
        }
    }    
    return 0;
}    