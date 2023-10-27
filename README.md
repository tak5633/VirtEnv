# VirtEnv

Python virtual environment scripts.

# Linux

Create symbolic links to `pip.conf` and `requirements.txt`.

```sh
ln -s /absolute/path/to/target/pip.conf pip.conf
ln -s /absolute/path/to/target/requirements.txt requirements.txt
```

Creating the virtual environment.

```sh
./Create.sh
./Update.sh
source ./VirtEnv/bin/activate
```

Installing a new package.

```sh
./Install.sh [PackageName]
```

Capturing the virtual environment.

```sh
./Freeze.sh
```

pip.conf example:

```ini
[global]
cert = /absolute/path/to/TargetCert.crt
```

# Windows

Create hard links to `pip.conf` and `requirements.txt`.

```ps1
New-Item -ItemType HardLink -Path "pip.conf" -Target "D:\absolute\path\to\target\pip.conf"
New-Item -ItemType HardLink -Path "requirements.txt" -Target "D:\absolute\path\to\target\requirements.txt"
```

Creating the virtual environment.

```ps1
./Create.ps1
./Update.ps1
./VirtEnv/Scripts/activate
```

Installing a new package.

```ps1
./Install.ps1 [PackageName]
```

Capturing the virtual environment.

```ps1
./Freeze.ps1
```

pip.conf example:

```ini
[global]
cert = D:\absolute\path\to\TargetCert.crt
```
