# The LOTUS Toolkit
The LOTUS toolkit features two GUIs built to read, compile, and analyse raw Empatica EmbracePlus data over user-defined periods of time (i.e., EDA, BVP, systolic peaks, temperature, accelerometer, and event tags).
The two GUI components include the LOTUS reader and analyser, which may be downloaded and used independently of one another.
1. **LOTUS Reader** can selectively reconstitute fragmented 'chunks' of raw  EmbracePlus data (i.e., avro files) as a continuous timeseries. Batch processing is enabled to allow users to reconstitute data across multiple subjects and multiple days.
2. **LOTUS analyser** allows users to visualise and navigate the raw signal data, edit event tags, and complete basic preprocessing.
<br>
Feedback and suggestions may be sent to: <a href="mailto:jack.fogarty@nie.edu.sg">jack.fogarty@nie.edu.sg</a>
<br>
<br>
🍻 Support this thirsty work <a href="https://ko-fi.com/jackfogarty">here</a>
<br>
<br>
<br>

# Citation
If using LOTUS reader or anlyser please reference:
<br>
<ul>Fogarty, J. S. (2024). LOTUS Software to Process Wearable EmbracePlus Data. Sensors, 24(23), 7462. https://doi.org/10.3390/s24237462
</ul>
<br>

# Installation
1. Install Matlab 2023b or later (a compiled version is available for users without Matlab)
2. Download and install python version 3.11.x prior to using LOTUS (https://www.python.org/downloads/)
3. Install the avro python library as recommended by Empatica using 'pip install avro'
4. Other python libraries (i.e., json, csv, and os) are also required but should be installed with python by default
<br>
<br>
**TIP:** Type <a href="https://www.mathworks.com/help/matlab/ref/pyenv.html">pyenv</a> into your Matlab command window to check the python version that your Matlab has access to.
<br>

 
# To use LOTUS
1. Start Matlab
2. Add the folder containing LOTUS_reader to the Matlab including subfolders
3. Type "LOTUS_reader" or "LOTUS_analyser" in the Matlab command window and press enter
4. Check the instructions PDF for GUI workflow
<br>

# Compiled version of LOTUS
It is possible to use LOTUS without Matlab but running a compiled version of the app. A compiled version of LOTUS can be made available to users upon request to: jack.fogarty@nie.edu.sg
<br>
<br>
<br> 
 
# Example of the LOTUS Reader - interface for compiling raw data
![Image](https://github.com/user-attachments/assets/7ea8cbb6-e104-417b-ba0e-d297941e6e8a)
<br>
<br>


# Example of the LOTUS Analyser - interface for editing tags
![LOTUS_analyser](https://github.com/user-attachments/assets/387b223c-6e6d-4e79-bd2f-704de76c86da)
