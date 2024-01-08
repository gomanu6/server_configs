### Passthru disk to VM


qm set <vmid> 

# Old Drive
qm set 102 -scsi0 /dev/disk/by-id/ata-ST2000DM005-2CW102_ZFL4QG6L,serial=ZFL4QG6L
qm set 102 -scsi0 /dev/disk/by-id/ata-ST2000DM005_ZFL4QG6L,serial=ZFL4QG6L



# New drive (2023-12-19)
qm set 102 -scsi0 /dev/disk/by-id/ata-WDC_WD40EZAX-00C8UB0_WD-WXH2D23DXU2R,serial=WD-WXH2D23DXU2R


qm set 102 -scsi1 /dev/disk/by-id/ata-WDC_WD20EZRZ-00Z5HB0_WD-WCC4N1TP6TAS,serial=WD-WCC4N1TP6TAS


qm set 102 -scsi2 /dev/disk/by-id/ata-WDC_WD20PURZ-85GU6Y0_WD-WCC4M1YKZ0CL,serial=WD-WCC4M1YKZ0CL


# Disks for Raid 1
Crucial MX500 1000 GB

Model: CT1000MX500SSD1
Serial: 2323E6E0BFCE
Serial: 2323E6E0BF51

qm set 102 -scsi0 /dev/disk/by-id/ata-CT1000MX500SSD1_2323E6E0BFCE,serial=2323E6E0BFCE
qm set 102 -scsi1 /dev/disk/by-id/ata-CT1000MX500SSD1_2323E6E0BF51,serial=2323E6E0BF51
qm set 102 -scsi2 /dev/disk/by-id/ata-WDC_WD20PURZ-85GU6Y0_WD-WCC4M1YKZ0CL,serial=WD-WCC4M1YKZ0CL
qm set 102 -scsi3 /dev/disk/by-id/ata-WDC_WD40EZAX-00C8UB0_WD-WXH2D23DXU2R,serial=WD-WXH2D23DXU2R
