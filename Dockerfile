FROM centos

RUN yum install -y sudo
RUN yum install -y vim
RUN yum install -y wget
RUN yum install -y java-11-openjdk.x86_64

# Create /tmp dir where Spring Boot will store temp files (default location)
VOLUME /tmp
# File will be copied to /spring-boot-web.jar location
ADD /spring-boot-web-0.0.1-SNAPSHOT.jar spring-boot-web.jar
# Run shell command -c flag just takes the next string as the command to run
# touch command will update the timestamp to file or directory so that system can keep track when they are created and updated
RUN sh -c 'touch /spring-boot-web.jar'
# Configures the container to be run as an executable with command "java -Djava.security.egd=file:/dev/./urandom -jar payroll-0.0.1.jar"
# java.security.egd=file:/dev/./urandom, helps to avoid JVM delays caused by random number generation
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "spring-boot-web.jar"]