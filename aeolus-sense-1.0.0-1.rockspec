package = "aeolus-sense"
version = "1.0.0-1"

source = {
    url = "https://github.com/che/aeolus/archive/master.tar.gz"
}

description = {
    summary = "Servers for AEOLUS SENSE devices",
    detailed = [[
        AEOLUS SENSE is a device which contains sensors needed
        by A-EFIS (electronic flight information system for aircrafts)
        for the correct and reliable operation.

        As distinct from A-EFIS, which shows data on device,
        current project collects data from several AEOLUS devices
        and writes them on the external storage for further analysis.
    ]],
    homepage = "https://github.com/che/aeolus",
    maintainer = "pavel.chebotarev@gmail.com",
    license = "GPL-3"
}

dependencies = {
    "lua >= 5.1.5",
    "luasocket ~> 3.0",
    "luasql-sqlite3 >= 2.3.0",
    "lpack"
}

build = {
    type = "builtin",
    modules = {
        ["aeolus"] = "lib/aeolus.lua",
        ["aeolus.data"] = "lib/aeolus/data.lua",
        ["aeolus.data.accel"] = "lib/aeolus/data/accel.lua",
        ["aeolus.data.aeolusinfo"] = "lib/aeolus/data/aeolusinfo.lua",
        ["aeolus.data.attitude"] = "lib/aeolus/data/attitude.lua",
        ["aeolus.data.calibinfo"] = "lib/aeolus/data/calibinfo.lua",
        ["aeolus.data.command"] = "lib/aeolus/data/command.lua",
        ["aeolus.data.compass"] = "lib/aeolus/data/compass.lua",
        ["aeolus.data.debuginfo"] = "lib/aeolus/data/debuginfo.lua",
        ["aeolus.data.gps"] = "lib/aeolus/data/gps.lua",
        ["aeolus.data.gyro"] = "lib/aeolus/data/gyro.lua",
        ["aeolus.data.info"] = "lib/aeolus/data/info.lua",
        ["aeolus.data.log"] = "lib/aeolus/data/log.lua",
        ["aeolus.data.magnet"] = "lib/aeolus/data/magnet.lua",
        ["aeolus.data.pressure"] = "lib/aeolus/data/pressure.lua",
        ["aeolus.data.te"] = "lib/aeolus/data/te.lua",
        ["aeolus.data.temp"] = "lib/aeolus/data/temp.lua",
        ["aeolus.data.toast"] = "lib/aeolus/data/toast.lua",
        ["aeolus.data.wind"] = "lib/aeolus/data/wind.lua",
        ["aeolus.data.wp"] = "lib/aeolus/data/wp.lua",
        ["aeolus.db"] = "lib/aeolus/db.lua",
        ["aeolus.db.driver"] = "lib/aeolus/db/driver.lua",
        ["aeolus.db.driver.mysql"] = "lib/aeolus/db/driver/mysql.lua",
        ["aeolus.db.driver.postgresql"] = "lib/aeolus/db/driver/postgresql.lua",
        ["aeolus.db.driver.sqlite"] = "lib/aeolus/db/driver/sqlite.lua",
        ["aeolus.db.table"] = "lib/aeolus/db/table.lua",
        ["aeolus.db.table.data"] = "lib/aeolus/db/table/data.lua",
        ["aeolus.db.table.data.accel"] = "lib/aeolus/db/table/data/accel.lua",
        ["aeolus.db.table.data.aeolusinfo"] = "lib/aeolus/db/table/data/aeolusinfo.lua",
        ["aeolus.db.table.data.attitude"] = "lib/aeolus/db/table/data/attitude.lua",
        ["aeolus.db.table.data.calibinfo"] = "lib/aeolus/db/table/data/calibinfo.lua",
        ["aeolus.db.table.data.command"] = "lib/aeolus/db/table/data/command.lua",
        ["aeolus.db.table.data.compass"] = "lib/aeolus/db/table/data/compass.lua",
        ["aeolus.db.table.data.debuginfo"] = "lib/aeolus/db/table/data/debuginfo.lua",
        ["aeolus.db.table.data.gps"] = "lib/aeolus/db/table/data/gps.lua",
        ["aeolus.db.table.data.gyro"] = "lib/aeolus/db/table/data/gyro.lua",
        ["aeolus.db.table.data.info"] = "lib/aeolus/db/table/data/info.lua",
        ["aeolus.db.table.data.log"] = "lib/aeolus/db/table/data/log.lua",
        ["aeolus.db.table.data.magnet"] = "lib/aeolus/db/table/data/magnet.lua",
        ["aeolus.db.table.data.pressure"] = "lib/aeolus/db/table/data/pressure.lua",
        ["aeolus.db.table.data.te"] = "lib/aeolus/db/table/data/te.lua",
        ["aeolus.db.table.data.temp"] = "lib/aeolus/db/table/data/temp.lua",
        ["aeolus.db.table.data.toast"] = "lib/aeolus/db/table/data/toast.lua",
        ["aeolus.db.table.data.wind"] = "lib/aeolus/db/table/data/wind.lua",
        ["aeolus.db.table.data.wp"] = "lib/aeolus/db/table/data/wp.lua",
        ["aeolus.db.table.emmiter"] = "lib/aeolus/db/table/emmiter.lua",
        ["aeolus.env"] = "lib/aeolus/env.lua",
        ["aeolus.log"] = "lib/aeolus/log.lua",
        ["aeolus.server"] = "lib/aeolus/server.lua",
        ["aeolus.server.pcap_emitter"] = "lib/aeolus/server/pcap_emitter.lua",
        ["aeolus.server.receiver"] = "lib/aeolus/server/receiver.lua",
        ["aeolus.server.transmitter"] = "lib/aeolus/server/transmitter.lua",
        ["aeolus-server-receiver"] = "bin/aeolus-server-receiver.lua",
        ["aeolus-server-transmitter"] = "bin/aeolus-server-transmitter.lua",
        ["aeolus-server-pcap-emitter"] = "bin/aeolus-server-pcap-emitter.lua"
    },
    install = {
        bin = {
            ["aeolus-server-receiver"] = "bin/aeolus-server-receiver",
            ["aeolus-server-transmitter"] = "bin/aeolus-server-transmitter",
            ["aeolus-server-pcap-emitter"] = "bin/aeolus-server-pcap-emitter",
            ["aeolus-pcap-data-gen"] = "bin/aeolus-pcap-data-gen"
        }
    }
}
