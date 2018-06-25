# Instructions of Setting up VR Meeting Backend

The back end of VR Meeting is writen using Ruby on Rails framework. We created a few REST apis to process requests related to VR Meeting services.

This is the instructions of how to set up the back end part of VR Meeting.

**NOTE: This instruction is based on CentOS 7, but similar process can be adapted for other distros**

# Step 1: Install Ruby and Gem

First step is to make sure Ruby and Gem is installed correctly.
You can check if they were installed by execute the following command.
`ruby -v` this command will return the version of ruby(if ruby is installed correctly)
`gem -v` this command wil return the version of Gemem is installed correctly)

if they are both installed, skip this scetion, go to step 2.

##### Install Ruby and Gem

You can install Ruby and Gem by execute the following command <br>
`sudo yum install ruby-devel`

after that, check version of ruby and gem by execute`ruby -v` and `gem -v` seperately

# Step 2: Config MariaDB

Check if MariaDB is installed correctly. <br>
`mysql --version`

To install mariadb <br>
`sudo yum install mariadb-server`
and config it to auto start at boot <br>
`sudo systemctl enable mariadb`

You will need to setup you own account to use MariaDB.
Detailed tutorial can be found [here](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-centos-7) 

# Step 3: Get Source from Git

You can get source code simply by executing <br>
`git clone https://github.com/psymj1/VRMeeting-Web-Server.git`

# Step 4: Install Gem dependencies

After Step 3, you will find a new folder in current directory called `VRMeeting_Server`, change your current working directory into it. `cd VRMeeting_Server`

Then execute `gem install rails` to install Ruby on Rails framework

Then execute `bundle install` (make sure bundle is installed `gem install bundle`)

# Step 5: Config Datebases

You will find a file at the root of the project folder called `db.sql`,
import it into mariadb using your own account.

# Step 6: Change db config accordingly

There is a file in `config` folder called `database.yml`,
change `username`, `password` and `host` according to your setup.

# Step 7: You are ready to go

Go back to root folder of the project and run <br>
`rails server`

<br>
<br>
<br>
<br>


# Setting up VR Meeting Backend for Windows 64bit
## Step 1: Installing the software
- Visit [this link](http://railsinstaller.org/en) and download the Rails installer **2.2.6** and go ahead and install that <br><br>
- Once installed visit [this link](https://downloads.mariadb.org/) to download MariaDB **10.1** and run the executable (*be warned your anti-virus may detect the installer as a threat*).<br><br>
- Click next until you are asked to setup a password, remember this password for later.

## Step 2: Cloning the Repository
- Open a command prompt and type `ruby -v` and ensure Ruby is installed <br><br>
- In the same window type `rails -v` and ensure that Rails is also installed <br><br>
- Then navigate to where you want to download and run the server, and run the command `git clone https://github.com/psymj1/VRMeeting-Web-Server.git`

## Step 3: Configuring the Database
- Once the repository has downloaded open the `config` folder and open the `database.yml` file. <br><br>
- Change the username to `root` if not already, and change the password to the password you entered earlier in MariaDB <br><br>
- Next, open **MySQL Client (Maria 10.1)** from the program menu. Then navigate to the main repository directory and copy the contents of the `db.sql` file. Paste the clipboard into the **MySQL Client** and press `enter`.

## Step 4:  Running the Server
- Open a normal command prompt in the server repository and type `bundle install` <br><br>
- Once that has completed type `rails server` to launch the server. To test if that has worked navigate your web browser to `localhost:3000` and you should see a **Yay! You're on Rails** prompt













