@echo off
echo **********************************************
echo 资源文件加密批处理
echo 作者:鹅卵石
echo 企鹅:2313828706
echo 邮箱:kevinlq0912@163.com
echo 主页:http://kevinlq.com/
echo **********************************************

echo.
echo 开始时间 %DATE%%TIME%
echo.

title 资源文件加密处理
::设置窗口大小
::mode con cols=70 lines=30
::设置字体和颜色
color 2E
echo 当前路径: %~df0

::设置编译后的文件路径
set RCC_Foler=Bin
set RCC_FullFoler=%~dp0\%RCC_Foler%
echo 设置当前编译后的路径为:%RCC_Foler%

::设置编译前的资源文件名，便于修改
set BuildBeforeName=qml.qrc
echo 设置编译的资源文件名称为:%BuildBeforeName%

::设置编译后的资源问价名
set BuildAfterName=qml.rcc
echo 设置编译后的资源文件名称为:%BuildAfterName%

::检测当前编译后资源路径是否存在
if exist %RCC_FullFoler% (
	echo 文件目录 %RCC_FullFoler%已经存在
)else (
	echo 文件目录 %RCC_FullFoler%不存在,正在创建文件夹
	md %RCC_FullFoler%
	if exist %RCC_FullFoler% (
		echo 已经创建 %RCC_FullFoler% 路径
	)else (
		echo 创建文件路径失败,将退出
		goto stop
	)
)

echo 正在编译.....
%~dp0\Tool\MinGW\rcc.exe -binary %~dp0\%BuildBeforeName% -o %~dp0\Bin\%BuildAfterName%
echo.
echo 编译结束......

echo.
echo 结束时间 %DATE%%TIME%
echo.

:stop
pause