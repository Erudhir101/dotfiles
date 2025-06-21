#!/usr/bin/env bash

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n  Logout")

# --- Exibição do Menu com Fuzzel ---
# 1. O `echo "$actions"` envia a lista de ações para o Fuzzel.
# 2. O Fuzzel é invocado com as seguintes flags:
#    -d:          Modo dmenu (lê do stdin, escreve a seleção no stdout).
#    --prompt:    Define o texto que aparece no prompt do menu.
selected_option=$(echo -e "$actions" | fuzzel -d --config="$HOME/.config/fuzzel/power-menu.ini")

# --- Tratamento de Saída ---
# Se o usuário pressionar 'Esc' ou fechar o Fuzzel, a variável
# '$selected_option' estará vazia. Neste caso, o script deve sair.
if [[ -z "$selected_option" ]]; then
    exit 0
fi

# --- Processamento da Ação Selecionada ---
# O Fuzzel retorna a linha inteira, incluindo o ícone (ex: "  Lock").
# Usamos o 'sed' para remover o ícone e os espaços, deixando apenas o comando.
# Exemplo: "  Lock" se torna "Lock".
action_name=$(echo "$selected_option" | sed 's/.* //')

# --- Execução da Ação ---
# O 'case' avalia a ação limpa ('action_name') e executa o comando correspondente.
case "$action_name" in
    Lock)
        # Combina lógicas similares para diferentes gerenciadores de janela
        if [[ "$DESKTOP_SESSION" == 'qtile' || "$DESKTOP_SESSION" == 'i3' ]]; then
            betterlockscreen -l blur
        elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
            swaylock
        elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
            hyprlock
        else
            # Um fallback caso nenhum dos lockscreens conhecidos seja encontrado
            echo "Nenhum lockscreen configurado para a sessão: $DESKTOP_SESSION" >&2
            exit 1
        fi
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Suspend)
        systemctl suspend
        ;;
    Hibernate)
        systemctl hibernate
        ;;
    Logout)
        if [[ "$DESKTOP_SESSION" == 'qtile' ]]; then
            qtile cmd-obj -o cmd -f shutdown
        elif [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
            openbox --exit
        elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
            bspc quit
        elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
            i3-msg exit
        elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
            qdbus org.kde.ksmserver /KSMServer logout 0 0 0
        elif [[ "$DESKTOP_SESSION" == 'hyprland' ]]; then
            hyprctl dispatch exit 0
        elif [[ "$DESKTOP_SESSION" == 'dwm' ]]; then
            pkill -KILL -u "$USER"
        elif [[ "$DESKTOP_SESSION" == 'sway' ]]; then
            swaymsg exit
        elif [[ "$DESKTOP_SESSION" == 'niri' ]]; then
            niri msg action quit
        fi
        ;;
esac
