docker-glassfish
================

Base docker image to run a Glassfish 4.1 application server.

Usage
-----

To create the image `glassfish-4.1`, execute the following command on the docker-glassfish folder:

	docker build -t koert/glassfish-4.1 .

To run the image and bind to port :

	docker run -d -p 4848:4848 -p 8080:8080 -p 8181:8181 -p 9009:9009 koert/glassfish-4.1

PS: 4848 (for administration), 8080 (for the HTTP listener), and 8181 (for the HTTPS listener), and 9009 (for tcp jpda debug)

The first time that you run your container, a new user `admin` with all privileges 
will be created in Glassfish with a random password. To get the password, check the logs
of the container by running:

	docker logs <CONTAINER_ID>

You will see an output like the following:

	========================================================================
	You can now connect to this Glassfish server using:

	    admin:b1uKcRK3r6SF

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `b1uKcRK3r6SF` is the password allocated to the `admin` user.

You can now login to you admin console to configure your Glassfish server:

	http://127.0.0.1:4848/


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `GLASSFISH_PASS` to your specific password when running the container:

	docker run -d -p 4848:4848 -p 8080:8080 -e GLASSFISH_PASS="mypass" koert/glassfish-4.1

You can now test your deployment:

	http://127.0.0.1:8080/

Done!

Starting the domain for debugging
---------------------------------

If you want to start the domain with the --debug=true option you can
set the environment variable `DEBUG` to `true`:
	docker run -d -p 4848:4848 -p 8080:8080 -p 9009:9009 -e DEBUG="true" koert/glassfish-4.1
This should allow for debugger connections on port 9009.

Notes
-----
Modified to use Oracle Java 7.

Auto deploy directory:
/opt/glassfish3/glassfish/domains/domain1/autodeploy

docker run -d -v ~/tmp/domains:/opt/glassfish4/glassfish/domains:ro -p 4848:4848 -p 8080:8080 -e GLASSFISH_PASS="mypass" koert/glassfish-4.1

docker run --rm -it -v ~/tmp/glassfish/import:/import:ro -v ~/tmp/glassfish/domains:/opt/glassfish4/glassfish/domains -p 4848:4848 -p 8080:8080 -e GLASSFISH_PASS="mypass" koert/glassfish-4.1 /bin/bash



