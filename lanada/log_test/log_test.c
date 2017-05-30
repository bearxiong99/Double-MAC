/*
 * Copyright (c) 2006, Swedish Institute of Computer Science.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the Institute nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * This file is part of the Contiki operating system.
 *
 */

/**
 * \file
 *         A very simple Contiki application showing how Contiki programs look
 * \author
 *         Adam Dunkels <adam@sics.se>
 */

#include "contiki.h"
#include "cfs/cfs.h"

#include "../../core/sys/log_message.h"
#include <stdio.h> /* For printf() */
#include <string.h>
 
#define MAX_BLOCKSIZE 40
static int file = -1;
/*---------------------------------------------------------------------------*/
PROCESS(hello_world_process, "Hello world process");
AUTOSTART_PROCESSES(&hello_world_process);
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(hello_world_process, ev, data)
{
	static int fd = 0;
	static int block_size = MAX_BLOCKSIZE;
	char *filename = "log_test";
	int len;
	int offset = 0;
	char buf[MAX_BLOCKSIZE];

  PROCESS_BEGIN();
	PROCESS_EXITHANDLER(cfs_close(fd));

	fd = cfs_open(filename, CFS_READ);
			
	printf("Reading the log\n");
	
	if(fd < 0) {
		printf("Can't open the log file.\n");
	} 
	else {
		printf("LOG_START:");
		while(1) {
			cfs_seek(fd, offset, CFS_SEEK_SET);
			len = cfs_read(fd, buf, block_size);
			offset += block_size;
			if(len <= 0) {
				cfs_close(fd);
				break;
			}
			printf("%s", buf);
		}
		printf("\nLOG_END");
		PROCESS_EXIT();
	}

  /*-------------------------------------------------------------------------*/
	// log_initialization();
	// log_finisher();
	
	//LOG_MESSAGE("Hello, Joonki!! \n");
	char data1[40];
	char data2[40];
	char data3[40];
	int n1, n2, n3;
	strcpy (data1,"JOONKI HI\n");
	strcpy (data2,"JOONKI BYE\n");
	strcpy (data3,"JOONKI GRADUATE\n");

	file  = cfs_open("log_test", CFS_WRITE | CFS_APPEND);
	if(file != -1) {
		n1 = cfs_write(file,data1, 40);
		n2 = cfs_write(file,data2, 40);
		n3 = cfs_write(file,data3, 40);
		cfs_close(file);

		printf("Hello, world log written %d %d %d\n",n1, n2, n3);
	}
 	PROCESS_END();
}
/*---------------------------------------------------------------------------*/
