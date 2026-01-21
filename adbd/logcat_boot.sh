#!/system/bin/sh

# Configuração avançada
PERSIST_PARTITION="/persist"
if [ ! -d "${PERSIST_PARTITION}" ]; then
    PERSIST_PARTITION="/mnt/vendor/persist"
fi

LOG_DIR="${PERSIST_PARTITION}/boot_logs"
CONFIG_FILE="${LOG_DIR}/logcat_config.conf"

# Carregar configuração se existir
if [ -f "${CONFIG_FILE}" ]; then
    . "${CONFIG_FILE}"
else
    # Configurações padrão
    ENABLE_LOGCAT=true
    ENABLE_KMSG=true
    ENABLE_EVENTS=true
    MAX_SIZE_MB=20
    ROTATE_FILES=10
    BUFFERS="main,system,events,crash"
fi

# Criar estrutura de diretórios
mkdir -p "${LOG_DIR}/archive"
chmod 0755 "${LOG_DIR}"

# Função para rotacionar logs
rotate_logs() {
    local pattern=$1
    cd "${LOG_DIR}"
    
    # Rotacionar arquivos existentes
    for i in $(seq ${ROTATE_FILES} -1 1); do
        if [ -f "${pattern}.${i}" ]; then
            mv "${pattern}.${i}" "${pattern}.$((i+1))"
        fi
    done
    
    if [ -f "${pattern}" ]; then
        mv "${pattern}" "${pattern}.1"
    fi
}

# Coletar logcat se habilitado
if [ "${ENABLE_LOGCAT}" = "true" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    LOG_FILE="${LOG_DIR}/logcat_${TIMESTAMP}.log"
    
    # Rotacionar logs antigos
    rotate_logs "logcat_*.log"
    
    # Iniciar logcat com múltiplos buffers
    for buffer in $(echo ${BUFFERS} | tr ',' ' '); do
        /system/bin/logcat -b ${buffer} -v threadtime -f ${LOG_DIR}/logcat_${buffer}_${TIMESTAMP}.log &
        echo $! > ${LOG_DIR}/logcat_${buffer}.pid
    done
    
    # Registrar início
    echo "Logcat started at ${TIMESTAMP}" > ${LOG_DIR}/boot_status.log
fi

# Coletar kernel logs
if [ "${ENABLE_KMSG}" = "true" ]; then
    dmesg > ${LOG_DIR}/kernel_${TIMESTAMP}.log
    cat /proc/kmsg > ${LOG_DIR}/kmsg_${TIMESTAMP}.log &
fi
