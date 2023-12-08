import os

with open("py_script/backend_dir") as f:
    netCoreWebDir = f.read()

result = os.system("flutter build web")
if result == 1:
    raise Exception("Gagal membuild flutter web")

os.system(f"rm -r {netCoreWebDir}")
os.system(f"cp -r build/web/ {netCoreWebDir}")