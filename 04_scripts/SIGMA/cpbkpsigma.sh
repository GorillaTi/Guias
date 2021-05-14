#!/bin/bash
# Autor: Edmundo Cespedes (N0m4d)
# Licencia: GNU GPLv3
# NOMBRE: # bksigma.sh
# FUNCION:
# Verificacion y Copia en el servidor de archivos para Backup.
#
# Variables
#
CARPETA=0;
# Fecha
DIA=$(date +%d);
MES=$(date +%m);
ANO=$(date +%Y);
# Directorio
DIR_ORIGEN="/backup/PROD/export/";
DIR_DESTINO="/mnt/Bkp01/sigmadb/";
# Archivos
ARCH_BKP='fullexpPROD.dmp.gz';
ARCH_LOG='fullexpPROD.log';
#
# Funciones
#
# Funcion Crear Directorio
func_create_dir(){
    echo "Creando Directorio /$2";
    local dirbkp=$1$2;
    mkdir $dirbkp;
    msg="Directorio /$2 creado";
    dirbkp_st=1
    echo $msg;
}
# Funcion Verificar Directorio 
func_verifi_dir(){
    local dirbkp=$1$2;
    echo Verificando la existencia del Directorio '/'$2;
    sleep 1
    if [ -d $dirbkp ];
    then
        echo Directorio '/'$2 encontrado;
        dirbkp_st=1
    else
        echo Directorio '/'$2 no encontrado;
        func_create_dir $1 $2;
    fi
}
func_verifi_arch(){
    # Origen
    local arch="$1$2";
    # Verificando Archivo
    echo "Verificando la existencia de archivos $2";
    if [ -f $oarch1 ];
    then
        echo "Archivo $2 encontrado";
    else
        echo "Archivo $2 no encontrado";
    fi
}
func_copy_arch(){
    sleep 1
    echo Copiando: $3; 
    echo de $1 a $2$4;
    cp -v $1$3 $2$4;
    echo Copia Realizada de $3;
}
func_mount(){
    case $1 in
        1)
            mount 192.168.14.100:/mnt/bckvm01/dump /mnt/Bkp01;
            echo "Directorio Montado";
        ;;
        2)
            umount 192.168.14.100:/mnt/bckvm01/dump /mnt/Bkp01;
            echo "Directorio Desmontado";
        ;;
        *)
            echo "introduzca una opcion 1) Montar Particion 2) Desmontar Particion";
        ;;
    esac
}
func_verifi_mount(){
    local dirmount=$1;
    if [ -d $dirmount ];
    then
        echo "Directorio Montado";
        sleep 1;
        #clear;
    else
        echo "Directorio no Montado";
        echo "Montando directorio";
        sleep 1;
        func_mount 1;
        #clear;
    fi
}
#
# SCRIPT
#
# Carpeta Mensual
#
clear;
echo Iniciando Copia de Backup SIGMA;
#
# Verificamos si esta montad a la Unidad de Red 
#
func_verifi_mount $DIR_DESTINO;
#
# Verificando y/o creando carpeta Mensual
#
CARPETA=$ANO$MES;
func_verifi_dir $DIR_DESTINO $CARPETA;
#
# Verificando y/o creando Carpeta Diaria
#
CARPETA=$ANO$MES$DIA;
DIR_DESTINO=$DIR_DESTINO$ANO$MES'/';
func_verifi_dir $DIR_DESTINO $CARPETA;
#
# Copiando archivos al servidor
#
if [ $dirbkp_st == 1 ];
then
    func_copy_arch $DIR_ORIGEN $DIR_DESTINO $ARCH_BKP $CARPETA;
    func_copy_arch $DIR_ORIGEN $DIR_DESTINO $ARCH_LOG $CARPETA;
    func_mount 2;
    msg="Copias de Backup realizado con exito en /$CARPETA";
else
    msg="No se pudo realizar el Backup no se tiene acceso a las carpetas";
fi
#sleep 1 
#clear;
echo $msg;
