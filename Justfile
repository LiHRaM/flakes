set shell := ["nu", "-c"]

nix := require("nix")
skim := require("sk")

flakes := `ls **/flake.nix | each {|row| "./" + ($row.name | path dirname) } | to nuon`

# If you run Just without an argument,
# it opens up a fuzzy task picker
default:
    @just --choose --chooser {{skim}}

# Update any and all flakes
update +FLAKES=flakes:
    {{FLAKES}} | par-each {|dir| {{nix}} flake update --flake $dir | complete }

# Commit and save all changes
save MESSAGE='feat: manual changes':
    git commit -am "{{MESSAGE}}"
    git push

# Update all lockfiles and commit the changes
upgrade: update (save 'chore: nix flake update')
    echo "All flakes have been upgraded"
