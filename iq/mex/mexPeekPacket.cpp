/*
  Copyright 2019 IQinetics Technologies, Inc support@iq-control.com

  This file is part of the IQ Matlab API.

  IQ Matlab API is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  IQ Matalb API is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/*
  Name: mexPeekPacket.cpp
  Last update: 3/7/2019 by Raphael Van Hoffelen
  Author: Matthew Piccoli
  Contributors: Raphael Van Hoffelen
*/

#include "mex.h"
#include <string.h>

#include "crc_helper.h"
#include "packet_finder.h"
#include "byte_queue.h"

#define PF_INDEX_DATA_SIZE 20   // size of index buffer in packet_finder

//#define DEBUG 1

static struct ByteQueue pf_index_queue;
static struct PacketFinder pf;      // packet_finder instance

static uint8_t pf_index_data[PF_INDEX_DATA_SIZE];    // data for pf

static int initialized = false;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  
    if ( nrhs < 1 ) {
      mexErrMsgTxt( "Need input buffer data\n" );
    }
  
    if ( !mxIsClass(prhs[0],"uint8") ) {
      mexErrMsgTxt( "Input buffer must by of type uint8\n" );
    }

    // If the bytequeue and packet finder haven't been initialized then initialize them 
    if ( !initialized ) {
      InitBQ(&pf_index_queue, pf_index_data, PF_INDEX_DATA_SIZE);
      InitPacketFinder(&pf, &pf_index_queue);
      initialized = true;
    }

    // Get length of the buffer
    int buflen = mxGetM(prhs[0]);
    if (buflen > 255) { 
      mexErrMsgTxt( "Length of input buffer is too long, tell Uriah to fix this code \n" );
    }
   
    // Get Buffer ... hopefully this is robust 
    uint8_t *buf = (uint8_t*)mxGetPr( prhs[0] );
    // Put bytes from buffer into byte queue
    uint8_t status = PutBytes( &pf, buf, buflen );

    #ifdef DEBUG
    mexPrintf("buflen: %d\n", buflen);
    for (uint8_t i=0; i<buflen; i++){
      mexPrintf("data[%d]: %d\n", i, buf[i]);
    }
    mexPrintf("status: %d\n", status);
    #endif

    // Peek Packet Finder and see if there is a valid packet to be found
    // if so, copy and return this data
    uint8_t *rx_data;
    uint8_t rx_len;
    uint8_t msg_type;    
    uint8_t *msg_data;    

    if ( PeekPacket(&pf, &rx_data, &rx_len) ) { 
      #ifdef DEBUG
	mexPrintf("Packet found\n");
	mexPrintf("rx_len: %d\n", rx_len);
	for (uint8_t i=0; i<rx_len; i++){
	  mexPrintf("rx_data[%d]: %d\n", i, rx_data[i]);
	}
      #endif

      int dims[2] = {1,rx_len};
      plhs[0] = mxCreateNumericArray(2, dims, mxUINT8_CLASS, mxREAL);
      uint8_t *packet = (uint8_t*)mxGetPr(plhs[0]);
      memcpy( packet, rx_data, rx_len );
      DropPacket(&pf);
    } else {
      int dims[2] = {1,0};
      plhs[0] = mxCreateNumericArray(2, dims, mxUINT8_CLASS, mxREAL);
    }
}
