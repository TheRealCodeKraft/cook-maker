# CODEKRAFT COOK MAKER

## INSTALL

### HANDMADE
For a handmade installation, please consider you have access to a linux environment.

    # update the system
    sudo apt-get update
    # install minimal dependencies : Curl & Git
    sudo apt-get -y install git curl
    # clone cook-maker from CodeKraft repo
    git clone git@github.com:TheRealCodeKraft/cook-maker
    
Then, you will need to update your system to provide all needed libraries to make CodeKraft environment working.
    
    # init environment
    ./cook-maker/preheat
    
### VAGRANT
First, download the Vagrantfile located at : [VagrantFile](https://raw.githubusercontent.com/TheRealCodeKraft/cook-maker/master/vagrant/Vagrantfile)

    # Download Vagrantfile
    wget https://raw.githubusercontent.com/TheRealCodeKraft/cook-maker/master/vagrant/Vagrantfile

Place it in the chosen directory and then launch :

    # Launching vagramt machine
    vagrant up
    
Wait for installation (it take time !) and then go in box

    # Connecting to box
    vssh

## CREATE A SKELETON APPLICATION**

### WORKING EXAMPLE
You want nothing else to have an example application to see this bundle working, so : 
    
    # Cook an application named *example*
    ./cook-maker/cook-example

### YOUR OWN BOOTSTRAP APP TO CUSTOMIZE
You want to give another name than 'example' to your project and some description

    # Cook an application with your preferences
    ./cook-maker/cook -a <app_name> -d "<app_description>" -v <client_lib_version>
    # where client_lib_version is the react frontend library version you want to use

## DROP AN APPLICATION
You have tested example and want to remove all files and data properly : 

### EXAMPLE APP
    # Drop the application named *example*
    ./cook-maker/drop-example
    
### YOUR OWN APP

    # Drop the application named with the parameter
    ./cook-maker/drop -a <app_name>
