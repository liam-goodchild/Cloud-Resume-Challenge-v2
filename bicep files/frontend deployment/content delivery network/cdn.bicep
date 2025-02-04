param cdnpName string
param cdneName string
param cdneDomain string
param cdneFQDN string
param storageAccountName string

resource cdnProfile 'Microsoft.Cdn/profiles@2024-09-01' = {
  name: cdnpName
  location: 'global'
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2024-09-01' = {
  parent: cdnProfile
  name: cdneName
  location: 'global'
  properties: {
    isCompressionEnabled: true
    originHostHeader: '${storageAccountName}.z33.web.${environment().suffixes.storage}'
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: '${storageAccountName}.z33.web.${environment().suffixes.storage}'
          httpPort: 80
          httpsPort: 443
        }
      }
    ]
  }
}

resource cdnDomain 'Microsoft.Cdn/profiles/endpoints/customDomains@2024-09-01' = {
  parent: cdnEndpoint
  name: cdneDomain
  properties: {
    hostName: cdneFQDN
  }
}
