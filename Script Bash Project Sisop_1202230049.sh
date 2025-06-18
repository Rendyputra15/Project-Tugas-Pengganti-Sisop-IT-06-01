#!/bin/bash

# Warna
biru="\e[36m"
kuning="\e[33m"
ungu="\e[35m"
putih="\e[1;37m"
hijau="\e[32m"
merah="\e[1;31m"
reset="\e[0m"

clear
figlet "MENU SISTEM" | lolcat

while true; do
    echo ""
    echo -e "${kuning}1.${reset} Tampilkan Kehidupan Saat Ini"
    echo -e "${kuning}2.${reset} Tampilkan Daftar Direktori"
    echo -e "${kuning}3.${reset} Informasi Jaringan"
    echo -e "${kuning}4.${reset} Tampilkan Detail OS"
    echo -e "${kuning}5.${reset} Tampilkan Waktu Install Pertama OS"
    echo -e "${kuning}6.${reset} Informasi User"
    echo -e "${kuning}7.${reset} Keluar"
    echo -ne "\n${kuning}Pilih opsi [1-7]:${reset} "
    read pilihan

    case $pilihan in
        1)
            nama="${ungu}Mas Rendy${reset}"
            echo -e "\n${biru}Kehidupan Saat Ini:${reset} \nSEDANG MENUNGGU DIA KEMBALI..."
            echo -e "\n${biru}Selamat Datang $nama! ${biru}Tanggal dan Waktu Saat Ini:${reset}"
            date +"%a %b %d %r WIB %Y"
            ;;
            
        2)
            echo -e "\n${biru}Daftar Direktori:${reset}"
            ls --color=always -l
            ;;
            
        3)
            ip_address=$(hostname -I | awk '{print $1}')
            gateway=$(ip r | grep default | awk '{print $3}')
            netmask=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
            dns_server=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | head -n 1)
            ping -c 1 google.com &> /dev/null && koneksi="Tersambung ke internet." || koneksi="Tidak terhubung ke internet."
            connection_info=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev status)
            lokasi=$(curl -s ipinfo.io | jq -r '.city + ", " + .region + ", " + .country')

            echo -e "\n${biru}Informasi Jaringan:${reset}"
            echo -e "${hijau}Alamat IP Lokal${reset}  : $ip_address"
            echo -e "${hijau}Gateway         ${reset} : $gateway"
            echo -e "${hijau}Netmask         ${reset} : $netmask"
            echo -e "${hijau}DNS Server(s)   ${reset} : $dns_server"

            echo -e "\n${biru}Status Koneksi ke Internet:${reset}"
            echo -e "$koneksi"

            echo -e "\n${biru}Status Koneksi LAN/WIFI:${reset}"
            printf "${biru}%-10s %-10s %-10s %-20s${reset}\n" "DEVICE" "TYPE" "STATE" "CONNECTION"
            echo "$connection_info" | while IFS=: read -r dev type state conn; do
                printf "%-10s %-10s %-10s %-20s\n" "$dev" "$type" "$state" "$conn"
            done

            echo -e "\n${biru}Lokasi IP:${reset}"
            echo -e "$lokasi"
            ;;

        4)
            echo -e "\n${biru}Detail OS:${reset}"
            echo -e "${putih}Nama OS\t\t:${reset} $(lsb_release -d | cut -f2)"
            echo -e "${putih}Versi\t\t:${reset} $(lsb_release -r | cut -f2) ($(lsb_release -c | cut -f2))"
            echo -e "${putih}ID\t\t:${reset} $(lsb_release -i | cut -f2)"
            echo -e "${putih}Keterangan\t:${reset} $(lsb_release -d | cut -f2)"

            echo -e "\n${biru}Informasi Kernel:${reset}"
            uname -r

            echo -e "\n${biru}Proses CPU Terakhir:${reset}"
            top -bn1 | grep "%Cpu"

            echo -e "\n${biru}Penggunaan Memori:${reset}"
            free -h

            echo -e "\n${biru}Penggunaan Disk:${reset}"
            df -h | grep -E '^Filesystem|^/dev/'
            ;;
            
        5)
            echo -e "\n${biru}Waktu OS Pertama Kali Diinstall:${reset}"
            sudo head -n 1 "/var/log/installer/cloud-init.log" 2>/dev/null
            ;;
            
        6)
            echo -e "\n${biru}Informasi Pengguna Saat Ini:${reset}"
            echo -e "Username        : $(whoami)"
            echo -e "User ID         : $(id -u)"
            echo -e "Group ID        : $(id -g)"
            echo -e "Nama Lengkap    : $(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)"
            echo -e "Shell           : $SHELL"
            echo -e "Home Directory  : $HOME"
            ;;
            
        7)
            echo -e "\n${ungu}+----------------+${reset}"
            echo -e "${ungu}| ${merah}Makasih Yaa :)${reset} ${ungu}|${reset}"
            echo -e "${ungu}+----------------+${reset}"
            exit 0
            ;;

        *)
            echo -e "\n${biru}Dicoba lagi ya Sayang!${reset}"
            ;;
    esac

    echo -e "\n${hijau}Tekan Enter untuk kembali ke Masa Lalu...${reset}"
    read
    clear
    figlet "MENU SISTEM" | lolcat
done
