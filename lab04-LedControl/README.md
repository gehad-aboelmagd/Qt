# RPI LED CONTROL 🚨✨

### Steps
1. Preparing project
```
$ tar -czf my_qt_app.tar.gz backend.cpp backend.h main.cpp Main.qml CMakeLists.txt
```

2. Preparing RPI(installing Raspberrian OS & qt staff)
```
$ sudo apt update
$ sudo apt install qt6-base-dev qt6-tools-dev qt6-tools-dev-tools
$ sudo apt install qml6-module-qtquick qt6-declarative-dev
```

3. Receiving fiels:
```
$ minicom -b 115200 -o -D /dev/ttyUSB0
$ sudo apt install lrzsz
$ rz
Ctrl + A → S → zmodem → my_qt_app.tar.gz
```

4. Building project
```
$ tar -xzf my_qt_app.tar.gz && cd my_qt_app
$ mkdir build && cd build
$ cmake ..
$ make -j1
```

https://github.com/user-attachments/assets/8c53d78b-173b-426d-944a-4be517aec75c

5. Running the app: Access a bash through the GUI
```
$ ./appRPI_LED_Control
```
