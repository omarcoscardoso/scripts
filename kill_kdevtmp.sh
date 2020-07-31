#/bin/bash
#
# SCRITP EM LOOP, PARA VERIFICACAO DE PROCESSO MALICIOSO
# SE ENCONTRADO DEVE REMOVER E GUARDAR HISTORICO
#

# VAR
ARQ_LOG=kill_kdevtmp.log

while :
do 
    # BUSCA O 'PID' DO MALWARE
    PID=$(ps -eo pid,comm | awk '$2 == "kdevtmpfsi" {print $1 }' | sed -n '1p' )

    # SE O PID EXISTIR REMOVE OS PROCESSOS MALICIOSOS
    # CASO CONTRARIO GUARDA NO LOG A EXECUCAO 
    if [ -z "$PID" ]; then
        MSG='[!] Nada encontrado'
        echo [$$]_$(date +"%Y-%m-%d_%T") $MSG >> $ARQ_LOG
    else
        MSG='[!] Processo encontrado'
        echo [$$]_$(date +"%Y-%m-%d_%T") $MSG >> $ARQ_LOG
        # COMANDOS PARA REMOVER O PROCESSO MALICIOSO
        pkill -f kinsing ; pkill -f kdevtmpfsi ; sudo -u www-data crontab -r ; rm /var/tmp/kinsing ; rm /tmp/kdevtmpfsi
        MSG='[X] Processo removido '
        echo [$$]_$(date +"%Y-%m-%d_%T") $MSG >> $ARQ_LOG
    fi

    # REPETE A VERIFICACAO NO TEMPO DETERMINADO em segundos 300 = 5min
    sleep 300 
done
