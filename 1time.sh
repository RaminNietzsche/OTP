#########################################################################
# 									#
# 	   Server SSH Secure by make one time password :D		#
#		 ____ ____ ____   ___ _____ ____  			#
#		/ ___/ ___/ ___| / _ \_   _|  _ \ 			#
#		\___ \___ \___ \| | | || | | |_) |			#
#		 ___) |__) |__) | |_| || | |  __/ 			#
#		|____/____/____/ \___/ |_| |_|  			#
#									#
# Copyright (C) 2012 Ramin Najjarbashi <ramin.najarbashi@gmail.com>	#
#									#
# This program is free software; you can redistribute it and/or		#
# modify it under the terms of the GNU General Public License as	#
# published by the Free Software Foundation; either version 2 of	#
# the License or (at your option) version 3 or any later version	#
# accepted by the membership of KDE e.V. (or its successor approved	#
# by the membership of KDE e.V.), which shall act as a proxy		#
# defined in Section 14 of version 3 of the license.			#
# 									#
#									#
# This program is distributed in the hope that it will be useful,	#
# but WITHOUT ANY WARRANTY; without even the implied warranty of	#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the		#
# GNU General Public License for more details.				#
#									#
# You should have received a copy of the GNU General Public License	#
# along with this program; if not, see http://www.gnu.org/licenses/	#
#									#
#########################################################################

#!/bin/bash

LUSER=$USER

if [ -e /var/1time.pass ] ;then
   #means script is installed and run!
   if [ `stat /var/1time.pass -c %a` -ne 544 ]; then
	echo "HO HO HO!!! why? Permission was Changed! Why? Why? Why?"
	sudo chmod 544 /var/1time.pass
	echo "HE HE HE!!! Permission Changed to Defullt!!! ;)"
   fi
   
   tmpPass=`cat /var/1time.pass | head -1`
   sudo sed -i 1d /var/1time.pass
   NewPass="$LUSER"":""$tmpPass"":""`sudo less /etc/shadow | grep ^$LUSER | cut -d: -f3-11`"
   OldPass=`sudo less /etc/shadow | grep ^$LUSER`
   sudo sed -i '/^'$LUSER'/ d' /etc/shadow
   #sudo sed -i 's/$OldPass/$NewPass/g' /etc/shadow
   #echo $NewPass >> /etc/shadow
   sudo cp /etc/shadow .
   #ls .
   echo $LUSER
   echo "--------------"
   echo $NewPass
   echo "=============="
   sudo chmod 777 shadow
   #ls -l
   echo $NewPass >> shadow
   #echo $NewPass
   cat shadow | tail -3
   sudo mv shadow /etc/shadow
   #sudo mv shadow /etc/shadow-
   sudo chmod 640 /etc/shadow
   #sudo chmod 640 /etc/shadow-
fi
