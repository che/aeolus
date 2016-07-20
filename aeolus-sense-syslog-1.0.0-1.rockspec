package = "aeolus-sense-syslog"
version = "1.0.0-1"

source = {
    url = ""
}

description = {
    summary = "Logging for AEOLUS SENSE devices",
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
    "lualogging >= 1.3.0"
}

build = {
    type = "builtin",
    modules = {}
}
