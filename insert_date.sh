# Run this script inside of directory with .md files.
# Datetime of added date will ve written at second line of .md file. If it is already exist - will just overwritten

for file in $(git ls-files "*.md")
do
    HASH=$(git rev-list HEAD "$file" | tail -n 1)
    DATE=$( git log --first-parent master --diff-filter=A --follow --format=%aI -- $file | tail -1 --)
    gsed -i "2s/git-date.*$/git-date: $DATE/; t; 2s/^/git-date: $DATE\r\n/" $file
    printf "%-35s %s\n  %s\n" "$file" $HASH: "$DATE"
done
