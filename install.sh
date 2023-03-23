wget -O repos.sh https://github.com/SteavenBuntu/SteavenRepos/raw/main/install.sh
wget -O gnome.sh https://github.com/SteavenBuntu/SteavenGnome/raw/main/install.sh
wget -O wallpapers.sh https://github.com/SteavenBuntu/SteavenBuntu-Wallpapers/raw/main/install.sh
wget -O system-info.sh https://github.com/SteavenBuntu/Steaven-OS-INFO/raw/main/install.sh
wget -O internet.sh https://github.com/SteavenBuntu/Steaven-Network/raw/main/install.sh
sudo chmod +x gnome.sh
sudo chmod +x repos.sh
sudo chmod +x wallpapers.sh
sudo chmod +x system-info.sh
sudo chmod +x internet.sh
./repos.sh
./gnome.sh
./wallpapers.sh
./system-info.sh
./internet.sh