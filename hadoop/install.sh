wget http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz -P /usr/local/src
cd /usr/local/src && tar -xzf hadoop-3.2.1.tar.gz -C /opt
cd /opt && mv hadoop-3.2.1 hadoop
# config host file, ie, vim /etc/hosts
# config env variable, vim /etc/profile
# copy xxx-site.xml file, workers, hadoop-env.sh yarn-env.sh to /opt/hadoop/etc/hadoop
# copy activiation-1.1.jar to /opt/hadoop/share/hadoop/common/lib/ and /opt/hadoop/share/hadoop/yarn/lib
# grant other machines ssh permission
# start hadoop cluster ./sbin/start-all.sh