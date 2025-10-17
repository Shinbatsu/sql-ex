for f in *.sql; do
    sql-formatter -i 2 -k upper "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done