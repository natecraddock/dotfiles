function get_local_ip
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
end

function hugo -a command
    switch $command
        # run on the local network
        case l local
            # to trim off "l" or "local" from the other args
            set argv $argv[2..]

            set ip_addr (get_local_ip)
            command hugo server --bind $ip_addr --baseURL "http://$ip_addr" $argv

        # run on a public network with cloudflared
        case p public
            # to trim off "l" or "local" from the other args
            set argv $argv[2..]

            # create a temporary file
            set tmpfile (mktemp)
            cloudflared tunnel --url http://localhost:1313 2> $tmpfile &

            # wait for the server to start
            echo -n Waiting for cloudflare tunnel to start
            set cloudflare_url
            while test -z $cloudflare_url;
                echo -n .
                set cloudflare_url (grep --color=never -o -m1 "http.*trycloudflare.com" $tmpfile)
                sleep 1
            end
            echo -e " started\n"

            # run hugo through the tunnel
            command hugo server --appendPort=false --baseURL $cloudflare_url $argv
            echo -e "\nShutting down tunnel"
            kill $last_pid
            sleep 1

        # fall through to all other uses of hugo
        case "*"
            command hugo $argv
    end
end
