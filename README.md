docker.wordpress
================

Debian based wordpress container

Very light *wordpress* installation fully based on the *Debian* packages.

By design, it will only run the *Apache* daemon and it requires a linked **mysql** container: feel free to install your preferred one.

Once you can access the *mysql* server, just execute *wordpress* with something like:

    docker run -d -P --link mysql:mysql --name wordpress odiobill/wordpress

The installation provides the standard Debian **setup-mysql** script, ready to use in the */srv/www* exported volume. To configure your blog(s), you may want to run another (temporary) container that imports the wordpress volumes. It also requires to access the same *mysql* container. Run it with:

    docker run -i -t --name config_wordpress --volumes-from wordpress --link mysql:mysql odiobill/wordpress bash

Once inside the *config_wordpress* container, assuming that root is the mysql administrative username you are ready to create your blog:

    /srv/www/setup-mysql -n example -u root -t mysql blog.example.com

Now you can exit the configuration template and point your browser to the exposed port on the wordpress container.

