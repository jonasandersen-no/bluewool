#!/usr/bin/env fish

# Go to the directory this script is in
cd (dirname (status --current-filename))

set base_commit (git describe --tags --abbrev=0 2>/dev/null)
set target_commit HEAD

if test (count $argv) -ge 1
    set base_commit $argv[1]
end

if test (count $argv) -ge 2
    set target_commit $argv[2]
end

echo "Updated mods in $target_commit compared to $base_commit:"
echo

set added_mods
set updated_mods
set removed_mods
set renamed_mods
set changed_mods

git diff --name-status $base_commit $target_commit -- '*.pw.toml' | while read -l line
    set parts (string split \t -- $line)

    set change_status $parts[1]
    set path $parts[2]

    # Handle renamed files:
    # git outputs: R100    old/path    new/path
    if string match -q 'R*' -- $change_status
        set path $parts[3]
    end

    # Only include actual mod metadata files
    if not string match -q 'mods/*.pw.toml' -- $path
        continue
    end

    set label Changed
    set content_commit $target_commit

    switch $change_status
        case D
            set label Removed
            set content_commit $base_commit
        case A
            set label Added
        case M
            set label Updated
        case 'R*'
            set label Renamed
    end

    set name (git show "$content_commit:$path" 2>/dev/null \
        | string match -r '^name[[:space:]]*=[[:space:]]*".*"' \
        | head -n 1 \
        | string replace -r '^name[[:space:]]*=[[:space:]]*"([^"]+)".*$' '$1')

    if test -z "$name"
        set name $path
    end

    switch $label
        case Added
            set --append added_mods "$name"
        case Updated
            set --append updated_mods "$name"
        case Removed
            set --append removed_mods "$name"
        case Renamed
            set --append renamed_mods "$name"
        case Changed
            set --append changed_mods "$name"
    end
end

if test (count $added_mods) -gt 0
    echo "Added:"
    echo
    for name in $added_mods
        echo "* $name"
    end
    echo
end

if test (count $updated_mods) -gt 0
    echo "Updated:"
    echo
    for name in $updated_mods
        echo "* $name"
    end
    echo
end

if test (count $removed_mods) -gt 0
    echo "Removed:"
    echo
    for name in $removed_mods
        echo "* $name"
    end
    echo
end

if test (count $renamed_mods) -gt 0
    echo "Renamed:"
    echo
    for name in $renamed_mods
        echo "* $name"
    end
    echo
end

if test (count $changed_mods) -gt 0
    echo "Changed:"
    echo
    for name in $changed_mods
        echo "* $name"
    end
    echo
end
