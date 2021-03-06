#!/bin/bash
# Debian has 3 mame packages:
# mame, mame-data, mame-tools

rmecho () {
  echo "Deleting $1"
  rm $1
}

copyecho () {
  echo "Copying $1 into $2"
  cp $1 $2
}

# --- Paths configuration ---
source configuration.sh
echo "MAME source directory $MAME_SOURCE_DIR"
echo "MAME installation directory $MAME_INSTALL_DIR"
echo "MAME binary directory $MAME_BIN_DIR"
echo "MAME configuration directory $MAME_CONFIG_DIR"

# --- Create MAME main paths ----------------------------------------------------------------------
echo "Creating MAME paths..."
mkdir -p ${MAME_BIN_DIR}
mkdir -p ${MAME_INSTALL_DIR}
mkdir -p ${MAME_CONFIG_DIR}

# --- Copy MAME executable ------------------------------------------------------------------------
# https://stackoverflow.com/questions/14888012/how-to-rsync-a-single-file
echo "Installing MAME executable..."
# cp ${MAME_SOURCE_DIR}/mame64 ${MAME_BIN_DIR}
rsync -a ${MAME_SOURCE_DIR}/mame64 ${MAME_BIN_DIR}

# --- Copy MAME INI file --------------------------------------------------------------------------
echo "Installing MAME configuration files..."
copyecho mame.ini ${MAME_CONFIG_DIR}
copyecho ui.ini ${MAME_CONFIG_DIR}
copyecho plugin.ini ${MAME_CONFIG_DIR}
copyecho horizont.ini ${MAME_CONFIG_DIR}
copyecho vertical.ini ${MAME_CONFIG_DIR}
copyecho mame.ini $(readlink -m "${MAME_CONFIG_DIR}/mame.ini.initial")
copyecho ui.ini $(readlink -m "${MAME_CONFIG_DIR}/ui.ini.initial")

# --- Install MAME data ---------------------------------------------------------------------------
echo "Installing MAME artwork..."
mkdir -p ${MAME_INSTALL_DIR}/artwork/
# cp -r ${MAME_SOURCE_DIR}/artwork/* ${MAME_INSTALL_DIR}/artwork/
rsync -a ${MAME_SOURCE_DIR}/artwork/ ${MAME_INSTALL_DIR}/artwork/

echo "Installing MAME bgfx..."
mkdir -p ${MAME_INSTALL_DIR}/bgfx/
# cp -r ${MAME_SOURCE_DIR}/bgfx/* ${MAME_INSTALL_DIR}/bgfx/
rsync -a ${MAME_SOURCE_DIR}/bgfx/ ${MAME_INSTALL_DIR}/bgfx/

echo "Installing MAME cheats..."
mkdir -p ${MAME_INSTALL_DIR}/cheats/

echo "Installing MAME crosshairs..."
mkdir -p ${MAME_INSTALL_DIR}/crosshairs/

echo "Installing MAME ctrlr..."
mkdir -p ${MAME_INSTALL_DIR}/ctrlr/
# cp -r ${MAME_SOURCE_DIR}/ctrlr/* ${MAME_INSTALL_DIR}/ctrlr/
rsync -a ${MAME_SOURCE_DIR}/ctrlr/ ${MAME_INSTALL_DIR}/ctrlr/

echo "Installing MAME fonts..."
mkdir -p ${MAME_INSTALL_DIR}/fonts/
cp ${MAME_SOURCE_DIR}/uismall.bdf ${MAME_INSTALL_DIR}/fonts/uismall.bdf

echo "Installing MAME Software Lists XMLs..."
mkdir -p ${MAME_INSTALL_DIR}/hash/
# cp -r ${MAME_SOURCE_DIR}/hash/* ${MAME_INSTALL_DIR}/hash/
rsync -a ${MAME_SOURCE_DIR}/hash/ ${MAME_INSTALL_DIR}/hash/

echo "Installing MAME keymaps..."
mkdir -p ${MAME_INSTALL_DIR}/keymaps/
# cp -r ${MAME_SOURCE_DIR}/keymaps/* ${MAME_INSTALL_DIR}/keymaps/
rsync -a ${MAME_SOURCE_DIR}/keymaps/ ${MAME_INSTALL_DIR}/keymaps/

echo "Installing MAME language..."
mkdir -p ${MAME_INSTALL_DIR}/language/
# cp -r ${MAME_SOURCE_DIR}/language/* ${MAME_INSTALL_DIR}/language/
rsync -a ${MAME_SOURCE_DIR}/language/ ${MAME_INSTALL_DIR}/language/

echo "Installing MAME plugins..."
mkdir -p ${MAME_INSTALL_DIR}/plugins/
# cp -r ${MAME_SOURCE_DIR}/plugins/* ${MAME_INSTALL_DIR}/plugins/
rsync -a ${MAME_SOURCE_DIR}/plugins/ ${MAME_INSTALL_DIR}/plugins/

echo "Installing MAME samples..."
mkdir -p ${MAME_INSTALL_DIR}/samples/
# cp -r ${MAME_SOURCE_DIR}/samples/* ${MAME_INSTALL_DIR}/samples/
rsync -a ${MAME_SOURCE_DIR}/samples/ ${MAME_INSTALL_DIR}/samples/

# --- Delete weird shaders
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/lut.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/pillarbox_left_horizontal.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/pillarbox_left_vertical.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/pillarbox_right_horizontal.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/pillarbox_right_vertical.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/unfiltered.json"
rmecho "${MAME_INSTALL_DIR}/bgfx/chains/xbr/*.json"
