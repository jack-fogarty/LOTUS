from avro.datafile import DataFileReader
from avro.io import DatumReader
import json
import csv
import os

# Path to 'participant data' and desired output folder for EmbracePlus dataset
data_file_path = "C:\\Users\\jfogarty\\Desktop\\Matlab\\Empatica Data\\ACRF STUDY\\1\\participant_data\\" 
output_dir = "C:\\Users\\jfogarty\\Desktop\\Matlab\\Empatica Data\\ACRF STUDY\\1\\matlab_output\\" 

# List of days (folder names)
day_folders = os.listdir(data_file_path)

# for each day go in and...get a participant list...
for d in day_folders:
    sub_folders = os.listdir(data_file_path + d + '/')

    # for each subject...get a list of the avro files...
    for s in sub_folders:
        avro_files = os.listdir(data_file_path + d + '/' + s + '/raw_data/v6/')

        # For each avro file...create output directory...output avro to csv...
        newpath = output_dir + d + '/' + s + '/'
        if not os.path.exists(newpath):
            os.makedirs(newpath)

        for a in avro_files:

            # Path to selected avro file
            avpath = data_file_path + d + '/' + s + '/raw_data/v6/' + a


            ## Read Avro file
            reader = DataFileReader(open(avpath, "rb"), DatumReader())
            schema = json.loads(reader.meta.get('avro.schema').decode('utf-8'))
            data= next(reader)

            ## Print the Avro schema
            #print(schema)
            #print(" ")

            ## Export sensors data to csv files
            # Accelerometer
            acc = data["rawData"]["accelerometer"]
            timestamp = [round(acc["timestampStart"] + i * (1e6 / acc["samplingFrequency"]))
            for i in range(len(acc["x"]))]
            with open(os.path.join(newpath, 'accelerometer-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "x", "y", "z"])
                writer.writerows([[ts, x, y, z] for ts, x, y, z in zip(timestamp, acc["x"], acc["y"], acc["z"])])

            # Gyroscope
            gyro = data["rawData"]["gyroscope"]
            timestamp = [round(gyro["timestampStart"] + i * (1e6 / gyro["samplingFrequency"]))
            for i in range(len(gyro["x"]))]
            with open(os.path.join(newpath, 'gyroscope-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "x", "y", "z"])
                writer.writerows([[ts, x, y, z] for ts, x, y, z in zip(timestamp, gyro["x"], gyro["y"], gyro["z"])])

            # Eda
            eda = data["rawData"]["eda"]
            timestamp = [round(eda["timestampStart"] + i * (1e6 / eda["samplingFrequency"]))
            for i in range(len(eda["values"]))]
            with open(os.path.join(newpath, 'eda-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "eda"])
                writer.writerows([[ts, eda] for ts, eda in zip(timestamp, eda["values"])])

            # Temperature
            tmp = data["rawData"]["temperature"]
            timestamp = [round(tmp["timestampStart"] + i * (1e6 / tmp["samplingFrequency"]))
            for i in range(len(tmp["values"]))]
            with open(os.path.join(newpath, 'temperature-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "temperature"])
                writer.writerows([[ts, tmp] for ts, tmp in zip(timestamp, tmp["values"])])

            # Tags
            tags = data["rawData"]["tags"]
            with open(os.path.join(newpath, 'tags-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["tags_timestamp"])
                writer.writerows([[tag] for tag in tags["tagsTimeMicros"]])

            # BVP
            bvp = data["rawData"]["bvp"]
            timestamp = [round(bvp["timestampStart"] + i * (1e6 / bvp["samplingFrequency"]))
            for i in range(len(bvp["values"]))]
            with open(os.path.join(newpath, 'bvp-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "bvp"])
                writer.writerows([[ts, bvp] for ts, bvp in zip(timestamp, bvp["values"])])

            # Systolic peaks
            sps = data["rawData"]["systolicPeaks"]
            with open(os.path.join(newpath, 'systolic_peaks-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["systolic_peak_timestamp"])
                writer.writerows([[sp] for sp in sps["peaksTimeNanos"]])

            # Steps
            steps = data["rawData"]["steps"]
            timestamp = [round(steps["timestampStart"] + i * (1e6 / steps["samplingFrequency"]))
            for i in range(len(steps["values"]))]
            with open(os.path.join(newpath, 'steps-' + a[-15:-5] + '.csv'), 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["unix_timestamp", "steps"])
                writer.writerows([[ts, step] for ts, step in zip(timestamp, steps["values"])])