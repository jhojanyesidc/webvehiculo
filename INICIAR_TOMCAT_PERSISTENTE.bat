@echo off
setlocal

title TOMCAT - WebFlotaVehiculo Server

echo =========================================
echo INICIANDO TOMCAT - WebFlotaVehiculo
echo =========================================

REM Configurar variables de entorno
set "CATALINA_HOME=C:\Users\barne\OneDrive\Desktop\JAVA\JSP\WebFlotaVehiculo\apache-tomcat-9.0.83"
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set "CATALINA_BASE=%CATALINA_HOME%"

echo Variables configuradas:
echo CATALINA_HOME: %CATALINA_HOME%
echo JAVA_HOME: %JAVA_HOME%
echo.

REM Cambiar al directorio bin
cd /d "%CATALINA_HOME%\bin"

echo Iniciando servidor Tomcat...
echo.
echo IMPORTANTE: NO CIERRES ESTA VENTANA
echo Esta ventana debe permanecer abierta para que Tomcat funcione
echo.

REM Ejecutar catalina.bat run (en lugar de startup.bat) para mantener el proceso activo
"%CATALINA_HOME%\bin\catalina.bat" run

echo.
echo =========================================
echo Tomcat se ha detenido
echo =========================================
pause
