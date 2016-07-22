
AEOLUS_CURRENT_DIR="$(cd $(dirname "$0") && pwd -P)/"
AEOLUS_BUILD_DIR="${AEOLUS_CURRENT_DIR}build/"

OPENWRT_GIT_PROJECT="openwrt"
OPENWRT_GIT_BRANCH="chaos_calmer"
OPENWRT_GIT_URL="https://github.com/openwrt/${OPENWRT_GIT_PROJECT}/archive/${OPENWRT_GIT_BRANCH}.tar.gz"
OPENWRT_BUILD_DIR="${AEOLUS_BUILD_DIR}${OPENWRT_GIT_PROJECT}-${OPENWRT_GIT_BRANCH}/"


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


# Build ENV
#git checkout chaos_calmer
./scripts/feeds update -a
./scripts/feeds install -a
#make kernel_defconfig
#make defconfig
make tools/install
make toolchain/install
make menuconfig
make package/index


# Build packages
#make package/feeds/packages/luasocket/download
#make package/feeds/packages/luasocket/prepare
#make package/feeds/packages/luasocket/compile
#make package/feeds/packages/luasocket/install
#make package/index
make V=s
