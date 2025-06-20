#!/bin/bash

# Warna
biru="\e[36m"
Biruu="\e[1;36m"
kuning="\e[33m"
cyan="\e[1;34m"
ungu="\e[35m"
putih="\e[1;37m"
hijau="\e[32m"
MerahBold="\e[1;31m"
merah="\e[31m"
reset="\e[0m"

clear
figlet "    MENU SISTEM    " | lolcat

while true; do
    echo ""
    echo -e "${ungu}1. Tampilkan Kehidupan Saat Ini${reset}"
    echo -e "${ungu}2. Tampilkan Daftar Direktori${reset}"
    echo -e "${ungu}3. Tampilkan Detail OS${reset}"
    echo -e "${ungu}4. Tampilkan Waktu Install Pertama OS${reset}"
    echo -e "${ungu}5. Informasi User${reset}"
    echo -e "${ungu}6. Keluar${reset}"
    echo -ne "\n${ungu}Pilih opsi [1-6]:${reset} "
    read pilihan

    case $pilihan in
        1)
            nama="${ungu}Mas Rendy${reset}"
            echo -e "\n${cyan}Kehidupan Saat Ini:${reset} \nMELIHAT DIA SAMA YANG LAIN... 😔"
            echo -e "\n${cyan}Selamat Datang $nama! ${cyan}Tanggal dan Waktu Saat Ini:${reset}"
            date +"%a %b %d %r WIB %Y"
            ;;
            
        2)
            echo -e "\n${cyan}Daftar Direktori:${reset}"
            ls --color=always -l
            ;;

        3)
            echo -e "\n${cyan}Detail OS:${reset}"
            echo -e "${putih}Nama OS\t\t:${reset} $(lsb_release -d | cut -f2)"
            echo -e "${putih}Versi\t\t:${reset} $(lsb_release -r | cut -f2) ($(lsb_release -c | cut -f2))"
            echo -e "${putih}ID\t\t:${reset} $(lsb_release -i | cut -f2)"
            echo -e "${putih}Keterangan\t:${reset} $(lsb_release -d | cut -f2)"

            echo -e "\n${cyan}Informasi Kernel:${reset}"
            uname -r

            echo -e "\n${cyan}Proses CPU Terakhir:${reset}"
            top -bn1 | grep "%Cpu"

            echo -e "\n${cyan}Penggunaan Memori:${reset}"
            free -h

            echo -e "\n${cyan}Penggunaan Disk:${reset}"
            df -h | grep -E '^Filesystem|^/dev/'
            ;;
            
        4)
            echo -e "\n${cyan}Waktu OS Pertama Kali Diinstall:${reset}"
            sudo head -n 1 "/var/log/installer/cloud-init.log" 2>/dev/null
            ;;
            
        5)
            echo -e "\n${cyan}Informasi Pengguna Saat Ini:${reset}"
            echo -e "Username        : $(whoami)"
            echo -e "User ID         : $(id -u)"
            echo -e "Group ID        : $(id -g)"
            echo -e "Nama Lengkap    : $(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)"
            echo -e "Shell           : $SHELL"
            echo -e "Home Directory  : $HOME"
            ;;
            
        6)
            echo -e "\n${hijau}+----------------+${reset}"
            echo -e "${hijau}| ${MerahBold}Makasih Yaa :)${reset} ${hijau}|${reset}"
            echo -e "${hijau}+----------------+${reset}"
            exit 0
            ;;

        *)
            echo -e "\n${Biruu}Dicoba lagi ya Sayang!${reset}"
            ;;
    esac

    echo -e "\n${hijau}Tekan Enter untuk kembali ke Masa Lalu...${reset}"
    read
    clear
    figlet "    MENU SISTEM    " | lolcat
done
