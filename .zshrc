#zmodload zsh/zprof

for script in ~/.config/shell/*.(z|)sh; do
    . "$script"
done

#zprof
