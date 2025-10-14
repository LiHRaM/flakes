set shell := ["nu", "-c"]

nix := require("nix")
skim := require("sk")

flakes := `ls **/flake.nix | each {|row| "./" + ($row.name | path dirname) } | to nuon`

# If you run Just without an argument,
# it opens up a fuzzy task picker
default:
    @just --choose --chooser {{skim}}

update +FLAKES=flakes:
    {{FLAKES}} | par-each {|dir| {{nix}} flake update --flake $dir | complete }

save:
    git commit -am "chore: updates"
    git push


update-commit: update save
    echo "All flakes have been upgraded"
