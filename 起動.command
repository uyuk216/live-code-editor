#!/bin/zsh
cd -- "${0:A:h}" || exit 1
port=8765
while /usr/bin/curl -fsS "http://localhost:$port/" >/dev/null 2>&1; do
  ((port++))
done
(sleep 0.5; open "http://localhost:$port/") &
exec /usr/bin/python3 -m http.server "$port" --bind 127.0.0.1
