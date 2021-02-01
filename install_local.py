#!/usr/bin/env python

import glob
import json
import os
import shutil
import sys

if __name__ == '__main__':
    with open("info.json") as fin:
        info_json = json.load(fin)
        version = info_json['version']
        zip_prefix = info_json['name']

    expected_ending = version + ".zip"
        
    new_versions = glob.glob(zip_prefix + "*")
    new_versions.sort(key=os.path.getmtime)
    if len(new_versions) == 0:
        raise FileNotFoundError("Cannot find a version of " + zip_prefix + " to install")

    latest_version = new_versions[-1]
    if not latest_version.endswith(expected_ending):
        raise ValueError("Expected version " + version + " but found " + latest_version)
    print("Installing " + latest_version)

    dest = "../../../AppData/Roaming/Factorio/mods"
    
    existing = glob.glob(os.path.join(dest, zip_prefix + "*"))
    if len(existing) > 0:
        print("Removing existing versions: " + " ".join(existing))
        for i in existing:
            os.unlink(i)

    shutil.copy(latest_version, os.path.join(dest, latest_version))
