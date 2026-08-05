
alias cat = open

def pin [] {
    git add .
    git commit -m "update: snapshot"
    git push
}

def branch-prune [] {
    git remote prune origin
}
