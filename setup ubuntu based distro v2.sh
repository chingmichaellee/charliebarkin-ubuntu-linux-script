#!/bin/bash
# Ubuntu (GNOME) 18.04 setup script for all Ubuntu 18.04 based system.
# By Charlie Barkin. (General Public License version 2.0) version 2.0

# Must have Gdebi!:

dpkg -l | grep -qw gdebi || sudo apt-get install -y gdebi

# Remove undesirable packages:

sudo apt purge gstreamer1.0-fluendo-mp3 deja-dup -y

# Install Curl
sudo apt install curl

# Remove snaps and get packages from apt:

sudo snap remove gnome-characters gnome-calculator gnome-system-monitor
sudo apt install gnome-characters gnome-calculator gnome-system-monitor -y

# Purge Firefox:

sudo apt purge firefox* thunderbird* geary* -y
sudo apt purge firefox-locale-en thunderbird-locale-en -y
if [ -d "/home/$USER/.mozilla" ]; then
	rm -rf /home/$USER/.mozilla
fi
if [ -d "/home/$USER/.cache/mozilla" ]; then
	rm -rf /home/$USER/.cache/mozilla
fi

# Install all local .deb packages, if available:

if [ -d "/home/$USER/Downloads/Packages" ]; then
	echo "Installing local .deb packages..."
	pushd /home/$USER/Downloads/Packages
	for FILE in ./*.deb
    do
        sudo gdebi -n "$FILE"
    done
	popd
else
	echo $'\n'$"WARNING! There's no ~/Downloads/Packages directory."
	echo "Local .deb packages can't be automatically installed."
	sleep 5 # The script pauses so this message can be read. 
fi

# Add some Repositories

sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61 
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo sh -c 'echo "deb https://download.onlyoffice.com/repo/debian squeeze main" >> /etc/apt/sources.list.d/desktopeditors.list' 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
sudo add-apt-repository ppa:gerardpuig/ppa -y
sudo add-apt-repository ppa:otto-kesselgulasch/gimp -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo add-apt-repository ppa:flexiondotorg/audio -y 
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - ; echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo add-apt-repository ppa:ubuntuhandbook1/avidemux -y
sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo add-apt-repository ppa:gezakovacs/ppa -y
sudo add-apt-repository ppa:noobslab/icons -y
sudo add-apt-repository ppa:noobslab/icons2 -y
sudo add-apt-repository ppa:noobslab/themes -y

# Update Repository and Full Upgrade the OS:

sudo apt update; sudo apt full-upgrade -y

# Install Apps for OS:

sudo apt install -y google-chrome-stable darktable gimp inkscape krita photocollage rapid-photo-downloader scribus shotwell ufraw rawtherapee 
sudo apt install -y asunder audacity bombono-dvd brasero gnome-mpv devede handbrake imagination k3b kdenlive kino kodi photofilmstrip pavucontrol 
sudo apt install -y rhythmbox smplayer sound-juicer transmageddon vlc winff lame frei0r-plugins gdebi synaptic ubuntu-cleaner mp3gain openssh-server 
sudo apt install -y samba system-config-samba balena-etcher-electron ubuntu-restricted-extras mp3gain snapd apt-xapian-index gnome-tweak-tool flatpak 
sudo apt install -y libreoffice-writer libreoffice-impress libreoffice-calc libreoffice-draw
sudo apt install -y onlyoffice-desktopeditors spotify-client 
sudo apt install -y unetbootin go-mtpfs exfat-fuse exfat-utils testdisk speedtest-cli transcode breeze fonts-powerline stacer
sudo apt install -y avidemux2.7-qt5 avidemux2.7-qt5-data avidemux2.7-plugins-qt5 avidemux2.7-jobs-qt5
 
wget http://packages.linuxmint.com/pool/main/m/mintstick/mintstick_1.4.1_all.deb; sudo dpkg -i mintstick_1.4.1_all.deb; rm mintstick_1.4.1_all.deb

# Install Ocenaudio:

mkdir /tmp/oa-install-tmp
pushd /tmp/oa-install-tmp
wget http://www.ocenaudio.com/downloads/index.php/ocenaudio_debian9_64.deb
sudo gdebi -n ocenaudio_debian9_64.deb
popd
rm -rf /tmp/oa-install-tmp

# Set Qt variable in /etc/environment:

sudo bash -c "echo 'QT_QPA_PLATFORMTHEME=gtk2' >> /etc/environment"

# Brasero-Ubuntu 18.04 Bug Fix:
# Set permissions thusly to enable audio CD writing in Ubuntu 18.04:

sudo chmod 4711 /usr/bin/cdrdao; sudo chmod 4711 /usr/bin/wodim; sudo chmod 0755 /usr/bin/growisofs


# Clean Up FS:

sudo apt clean; sudo apt autoclean; sudo apt autoremove -y; sudo fstrim -av

# Gotta reboot now:

echo $'\n'$"*** All done! Please reboot now. ***"
exit
