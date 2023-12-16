import os
import subprocess

chromedriverProcess = subprocess.Popen(["chromedriver" , "--port=4444"])
exitStatus = os.system(
    "flutter drive "
    "--driver=test_driver/integration_test_driver.dart "
    "--target integration_test/end_to_end_test/end_to_end_test.dart "
    "-d web-server "
    "--browser-name chrome "
    "--no-headless "
)
chromedriverProcess.terminate()
if exitStatus != 0:
    raise Exception("Integration test gagal!")