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
  Name: NumBytes.c
  Last update: 3/7/2019 by Raphael Van Hoffelen
  Author: Matthew Piccoli
  Contributors: Raphael Van Hoffelen
*/

#include "mex.h"
#include <string.h>

/* Gateway function */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double outbytes;
    char *outstring;


/* Check input arguments */
    
	if( nrhs != 1 ) {
        mexErrMsgTxt("NumBytes has exclusively one input.");
	}
	if( nlhs != 1 ) {
        mexErrMsgTxt("NumBytes has exclusively one output.");
	}
	if( !mxIsChar(prhs[0]) ) {
        mexErrMsgTxt("The first input argument must be a character array.");
	}
   
/* Check second input argument for desired output type */
   
   outstring = mxArrayToString(prhs[0]);

   if(        strcmp(outstring,"int8") == 0 ) {
       outbytes = 1;
   } else if( strcmp(outstring,"uint8") == 0 ) {
       outbytes = 1;
   } else if( strcmp(outstring,"int16") == 0 ) {
       outbytes = 2;
   } else if( strcmp(outstring,"uint16") == 0 ) {
       outbytes = 2;
   } else if( strcmp(outstring,"int32") == 0 ) {
       outbytes = 4;
   } else if( strcmp(outstring,"uint32") == 0 ) {
       outbytes = 4;
   } else if( strcmp(outstring,"int64") == 0 ) {
       outbytes = 8;
   } else if( strcmp(outstring,"uint64") == 0 ) {
       outbytes = 8;
   } else if( strcmp(outstring,"double") == 0 ) {
       outbytes = 8;
   } else if( strcmp(outstring,"single") == 0 ) {
       outbytes = 4;
   } else if( strcmp(outstring,"char") == 0 ) {
       outbytes = 2;
   } else if( strcmp(outstring,"logical") == 0 ) {
       outbytes = 1;
   } else {
       mxFree(outstring);
       mexErrMsgTxt("Unsupported class.\n");
   }
   mxFree(outstring);
   
   plhs[0] = mxCreateDoubleScalar(outbytes); 
}
