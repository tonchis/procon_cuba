This is an implementation using Cuba of my procon application.

This repo provides a mysql dump: ```db.sql``` to stat hacking right away.

Create the db:

    $ mysql -u root -e "create database procon_development;"

and fill it up

    $ mysql -u root procon_development < db.sql

Next, install procon. We use ```dep```

    $ gem install dep

And install:

    $ dep install

Lets roll!!

    $ shotgun config.ru
