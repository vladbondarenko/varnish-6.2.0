vcl 4.0;

import geoip2;
import std;
import cookie;
import directors;
import header;
import saintmode;
import tcp;
import var;
import vsthrottle;
import xkey;
# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "800";
}

sub vcl_init {
    new country = geoip2.geoip2("/etc/varnish/GeoLite2-Country.mmdb");
}


sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
    std.syslog(180,"Ip: "+client.ip+"|Country: "+country.lookup("country/names/en", client.ip));
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}
