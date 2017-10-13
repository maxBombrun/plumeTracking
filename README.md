# PlumeTracking

Detects and parameterises volcanic plume in thermal videos.

Developped in Matlab.

## What it does

The program takes a list of thermal images (.mat format) as input and provides images of the segmentation of the mask of the plume as well as the contour overlayed on the original image.
It also extracts several parameters such as the height and the width of the plume through time.

The aim is to improve models for plume dynamics and automated monitoring in near-real time of volcanic eruptions.



## Usage

Modify the mainTrackPlume.m file to define the inputName variable, i.e., the absolute path of the data.
The format of the frames is supposed to be indexed:
- in numerical order, preferably with the same number of decimal. 
- in a clearly separated way from the name of the set by one of the following character: [',' ';' '_' '-' '.' ':'].

For example:
A dataset containing more than 100 frames should be named: 
exData_001.mat; exData_002.mat...

This algorithm requires two toolboxes:
- image_toolbox
- wavelet_toolbox



## Credits

This project was funded by the French Government Laboratory of Excellence initiative no. ANR-10-LABX-0006, the Région Auvergne and the European Regional Development Fund


## License 

    Copyright (c) 2013-2017, Maxime Bombrun
    All rights reserved.

    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:

      Redistributions of source code must retain the above copyright notice, this
      list of conditions and the following disclaimer.

      Redistributions in binary form must reproduce the above copyright notice, this
      list of conditions and the following disclaimer in the documentation and/or
      other materials provided with the distribution.

      Neither the name of the {organization} nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
    ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
