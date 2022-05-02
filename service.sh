MODDIR=${0%/*}
# 判断是否首次加载模块

FIRST=$(find $MODDIR -name debug.log)
if [ -z $FIRST ]; then
 # wait
    sleep 20
# 修复moto 小部件
    pm install -g --user 0 $MODDIR/system/app/TimeWeather/TimeWeather.apk && echo "修复成功" >>$MODDIR/debug.log 2>&1 || (echo "安装失败" >>$MODDIR/debug.log 2>&1)

else
   (
:<<EOF
    API=`getprop ro.build.version.sdk`

    # debug
    exec 2>$MODDIR/debug.log
    set -x

    # wait
    sleep 5

    # grant
    PKG= "com.motorola.timeweatherwidget"
    pm grant $PKG android.permission.ACCESS_FINE_LOCATION
    pm grant $PKG android.permission.ACCESS_COARSE_LOCATION
    pm grant $PKG android.permission.ACCESS_BACKGROUND_LOCATION
    if [ "$API" -gt 29 ]; then
      appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
    fi

    # grant
    PKG="com.motorola.timeweatherwidget"
    pm grant $PKG android.permission.READ_EXTERNAL_STORAGE
    pm grant $PKG android.permission.WRITE_EXTERNAL_STORAGE
    pm grant $PKG android.permission.READ_PHONE_STATE
    pm grant $PKG android.permission.CALL_PHONE
    if [ "$API" -gt 29 ]; then
      appops set $PKG AUTO_REVOKE_PERMISSIONS_IF_UNUSED ignore
    fi
EOF
#   2022 劳动节快乐！
     echo "2022 劳动节快乐！" >>$MODDIR/debug.log 2>&1
    

    ) 2>/dev/null


fi







