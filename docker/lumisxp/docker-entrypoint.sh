#!/bin/bash
set -eo pipefail
shopt -s nullglob

IP=$(awk 'END{print $1}' /etc/hosts)
HOSTNAME=$(hostname)

configure_lumisportal(){
    echo "#################################################"
    echo "########### Setting up lumisportal ##############"
    echo "#################################################"

    LUMIS_SERVER_ID=${IP}    
    JGROUPS_EXTERNAL_ADDR=${IP}

    sed -i 's/LUMIS_DB_HOST/'$LUMIS_DB_HOST'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_DB_PORT/'$LUMIS_DB_PORT'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_DB_USER/'$LUMIS_DB_USER'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_DB_PASSWORD/'$LUMIS_DB_PASSWORD'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_DB_NAME/'$LUMIS_DB_NAME'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_DB_MINIMUM_IDLE/'$LUMIS_DB_MINIMUM_IDLE'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's/LUMIS_SERVER_ID/'$LUMIS_SERVER_ID'/g' $LUMIS_HOME/lumisdata/config/lumisportalconfig.xml
    sed -i 's/JGROUPS_EXTERNAL_ADDR/'$JGROUPS_EXTERNAL_ADDR'/g' $LUMIS_HOME/lumisdata/config/lumisportalconfig.xml
    sed -i 's/LUMIS_DB_MAXIMUM_POOL_SIZE/'$LUMIS_DB_MAXIMUM_POOL_SIZE'/g' $LUMIS_HOME/lumisdata/config/lumishibernate.cfg.xml
    sed -i 's|LUMIS_DATA_PATH|'$LUMIS_HOME'/lumisdata|g' $LUMIS_HOME_WWW/WEB-INF/web.xml

    chmod +x $LUMIS_HOME/setup/*.sh
}

configure_tomcat() {
    echo "#################################################"
    echo "# Setting up tomcat"
    echo "#################################################"

    TOMCAT_JVM_ROUTE=${HOSTNAME}
    sed -i 's/TOMCAT_AJP_MAX_THREADS/'$TOMCAT_AJP_MAX_THREADS'/g' $CATALINA_HOME/conf/server.xml
    sed -i 's/TOMCAT_HTTP_MAX_THREADS/'$TOMCAT_HTTP_MAX_THREADS'/g' $CATALINA_HOME/conf/server.xml
    sed -i 's/TOMCAT_JVM_ROUTE/'$TOMCAT_JVM_ROUTE'/g' $CATALINA_HOME/conf/server.xml
    sed -i 's/TOMCAT_HEAP_XMS/'$TOMCAT_HEAP_XMS'/g' $CATALINA_HOME/bin/setenv.sh
    sed -i 's/TOMCAT_HEAP_XMX/'$TOMCAT_HEAP_XMX'/g' $CATALINA_HOME/bin/setenv.sh
    sed -i 's|LUMIS_HOME_WWW|'$LUMIS_HOME_WWW'|g' $CATALINA_HOME/conf/Catalina/localhost/ROOT.xml
    cp $LUMIS_HOME/lib/shared/* $CATALINA_HOME/lib/    
}

configure_elasticsearch(){
    echo "#################################################"
    echo "# Setting up elasticsearch"
    echo "#################################################"

    sed -i 's/ELASTICSEARCH_HOST/'$ELASTICSEARCH_HOST'/g' /config.sql
    sed -i 's/ELASTICSEARCH_TRANSPORT_HOST/'$ELASTICSEARCH_TRANSPORT_HOST'/g' /config.sql
    sed -i 's/ELASTICSEARCH_CLUSTER_NAME/'$ELASTICSEARCH_CLUSTER_NAME'/g' /config.sql
    sed -i 's|WEB_ROOT_PATH|'$WEB_ROOT_PATH'|g' /config.sql
}

configure_lumisportal
configure_tomcat
configure_elasticsearch

/wait-for-mysql.sh 
/initialize-lumis.sh

exec "$@"