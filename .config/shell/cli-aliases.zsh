# Fix extremely slow autocomplete on certain git commands
__git_files () {
    _wanted files expl 'local files' _files
}
