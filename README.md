# DNSTAP

very simple dnstap listener based on alpine + github.com/dnstap/golang-dnstap/dnstap@latest


## Build
```bash
docker compose build --progress plain --no-cache
```

## Environment

- TAPADDRESS: ip to listen (default: 0.0.0.0)
- TAPPORT: port to listen (default: 6000 )
- TAPFILE: file to save logs to (default: /dev/stdout)
- TAPFORMAT: q,j

## Usage 

* simpliest: console output `docker run`
```bash
docker run -p "6000:6000" edgd1er/dnstap:latest
```

* docker compose: more flexible, rewrite `command` as you wish, 
add to compose.yml
```bash
command: [ "/bin/dnstap","-l","0.0.0.0:6000","-q","-w","/var/log/dnstap/dnstap.log" ]
```

then run 
```bash
docker compose up 
```

list of dnstap options available to change command's default (-l 0.0.0.0:6000 -q -w /dev/stdout) 
```
Usage: dnstap [OPTION]...
  -T value
        write dnstap payloads to tcp/ip address
  -U value
        write dnstap payloads to unix socket
  -a    append to the given file, do not overwrite. valid only when outputting a text or YAML file.
  -j    use verbose JSON output
  -l value
        read dnstap payloads from tcp/ip
  -q    use quiet text output
  -r value
        read dnstap payloads from file
  -t duration
        I/O timeout for tcp/ip and unix domain sockets
  -u value
        read dnstap payloads from unix socket
  -w string
        write output to file
  -y    use verbose YAML output

Quiet text output format mnemonics:
    AQ: AUTH_QUERY
    AR: AUTH_RESPONSE
    RQ: RESOLVER_QUERY
    RR: RESOLVER_RESPONSE
    CQ: CLIENT_QUERY
    CR: CLIENT_RESPONSE
    FQ: FORWARDER_QUERY
    FR: FORWARDER_RESPONSE
    SQ: STUB_QUERY
    SR: STUB_RESPONSE
    TQ: TOOL_QUERY
    TR: TOOL_RESPONSE
```

## text output

```log
dnstap  | 14:23:41.857291 CQ 192.168.0.250 UDP 52b "min.zet.com." IN A
dnstap  | 14:23:42.373987 CR 192.168.0.250 UDP 99b "min.zet.biz." IN A
dnstap  | 14:48:53.621237 CQ 87.121.0.128 UDP 42b "aaa.hmdns.top." IN TXT
```

## For complex usecases or requirements:

Another dnstap project [DNS-Collector](https://github.com/dmachard/DNS-collector) may have more sophisticated options. 

__From its readme:__

DNS-collector is a lightweight tool that captures DNS queries and responses from your DNS servers, processes them intelligently, and sends clean data to your monitoring or analytics systems.

What it does:

    Captures DNS data from your DNS servers (BIND, PowerDNS, Unbound, etc.) via DNStap protocol or live network capture
    Filters out noise like health checks, internal queries, or spam before storage
    Enriches data with GeoIP, threat intelligence, or custom metadata
    Outputs clean data to files, databases, SIEM tools, or monitoring dashboards
