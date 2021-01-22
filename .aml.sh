MODDIR=${0%/*}

# destinations
MAEC=`find $MODDIR/system -type f -name *audio*effects*.conf`
MAEX=`find $MODDIR/system -type f -name *audio*effects*.xml`

# store
NAME=v4a_fx
NAME2=v4a_standard_fx
LIBPATH="\/vendor\/lib\/soundfx"
LIB=libv4a_fx.so
UUID=41d3c987-e6cf-11e3-a88a-11aba5d5c51b

# patch audio effects conf
if echo $MAEC | grep -Eq conf; then
  sed -i "/^libraries {/a\  $NAME {\n    path $LIBPATH\/$LIB\n  }" $MAEC
  sed -i "/^effects {/a\  $NAME2 {\n    library $NAME\n    uuid $UUID\n  }" $MAEC
fi

# patch effects xml
if echo $MAEX | grep -Eq xml; then
  sed -i "/<libraries>/a\        <library name=\"$NAME\" path=\"$LIB\"\/>" $MAEX
  sed -i "/<effects>/a\        <effect name=\"$NAME2\" library=\"$NAME\" uuid=\"$UUID\"\/>" $MAEX
fi



