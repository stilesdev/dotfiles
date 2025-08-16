enable_and_start_service() {
    local service="$1"
    if ! systemctl is-enabled "$service" > /dev/null; then
        echo "Enabling $service"
        sudo systemctl enable "$service"
    # else
    #     echo "$service already enabled"
    fi
    if ! systemctl is-active "$service" > /dev/null; then
        echo "Starting $service"
        sudo systemctl start "$service"
    # else
    #     echo "$service already running"
    fi
}

enable_and_start_user_service() {
    local service="$1"
    if ! systemctl --user is-enabled "$service" > /dev/null; then
        echo "Enabling $service"
        systemctl --user enable "$service"
    # else
    #     echo "$service already enabled"
    fi
    if ! systemctl --user is-active "$service" > /dev/null; then
        echo "Starting $service"
        systemctl --user start "$service"
    # else
    #     echo "$service already running"
    fi
}

mask_service() {
    local service="$1"
    if [ $(systemctl is-enabled "$service") != 'masked' ]; then
        echo "Masking $service"
        sudo systemctl mask "$service"
    # else
    #     echo "$service already masked"
    fi
}

mask_user_service() {
    local service="$1"
    if [ $(systemctl --user is-enabled "$service") != 'masked' ]; then
        echo "Masking $service"
        systemctl --user mask "$service"
    # else
    #     echo "$service already masked"
    fi
}

add_user_to_group() {
    local user="$1"
    local group="$2"

    if ! groups "$user" | grep "$group" > /dev/null; then
        echo "Adding $user to group $group"
        sudo usermod --append --groups "$group" "$user"
    fi
}

gpg_setup() {
    local key_id="$1"
    local key_url="$2"

    if ! gpg --card-status > /dev/null; then
        echo "Failed to detect YubiKey. Plug in the YubiKey and try running the bootstrap script again"
        return 1
    fi

    if ! gpg --list-keys "$key_id" > /dev/null; then
        echo "Downloading and importing GPG key"
        # gpg --keyserver keys.gnupg.net --recv "$key_id"
        curl "$key_url" | gpg --import -

        echo "Trusting GPG key"
        # echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key "$key_id" trust
        gpg --list-keys --fingerprint "$key_id" | gawk 'NR==2 {gsub(/ /, ""); printf("%s:6:\n", $0)}' | gpg --import-ownertrust
    fi

    mask_user_service gpg-agent.service
    mask_user_service gpg-agent.socket
    mask_user_service gpg-agent-ssh.socket
    mask_user_service gpg-agent-extra.socket
    mask_user_service gpg-agent-browser.socket

    # enable_and_start_service pcscd.service # don't need this enabled and running since it is triggered by pcscd.socket
}
