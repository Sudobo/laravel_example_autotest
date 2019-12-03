FROM amazonlinux:2

# Config systemd
RUN yum -y install systemd; yum clean all; \
        (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
        rm -f /lib/systemd/system/multi-user.target.wants/*;\
        rm -f /etc/systemd/system/*.wants/*;\
        rm -f /lib/systemd/system/local-fs.target.wants/*; \
        rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
        rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
        rm -f /lib/systemd/system/basic.target.wants/*;\
        rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

### IMPORT GPG KEY
RUN \
    rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 && \
    rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 && \
    rpm --import https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY

### INSTALL EPEL
RUN \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum update -y

### INSTALL TOOLS
RUN \
    yum install -y \
        git \
        vim \
        wget \
        curl \
        cronie \
        procps

### INSTALL PHP
RUN yum remove php*
RUN \
    amazon-linux-extras disable php5.4 && \
    amazon-linux-extras enable php7.3 && \
    amazon-linux-extras install php7.3

RUN \
    yum clean metadata && \
    yum update -y

RUN \
    yum install -y \
    php \
    php-pdo \
    php-cli \
    php-common \
    php-mysqlnd \
    php-curl \
    php-zip \
    php-opcache \
    php-pecl-memcached.x86_64 \
    php-gd \
    php-ldap \
    php-odbc \
    php-pear \
    php-xml \
    php-xmlrpc \
    php-mbstring \
    php-soap \
    curl-devel

# Install composer
RUN \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    # Run composer vendors as globaly.
    echo "export PATH=${PATH}:/root/.composer/vendor/bin" >> ~/.bashrc

### Install Apache
RUN \
    yum install -y httpd &&\
    systemctl enable httpd.service

RUN \
    yum install -y gcc-c++ make &&\
    curl -sL https://rpm.nodesource.com/setup_12.x  | bash - &&\
    yum install -y nodejs

### Add config file
ADD docker /

### Setting workdir
WORKDIR /var/www/html

CMD ["/usr/sbin/init"]
