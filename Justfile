[working-directory: 'dev-tools']
dev-tools:
    nix flake update

[working-directory: 'google-cloud-sdk']
google-cloud-sdk:
    nix flake update

upgrade: dev-tools google-cloud-sdk
    git commit -am "chore: nix flake update"

save: upgrade
    git push
