
 - make sure you have the hail-teamcity-ci.pem file handy, its on the CI master
   server and Dan has a copy on his laptop
 - log into aws.amazon.com
 - Navigate to the EC2 console (under compute)
 - There should now be a left sidebar with a button for AMIs (under IMAGES), click that.
 - Click hail-teamcity-image-n, where n is the largest number
 - click Launch
 - Leave the defaults (instance type t2.micro) and click "Review and Launch"
 - At the "Select an existing key pair or create a new key pair" dialog, select the hail-teamcity-ci key pair.
 - note the launched instance's id
 - SSH into the machine using `-i /path/to/hail-teamcity-ci.pem` and the user
   `ec2-user`. The Public IP should be listed on the page that you were
   redirected to by clicking Launch
 - make your changes & test them as the ec2-user (which is usually the user
   you're logged in as, check with `whoami`)
 - exit the SSH connection
 - from the amazon console page, "Stop" (DO NOT "TERMINATE") the instance
 - when the state changes to "Stopped", click the instance, and under
   "Description" find the "root device", click this link.
 - note the name of the EBS volume
 - click the EBS volume link listed in the pop-up
 - with the volume still selected, click "Actions > Detach Volume"
 - go back to "Instances" (on the left) and terminate the instance
 - go back to "Volumes" and click on the EBS volume from earlier
 - click "Actions > Create Snapshot", name it hail-teamcity-ci-snapshot-n+1
 - click the link in the pop-up
 - with the snapshot still selected, click "Actions > Create Image"
 - for the name, enter "hail-teamcity-ci-image-n+1"
 - under "Virtualization Type" select "hardware-assisted virtualization"
 - click "Create"
 - click the link in the pop-up
 - Great you're almost done!
 - navigate to "ci.hail.is"
 - Click "Administration"
 - Click "Agent Cloud"
 - Click "hail-teamcity-ci-cloud-profile"
 - on this page you'll see a table with one row whose "source" column is
   something like "ami-352412baa"
 - Click "edit"
 - Under "Source" select the image you just created ("hail-teamcity-ci-image-n+1")
 - click "Save"
 - click "Save"
 - All Done!!

If you want to all the agents to use that image, click "Agents", then click
"Cloud", then click "Stop" for all the agents listed (this will actually
Terminate them). New images will start up. Although they are marked as started
in the CI, they take time to start; check the amazon console. Moreover, the
agent may need to upgrade its components, but TeamCity lists this state as
"disconnected", do not fear as long as the Agent log contain messages about
"Unpacking plugin".

To debug these agents, SSH to them using the same credentials and username as
used above.

The TeamCity Agent is installed at /home/ec2-user/BuildAgent.


*REGARDING PIP:*

I have used `sudo $(which pip) install foo`, I'm not sure if this is the correct
way to do it or not, but it seems to work.
