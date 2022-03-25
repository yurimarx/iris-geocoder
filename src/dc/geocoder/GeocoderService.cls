/// Geocoder services
Class dc.geocoder.GeocoderService
{

// Forward Geocoding

ClassMethod DoForwardGeocoding(address) [ Language = python ]
{
        import geocoder
        import os
        import json

        g = geocoder.google(address, key=os.environ["GOOGLE_API_KEY"])
        return json.dumps(g.json)
}

// Reverse Geocoding

ClassMethod DoReverseGeocoding(lat, long) [ Language = python ]
{
        import geocoder
        import os
        import json

        g = geocoder.google([lat, long], key=os.environ["GOOGLE_API_KEY"], method='reverse')
        return json.dumps(g.json)
}

// IP Addresses

ClassMethod DoIPGeocoder(ip) [ Language = python ]
{
        import geocoder
        import json
        g = geocoder.ip(ip)
        #g = geocoder.ip('me')
        return json.dumps(g.json)
}

// My IP Addresses

ClassMethod DoMyIPGeocoder() [ Language = python ]
{
        import geocoder
        import json
        g = geocoder.ip('me')
        return json.dumps(g.json)
}

}
