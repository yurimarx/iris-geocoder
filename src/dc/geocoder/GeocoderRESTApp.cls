Class dc.geocoder.GeocoderRESTApp Extends %CSP.REST
{

Parameter CHARSET = "utf-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter CONTENTTYPE = "application/json";

Parameter Version = "1.0.0";

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<!-- Server Info -->
<Route Url="/" Method="GET" Call="GetInfo" Cors="true"/>
<!-- Swagger specs -->
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />

<!-- Forward geocoding-->
<Route Url="/forward" Method="POST" Call="DoForwardGeocoding" />

<!-- reverse geocoding -->
<Route Url="/reverse" Method="GET" Call="DoReverseGeocoding" />

<!-- ip geocoding -->
<Route Url="/ip" Method="GET" Call="DoIPGeocoder" />

<!-- my ip geocoding -->
<Route Url="/myip" Method="GET" Call="DoMyIPGeocoder" />


</Routes>
}

/// Forward Geocoding
ClassMethod DoForwardGeocoding() As %Status
{
    Try {
      Set Address = $ZCONVERT(%request.Content.Read(),"I","UTF8")
      Set Response = ##class(dc.geocoder.GeocoderService).DoForwardGeocoding(Address)
      Set %response.Status = 200
      Set %response.Headers("Access-Control-Allow-Origin")="*"
      Write Response
      Return $$$OK
    } Catch err {
      write !, "Error name: ", ?20, err.Name,
          !, "Error code: ", ?20, err.Code,
          !, "Error location: ", ?20, err.Location,
          !, "Additional data: ", ?20, err.Data, !
      Return $$$NOTOK
  }
}

/// Reverse Geocoding
ClassMethod DoReverseGeocoding() As %Status
{
    Try {
      Set Lat =  %request.Get("Lat")
      Set Long = %request.Get("Long")
      Set Response = ##class(dc.geocoder.GeocoderService).DoReverseGeocoding(Lat, Long)
      //Set Response = Lat
      Set %response.Status = 200
      Set %response.Headers("Access-Control-Allow-Origin")="*"
      Write Response
      Return $$$OK
    } Catch err {
      write !, "Error name: ", ?20, err.Name,
          !, "Error code: ", ?20, err.Code,
          !, "Error location: ", ?20, err.Location,
          !, "Additional data: ", ?20, err.Data, !
      Return $$$NOTOK
  }
}

/// IP Geocoding
ClassMethod DoIPGeocoder() As %Status
{
    Try {
      Set ip =  %request.Get("IP")
      Set Response = ##class(dc.geocoder.GeocoderService).DoIPGeocoder(ip)
      Set %response.Status = 200
      Set %response.Headers("Access-Control-Allow-Origin")="*"
      Write Response
      Return $$$OK
    } Catch err {
      write !, "Error name: ", ?20, err.Name,
          !, "Error code: ", ?20, err.Code,
          !, "Error location: ", ?20, err.Location,
          !, "Additional data: ", ?20, err.Data, !
      Return $$$NOTOK
  }
}

/// My IP Geocoding
ClassMethod DoMyIPGeocoder() As %Status
{
    Try {
      Set ip =  %request.Get("IP")
      Set Response = ##class(dc.geocoder.GeocoderService).DoMyIPGeocoder()
      Set %response.Status = 200
      Set %response.Headers("Access-Control-Allow-Origin")="*"
      Write Response
      Return $$$OK
    } Catch err {
      write !, "Error name: ", ?20, err.Name,
          !, "Error code: ", ?20, err.Code,
          !, "Error location: ", ?20, err.Location,
          !, "Additional data: ", ?20, err.Data, !
      Return $$$NOTOK
  }
}

/// General information
ClassMethod GetInfo() As %Status
{
  SET version = ..#Version
  SET fmt=##class(%SYS.NLS.Format).%New("ptbw")
  
  SET info = {
    "Service": "Geocoder Service API",
    "version": (version),
    "Developer": "Yuri Gomes",
    "Status": "Ok",
    "Date": ($ZDATETIME($HOROLOG))
  }
  Set %response.ContentType = ..#CONTENTTYPEJSON
  Set %response.Headers("Access-Control-Allow-Origin")="*"

  Write info.%ToJSON()
  Quit $$$OK
}

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/iris-tts" 
  Set swagger.info.title = "TTS Service API"
  Set swagger.info.version = "1.0"
  Set swagger.host = "localhost:52773"
  Return ..%ProcessResult($$$OK, swagger)
}

ClassMethod %ProcessResult(pStatus As %Status = {$$$OK}, pResult As %DynamicObject = "") As %Status [ Internal ]
{
  #dim %response As %CSP.Response
  SET tSC = $$$OK
  IF $$$ISERR(pStatus) {
    SET %response.Status = 500
    SET tSC = ..StatusToJSON(pStatus, .tJSON)
    IF $isobject(tJSON) {
      SET pResult = tJSON
    } ELSE {
      SET pResult = { "errors": [ { "error": "Unknown error parsing status code" } ] }
    }
  } 
  ELSEIF pStatus=1 {
    IF '$isobject(pResult){
      SET pResult = {
      }
    }
  }
  ELSE {
    SET %response.Status = pStatus
    SET error = $PIECE(pStatus, " ", 2, *)
    SET pResult = {
      "error": (error)
    }
  }
  
  IF pResult.%Extends("%Library.DynamicAbstractObject") {
    WRITE pResult.%ToJSON()
  }
  ELSEIF pResult.%Extends("%JSON.Adaptor") {
    DO pResult.%JSONExport()
  }
  ELSEIF pResult.%Extends("%Stream.Object") {
    DO pResult.OutputToDevice()
  }
  
  QUIT tSC
}

}
