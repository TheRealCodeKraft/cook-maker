# CODEKRAFT COOK MAKER

## INSTALL

    # update system
    sudo apt-get update
    # install minimal dependencies
    sudo apt-get install git curl
    # clone cook-maker
    git clone git@github.com:TheRealCodeKraft/cook-maker
    # init environment
    ./cook-maker/init_workspace

## CREATE A SKELETON APPLICATION**

./cook-maker/cook-example

OR

./cook-maker/cook -a <app_name> -d "<app_description>" -v <client_lib_version>

## DROP AN APPLICATION

./cook-maker/drop-example

OR

./cook-maker/drop -a <app_name>
