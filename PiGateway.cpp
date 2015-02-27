/*
 The MySensors library adds a new layer on top of the RF24 library.
 It handles radio network routing, relaying and ids.

 Created  by OUJABER Mohamed <m.oujaber@gmail.com>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 version 2 as published by the Free Software Foundation.
*/
 
#include <stdio.h>
#include "MyGateway.h"
#include <RF24.h>
#include <RF24ComVUsb.h>

MyGateway *gw;
RF24ComVUsb com_vusb;
RF24Frontend rf24_device(com_vusb);

void msgCallback(char *msg){
	printf("[CALLBACK]%s", msg);

}

void setup(void)
{
	printf("Starting Gateway...\n");
	gw = new MyGateway(rf24_device, 30000);
	
	if (gw == NULL)
    {
        printf("gw is null!");
    }
    gw->begin(RF24_PA_LEVEL_GW, RF24_CHANNEL, RF24_DATARATE, &msgCallback);
}

void loop(void)
{
 	gw->processRadioMessage();
}

int main(int argc, char** argv) 
{
	setup();
	while(1)
		loop();
	
	return 0;
}
