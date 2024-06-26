# fix automake

set -xe

# fix other python and perl scripts
gawk -i inplace '/usr\/bin\//{ gsub(/python/, "env python");}1' script/*.py
gawk -i inplace '/usr\/bin\//{ gsub(/perl/, "env perl");}1' script/*

autoreconf -if

export INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"
export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"

echo "===== CXX: ${CXX}"
./configure
make -j ${CPU_COUNT} CXX=${CXX}

mkdir -p ${PREFIX}/bin

cp bin/* ${PREFIX}/bin
cp script/*py ${PREFIX}/bin
cp script/validate* ${PREFIX}/bin
