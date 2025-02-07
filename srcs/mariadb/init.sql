CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;

CREATE USER 'superuser'@'%' IDENTIFIED BY 'superpassword';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%';
FLUSH PRIVILEGES;