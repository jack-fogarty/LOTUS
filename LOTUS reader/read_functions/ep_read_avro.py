from avro.datafile import DataFileReader
from avro.io import DatumReader
import json
import csv
import os
import sys

# Path to 'participant data' for EmbracePlus dataset
avpath = sys.argv[1]
dtype  = sys.argv[2]

## Read Avro file
reader = DataFileReader(open(avpath, "rb"), DatumReader())
schema = json.loads(reader.meta.get('avro.schema').decode('utf-8'))
dat    = next(reader)

match dtype:
    case "acc":
        # Accelerometer
        acc      = dat["rawData"]["accelerometer"]
        x        = acc["x"]
        y        = acc["y"]
        z        = acc["z"]
        fs       = acc["samplingFrequency"]
        if fs == 0:
            fs = 64

        timept   = [round(acc["timestampStart"] + i * (1e6 / fs))
        for i in range(len(acc["x"]))]
    case "gyr":
        # Gyroscope
        gyro     = dat["rawData"]["gyroscope"]
        x        = gyro["x"]
        y        = gyro["y"]
        z        = gyro["z"]
        fs       = gyro["samplingFrequency"]
        if fs == 0:
            fs = 64

        timept   = [round(gyro["timestampStart"] + i * (1e6 / fs))
        for i in range(len(gyro["values"]))]
    case "eda":
        # Eda
        eda      = dat["rawData"]["eda"]
        data     = eda["values"]
        fs       = eda["samplingFrequency"]
        if fs == 0:
            fs = 4

        timept   = [round(eda["timestampStart"] + i * (1e6 / fs))
        for i in range(len(eda["values"]))]
    case "temp":
        # Temperature
        temp     = dat["rawData"]["temperature"]
        data     = temp["values"]
        fs       = temp["samplingFrequency"]
        if fs == 0:
            fs = 1

        timept   = [round(temp["timestampStart"] + i * (1e6 / fs))
        for i in range(len(temp["values"]))]
    case "tags":
        # Tags
        tags     = dat["rawData"]["tags"]
        data     = tags["tagsTimeMicros"]
        fs       = []
        timept   = []
    case "bvp":
        # BVP
        bvp      = dat["rawData"]["bvp"]
        data     = bvp["values"]
        fs       = bvp["samplingFrequency"]
        if fs == 0:
            fs = 64
            
        timept   = [round(bvp["timestampStart"] + i * (1e6 / fs))
        for i in range(len(bvp["values"]))]
    case "systp":
        # Systolic peaks
        sps      = dat["rawData"]["systolicPeaks"]
        data     = sps["peaksTimeNanos"]
        fs       = []
        timept   = []
    case "steps":
        # Steps
        steps    = dat["rawData"]["steps"]
        data     = steps["values"]
        fs       = steps["samplingFrequency"]
        # Cannot find this info at the moment
        #if fs == 0:
        #    fs = ?
        timept   = [round(steps["timestampStart"] + i * (1e6 / fs))
        for i in range(len(steps["values"]))]