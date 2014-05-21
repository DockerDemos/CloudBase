CloudBase
=========

Docker container for a push-button "Cloud-style" container

Maintainer: Chris Collins \<collins.christopher@gmail.com\>

Updated: 2014-05-21

##Building and Running##

This is a [Docker](http://docker.io) container image.  You need to have Docker installed to build and run the container.

To build the image, change directories into the root of this repository, and run:

`docker build -t cloudbase .` <-- note the period on the end

Once it finished building, you can run the container with:

`CONTAINER=$(docker run -d -P -e PUBKEY="<Your Public SSH KEY>" cloudbase)`

This will assign a random port for you to SSH into, and place your public ssh key into the container so you can SSH into it.

(If you need help generating SSH keys, check out [Step 2 on Github's guide](https://help.github.com/articles/generating-ssh-keys#step-2-generate-a-new-ssh-key).  You can ignore the rest of the steps.)

To ssh into your container, first look up the port you were assigned:

`sudo docker port $CONTAINER 22 | awk -F: '{print $2}'`

Then run your SSH command:

`ssh -i <path.to.your.private.key> clouduser@localhost:<port.you.were.assigned>`

This will connect you to the container as the user "clouduser".  Clouduser has full sudo privileges, and does not requie a password to use them.

##Known Issues##

Tracked on Github: [https://github.com/DockerDemos/CloudBase/issues](https://github.com/DockerDemos/CloudBase/issues)

##Copyright Information##

Copyright (C) 2014 Chris Collins

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
