;
; BIND data file for example.com
;
$TTL    3h
@       IN      SOA     ns1.example.com. admin.example.com. (
                          1        ; Serial
                          3h       ; Refresh after 3 hours
                          1h       ; Retry after 1 hour
                          1w       ; Expire after 1 week
                          1h )     ; Negative caching TTL of 1 day
;
@       IN      NS      ns1.example.com.
@       IN      NS      ns2.example.com.


example.com.    IN      MX      10      mail.example.com.
example.com.    IN      A       192.168.0.10
ns1                     IN      A       192.168.0.10
ns2                     IN      A       192.168.0.11
www                     IN      CNAME   example.com.
mail                    IN      A       192.168.0.10
ftp                     IN      CNAME   example.com.
