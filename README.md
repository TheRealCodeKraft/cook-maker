# CODEKRAFT COOK MAKER

## INSTALL

    # update system
    sudo apt-get update
    # install minimal dependencies
    sudo apt-get -y install git curl
    # clone cook-maker
    git clone git@github.com:TheRealCodeKraft/cook-maker
    # init environment
    ./cook-maker/preheat

## CREATE A SKELETON APPLICATION**
    
    # Cook an application named *example*
    ./cook-maker/cook-example
OR

    # Cook an application with your preferences
    ./cook-maker/cook -a <app_name> -d "<app_description>" -v <client_lib_version>

## DROP AN APPLICATION

    # Drop the application named *example*
    ./cook-maker/drop-example
OR

    # Drop the application named with the parameter
    ./cook-maker/drop -a <app_name>
