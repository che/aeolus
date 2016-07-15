Aeolus
======


Environment
-------

On this moment correctly works on GNU/Linux, OpenWRT for Lua 5.1, LuaJIT 2.1 and more.


Configuration
-------

**The entire project configuration only through environment variables!**

For each module exists its own environment variables if needed.

Logging
-------

**AEOLUS_LOG_LEVEL** -- You can only level define: *debug*, *info*, *warn*, *error*, *fatal*. By default: *error*.

**AEOLUS_LOG_FILE** -- Define file name for logging. By default: *aeolus.log*.

**AEOLUS_LOG_DIR** -- Define path for log file. By default: *<project_directory>/var*.


Database
-------

**AEOLUS_DB_DRIVER** -- Define driver name. You can only define: *sqlite*, *mysql*, *postgresql*. By default: *sqlite*.


 * ### SQLite

**AEOLUS_DB_NAME** -- Define database name. By default: *aeolus*.

**AEOLUS_DB_DIR** -- Define path to databse. By default: *<project_directory>/var*.

 * ### MySQL

**AEOLUS_DB_NAME** -- Define database name. By default: *aeolus*.

 * ### PostgreSQL

**AEOLUS_DB_NAME** -- Define database name. By default: *aeolus*.


Server Receiver
-------

**AEOLUS_RECEIVER_TIMEOUT** -- Define timeout for receiving. By default: *0.01* (seconds).

**AEOLUS_RECEIVER_IP** -- Define IP Address for receiving. By default: *127.0.0.1*.

**AEOLUS_RECEIVER_PORT** -- Define port for receiving. By default: *5001*.

**AEOLUS_RECEIVER_SERVICE_PORT** -- Define service port for operation of Aeolus device. By default: *5002*.


Server PCAP Emmiter
-------

**AEOLUS_PCAP_EMMITER_TIMEOUT** -- Define timeout for receiving. By default: *0.01* (seconds).

**AEOLUS_PCAP_EMMITER_IP** -- Define IP Address for receiving. By default: *127.0.0.1*.

**AEOLUS_PCAP_EMMITER_PORT** -- Define port for receiving. By default: *5001*.

**AEOLUS_PCAP_EMMITER_SERVICE_PORT** -- Define service port for operation of Aeolus device. By default: *5002*.

**AEOLUS_PCAP_EMMITER_DATA_FILE** -- Define file name with data. By default: *aeolus.pcap.data*.

**AEOLUS_PCAP_EMMITER_DATA_DIR** -- Define path to data file. By default: *<project_directory>/var*.

**AEOLUS_PCAP_EMMITER_DATA_LOOP** -- By default: *false*.


Server Emmiter
-------

**AEOLUS_EMMITER_IP** -- Define IP Address for receiving. By default: *127.0.0.1*.

**AEOLUS_EMMITER_PORT** -- Define port for emmiting. By default: *5000*.


In progress.


License
-------

[![GPLv3](http://www.gnu.org/graphics/gplv3-88x31.png)](http://www.gnu.org/licenses/gpl-3.0.txt)

See also [LICENSE](LICENSE)
