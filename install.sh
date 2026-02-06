#!/bin/bash

# =================================================================
# VANILLA NEWBIE HYPRLAND INSTALLER
# =================================================================

# Colori per l'output
GREEN="\e[32m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${CYAN}Starting Installation of Vanilla Newbie Theme...${RESET}"

# 1. Crea le cartelle necessarie
echo -e "${MAGENTA}[*] Creating directories...${RESET}"
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/dunst
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fastfetch
mkdir -p ~/.local/share/themes
mkdir -p ~/Pictures

# 2. Copia i Config files
echo -e "${GREEN}[*] Copying Dotfiles...${RESET}"
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp -r wofi/* ~/.config/wofi/
cp -r dunst/* ~/.config/dunst/
cp -r alacritty/* ~/.config/alacritty/
cp -r fastfetch/* ~/.config/fastfetch/
cp starship/starship.toml ~/.config/starship.toml

# 3. Copia il Wallpaper
echo -e "${GREEN}[*] Copying Wallpaper...${RESET}"
cp Pictures/vanilla_wallpaper.png ~/Pictures/

# 4. Installa il Tema GTK
echo -e "${GREEN}[*] Installing GTK Theme (Vanilla_Newbie)...${RESET}"
cp -r Vanilla_Newbie ~/.local/share/themes/

# 5. Installa il Tema SDDM (Login Manager) - PASSAGGIO CRITICO
if [ -d "Vanilla_Newbie_Theme_Sddm" ]; then
    echo -e ""
    echo -e "${RED}#############################################################${RESET}"
    echo -e "${YELLOW} ⚠️  ATTENZIONE: INSTALLAZIONE TEMA LOGIN (SDDM) RICHIESTA  ⚠️ ${RESET}"
    echo -e "${RED}#############################################################${RESET}"
    echo -e "${CYAN}Stiamo per installare il tema per la schermata di login (SDDM).${RESET}"
    echo -e "Per fare questo, dobbiamo copiare dei file nella cartella di sistema ${YELLOW}/usr/share/sddm/themes${RESET}."
    echo -e "Questa operazione richiede i permessi di AMMINISTRATORE."
    echo -e "${RED}>>> Inserisci la tua password qui sotto per procedere: <<<${RESET}"
    echo -e ""
    
    # Controlla se esiste la cartella di destinazione
    if [ -d "/usr/share/sddm/themes" ]; then
        sudo cp -r Vanilla_Newbie_Theme_Sddm /usr/share/sddm/themes/
        echo -e "${GREEN}✅ Tema SDDM copiato con successo!${RESET}"
        echo -e "${MAGENTA}    Ricorda di attivarlo modificando il file /etc/sddm.conf${RESET}"
    else
        echo -e "${RED}❌ Errore: SDDM non sembra installato (cartella themes mancante).${RESET}"
    fi
fi

# 6. Permessi di esecuzione
echo -e "${GREEN}[*] Setting permissions...${RESET}"
chmod +x ~/.config/waybar/scripts/power-menu.sh
# Rende eseguibili eventuali script dentro hypr
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null

# 7. Applicazione Settings GTK
echo -e "${CYAN}[*] Applying GTK Theme...${RESET}"
gsettings set org.gnome.desktop.interface gtk-theme "Vanilla_Newbie"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo -e "${CYAN}=========================================${RESET}"
echo -e "${GREEN} INSTALLATION COMPLETE! Please restart Hyprland.${RESET}"
echo -e "${CYAN}=========================================${RESET}"