Final Project: Drupal CMS & Docker Automation


## a. Authors
* Michael | ID: 330908476
* Layla | ID: 330885138

## b. Project Overview
This project provides a fully automated Linux Bash environment for managing a containerized Drupal CMS and MySQL database using Docker. It includes scripts for deployment, automated database backups, data restoration, and complete environment cleanup.

## c. What We Did
* Configured a dedicated Docker bridge network (drupal-net) to connect Drupal (drupal-server) and MySQL (drupal-mysql) securely.
* Built and loaded a rich terminology dictionary of DevOps and Software Engineering concepts into Drupal.
* Created an automated compressed MySQL backup (backups/my-drupal.backup.sql.gz).
* Authored 4 automated lifecycle Bash scripts: setup.sh, backup.sh, restore.sh, and cleanup.sh.

## d. Technologies Used
* Containerization: Docker & Docker Networking
* Applications: Drupal 11 CMS, MySQL 8.0
* OS & Scripting: Linux (Ubuntu), Bash Scripting
* Version Control: Git & GitHub

## e. Step-by-Step Guide

### 1. Clone & Set Permissions

    git clone https://github.com/Michaelif7/Final-project---dev-tools.git
    cd Final-project---dev-tools
    chmod +x *.sh

### 2. Setup Environment
Run the setup script to create the network and deploy containers:

    ./setup.sh

(Wait ~30 seconds after completion for MySQL to fully initialize).

### 3. Connect Drupal to Database
1. Open your browser and navigate to: http://localhost:8080
2. Select the Standard profile and click Save and continue.
3. In the Database configuration screen, enter:
   * Database name: drupaldb
   * Database username: drupaluser
   * Database password: drupalpass
   * Under ADVANCED OPTIONS -> Host, enter: drupal-mysql
4. Click Save and continue and complete the installation.

### 4. Restore Database Backup
Run the restore script to inject the saved dictionary and user data:

    ./restore.sh

### 5. Cleanup Environment
When finished testing, remove all containers, networks, and unused volumes:

    ./cleanup.sh

## f. Additional Information
* Admin Login Credentials:
  * Username: demoadmin
  * Password: secretpass
* Container Logs: To inspect live application logs, run: docker logs -f drupal-server
