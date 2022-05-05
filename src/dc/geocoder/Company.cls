Class dc.geocoder.Company Extends %Persistent
{

Property Name As %String;

Property Street As %String(MAXLEN = 200);

Property City As %String(MAXLEN = 80);

Property State As %String(MAXLEN = 2);

Property Zip As %String(MAXLEN = 5);

Property Address As %String [ Calculated, SqlComputeCode = {set {*}={Street}_", "_{City}_", "_{State}}, SqlComputed ];

ClassMethod CreateFiveCompanies() As %Status
{
    Do ..CreateCompany("InterSystems", "One Memorial Drive", "Cambridge", "MA", "")
    Do ..CreateCompany("Google", "1600 Amphitheatre Parkway", "Mountain View", "CA", "")
    Do ..CreateCompany("Microsoft", "One Microsoft Way", "Redmond", "WA", "")
    Do ..CreateCompany("IBM", "1 Orchard Rd", "Armonk", "NY", "")
    Do ..CreateCompany("Amazon", "410 Terry Ave. N", "Seattle", "WA", "")
}

ClassMethod CreateCompany(Name As %String, Street As %String, City As %String, State As %String, Zip As %String) As %Status
{
 
    Set company = ##class(dc.geocoder.Company).%New()
    Set company.Name = Name
    Set company.Street = Street
    Set company.City = City
    Set company.State = State
    Set company.Zip = Zip

    Set sc = company.%Save()

    Return sc
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Street</Value>
</Value>
<Value name="4">
<Value>City</Value>
</Value>
<Value name="5">
<Value>State</Value>
</Value>
<Value name="6">
<Value>Zip</Value>
</Value>
<Value name="7">
<Value>Address</Value>
</Value>
</Data>
<DataLocation>^dc.geocoder.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^dc.geocoder.PersonD</IdLocation>
<IndexLocation>^dc.geocoder.PersonI</IndexLocation>
<StreamLocation>^dc.geocoder.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
