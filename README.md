AEOLUS SENSE
======

[AEOLUS SENSE](http://www.talosavionics.com/aeolus-sense/) is a device which contains sensors needed by A-EFIS (electronic flight information system for aircrafts) for the correct and reliable operation.

As distinct from A-EFIS, which shows data on mobile device, current project collects data from several AEOLUS devices and writes them on the external storage for further analysis!


Environment
-------

On this moment system correctly works on GNU/Linux, either Intel-based or ARM-based, and uses Lua 5.1.5 or higher, and can use LuaJIT 2.1 or  higher.  OpenWRT firmwares are also supported.


Configuration
-------

**Whole project configuration is done through environment variables!**

Project contains several modules. If module needs configuraton, it has its own environment variables. Following part of the document describes configuration variables, grouped along mudules their functionality.


Logging
-------

**AEOLUS_LOG** -- You can define of logging. By default: *false*.

**AEOLUS_LOG_PRINT** -- You can define to print on stdout (*true*) or write in file (*false* also usinig *lualogging* library). By default: *true*.

**AEOLUS_LOG_LEVEL** -- You can define one of following log levels: *debug*, *info*, *warn*, *error*, *fatal*. By default: *error*.

**AEOLUS_LOG_FILE** -- Defines file name for logging. By default: *aeolus.log*.

**AEOLUS_LOG_DIR** -- Defines path for log file. By default: *project_directory/var*.


Database
-------

**AEOLUS_DB_DRIVER** -- Defines driver name. You can define one of the following: *sqlite*, *mysql*, *postgresql*. By default: *sqlite*.


 * **SQLite**

    **AEOLUS_DB_NAME** -- Defines database name. By default: *aeolus*.

    **AEOLUS_DB_DIR** -- Defines path to databse. By default: *project_directory/var*.

 * **MySQL**

    **AEOLUS_DB_NAME** -- Defines database name. By default: *aeolus*.

 * **PostgreSQL**

    **AEOLUS_DB_NAME** -- Defines database name. By default: *aeolus*.


Server Receiver
-------

**AEOLUS_RECEIVER_TIMEOUT** -- Defines timeout for receiving in seconds. By default: *0.01*.

**AEOLUS_RECEIVER_IP** -- Defines IP address for receiving. By default: *127.0.0.1*.

**AEOLUS_RECEIVER_PORT** -- Defines port for receiving. By default: *5001*.

**AEOLUS_RECEIVER_SERVICE_PORT** -- Defines service port for operation of Aeolus device. By default: *5002*.


Server PCAP Emitter
-------

**AEOLUS_PCAP_EMITTER_TIMEOUT** -- Defines timeout for emmiting in seconds. By default: *0.01*.

**AEOLUS_PCAP_EMITTER_IP** -- Defines IP address for emmiting. By default: *127.0.0.1*.

**AEOLUS_PCAP_EMITTER_PORT** -- Defines port for emmiting. By default: *5001*.

**AEOLUS_PCAP_EMITTER_SERVICE_PORT** -- Defines service port for operation of Aeolus device. By default: *5002*.

**AEOLUS_PCAP_EMITTER_DATA_FILE** -- Defines name of the file with data. By default: *aeolus.pcap.data*.

**AEOLUS_PCAP_EMITTER_DATA_DIR** -- Defines path to file with data in text format. By default: *project_directory/var*.

**AEOLUS_PCAP_EMITTER_DATA_LOOP** -- When false, server imitator stops operation after emitter data file ends. When true, this file is read in the infinite cycle. By default: *false*.


Server Transmitter
-------

Server has REST API interface.


**AEOLUS_TRANSMITTER_IP** -- Define IP Address for transmitting. By default: *127.0.0.1*.

**AEOLUS_TRANSMITTER_PORT** -- Define port for transmitting. By default: *5000*.


Installation
-------

Locally:

    git clone https://github.com/che/aeolus
    cd ./aeolus
    luarocks make

Using LuaRocks:

    luarocks install aeolus-sense


Usage
-------

First of all you have to receive data from AEOLUS device with the dump command (**tcpdump -i lo -w file.pcap -s0 -vv udp**).
Resulted data are in binary file in PCAP format. Next step is to convet them into text-based HEX represention. It is done by **tshark** utility. This text file should be used as **AEOLUS_PCAP_EMITTER_DATA_FILE**.
Emitter is launced by the **aeolus-server-pcap-emitter** script.

The **aeolus-server-receiver** script listens specified port and address to get data from AEOLUS device.
The **aeolus-server-pcap-emitter** script emulates AEOLUS device based on the file saved with **aeolus-server-receiver** script.
**aeolus-server-transmitter** script runs server to get data from different AEOLUS devices with use of REST API and thus allows remote access to data previously read from sensors with **aeolus-server-receiver**.


License
-------

[![GPLv3](http://www.gnu.org/graphics/gplv3-88x31.png)](http://www.gnu.org/licenses/gpl-3.0.txt)

See also [LICENSE](LICENSE)
