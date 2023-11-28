import os
import colorama

test_dirs = [
    #'',
    #"common",
    #r"fitur\fitur_auth_guard",
    r"fitur/fitur_input_form_data_barang",
    r"fitur/fitur_input_pengajuan",
    r"fitur/fitur_lihat_pengajuan",
    r"fitur/fitur_setting_akun"
]

for test_dir in test_dirs:
    owd = os.getcwd()
    if test_dir != '':
        os.chdir(test_dir)

    result = os.system(f"flutter test --tags=fast_test")
    if result == 0:
        print(colorama.Fore.GREEN + f"SUKSES : {test_dir}")
    else:
        print(colorama.Fore.RED + f"GAGAL : {test_dir}")
    os.chdir(owd)
