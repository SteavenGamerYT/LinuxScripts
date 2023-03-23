wget -O repos.sh https://github.com/SteavenBuntu/SteavenRepos/raw/main/install.sh
wget -O gnome.sh https://github.com/SteavenBuntu/SteavenGnome/raw/main/install.sh
wget -O wallpapers.sh https://github.com/SteavenBuntu/SteavenBuntu-Wallpapers/raw/main/install.sh

sudo chmod +x gnome.sh
sudo chmod +x repos.sh
sudo chmod +x wallpapers.sh
./repos.sh
./gnome.sh
./wallpapers.sh