Class dc.geocoder.Geocoder Extends %RegisteredObject
{

ClassMethod GetInfo(field As %String, address As %String) As %String [ SqlProc ]
{
 
    Set Result = {}
    Set LatLong = ##class(dc.geocoder.GeocoderService).DoForwardGeocoding(address)
    Set Result = {}.%FromJSON(LatLong)
    Quit Result.%Get(field)
}

}
