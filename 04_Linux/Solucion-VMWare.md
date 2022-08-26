## Debian

```bash
sudo vmware-modconfig --console --install-all
```

```bash
openssl req -new -x509 -newkey rsa:2048 -keyout VMWARE15.priv -outform DER -out VMWARE15.der -nodes -days 36500 -subj "/CN=VMWARE/"
```

```bash
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE15.priv ./VMWARE15.der $(modinfo -n vmmon)
```

```bash
$ sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE15.priv ./VMWARE15.der $(modinfo -n vmnet)
```

```bash
tail $(modinfo -n vmmon) | grep "Module signature appended"
```

```bash
sudo mokutil --import VMWARE15.der
```

now reboot

```bash
sudo reboot
```

```shell-session
Prompt will be show:
select enroll MOK
Continue
Yes
Enter your earlier password
Reboot
```

run below command after Reboot

```bash
mokutil --test-key VMWARE15.der
```

## RHEL


