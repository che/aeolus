
AEOLUS_CURRENT_DIR="$(cd $(dirname "$0") && pwd -P)/"
AEOLUS_PACKGES_DIR="${AEOLUS_CURRENT_DIR}packages/"
AEOLUS_PACKGES_CONFIG_FILE="${AEOLUS_PACKGES_DIR}.config"
AEOLUS_BUILD_DIR="${AEOLUS_CURRENT_DIR}build/"

OPENWRT_GIT_PROJECT="openwrt"
OPENWRT_GIT_BRANCH="master"  # chaos_calmer
OPENWRT_GIT_URL="https://github.com/openwrt/${OPENWRT_GIT_PROJECT}/archive/${OPENWRT_GIT_BRANCH}.tar.gz"
OPENWRT_BUILD_DIR="${AEOLUS_BUILD_DIR}${OPENWRT_GIT_PROJECT}-${OPENWRT_GIT_BRANCH}/"
OPENWRT_BUILD_PACKAGES_DIR="${OPENWRT_BUILD_DIR}feeds/packages/lang/"


# Clean
if [ -e "$AEOLUS_BUILD_DIR" ]
then
    if [ -d "$AEOLUS_BUILD_DIR" ]
    then
        rm -rf "$AEOLUS_BUILD_DIR"
    else
        rm -f "$AEOLUS_BUILD_DIR"
    fi
fi


# Get source code
mkdir "$AEOLUS_BUILD_DIR"
cd "$AEOLUS_BUILD_DIR"

curl -SL "$OPENWRT_GIT_URL" | tar -xz
cd "$OPENWRT_BUILD_DIR"


# Prepare packages
./scripts/feeds update -a

for pkg_dir in $(ls "$AEOLUS_PACKGES_DIR")
do
    if [ -e "$OPENWRT_BUILD_PACKAGES_DIR" ]
    then
        if [ ! -e "${OPENWRT_BUILD_PACKAGES_DIR}${pkg_dir}" ]
        then
            cp -r "${AEOLUS_PACKGES_DIR}${pkg_dir}" "$OPENWRT_BUILD_PACKAGES_DIR"
        fi
    fi
done


# Build
if [ -e "${OPENWRT_BUILD_DIR}.config" ]
then
    mv -f "${OPENWRT_BUILD_DIR}.config" "${OPENWRT_BUILD_DIR}.config.old"
    cp "$AEOLUS_PACKGES_CONFIG_FILE" "$OPENWRT_BUILD_DIR"
fi
./scripts/feeds install -a
make tools/install
make toolchain/install
make package/index
make V=s
