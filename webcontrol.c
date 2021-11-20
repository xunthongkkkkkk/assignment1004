#include <stdio.h>
#include <wiringPi.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

//gpio number
#define RED_LED 0
#define GREEN_LED 2

int main(int argc, char *argv[]){
    //if initialise wiringPi failed
    if(wiringPiSetup() == -1){
            printf("setup wiringPi failed");
            exit(1);
    }

    int LED_BUTTON = atoi(argv[1]); //return 0 is button is clicked
    int choice = atoi(argv[2]); //1. On light; 2. Blink; 3. Off light

    //set led as output mode and button as input mode
    pinMode(RED_LED, OUTPUT);
    pinMode(GREEN_LED, OUTPUT);

    printf("\nPress button to turn on LED.\n");

    //set led initially off light
    digitalWrite(RED_LED, HIGH);
    digitalWrite(GREEN_LED, HIGH);

    int tries = 0;
    int blinking = 1;

    for(;;){
        //if button has been pressed
        if(LED_BUTTON == 0){
            if(choice == 1){
                //on led light
                digitalWrite(RED_LED, LOW);
                digitalWrite(GREEN_LED, LOW);
                printf("\nLED is on.\n");
                printf("\nPress button to blink LED.\n");
                delay(500);
            }
            else if(choice == 2){
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
                    if(LED_BUTTON == 0){
                        blinking = 1;
                        break;
                    }
                }
            }
            else if(choice == 3){
                //off led light
                digitalWrite(RED_LED, HIGH);
                digitalWrite(GREEN_LED, HIGH);
                printf("\nLED is off.\n");
                printf("\nPress button to turn LED on.\n");
                delay(500);
            }
        }
    }    
    return 0;
}    