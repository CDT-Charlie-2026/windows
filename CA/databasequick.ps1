certutil -view `
  -out "RequestID,RequesterName,CertificateTemplate,SerialNumber,Disposition,RevocationDate,RevocationReason,NotBefore,NotAfter" `
  csv > C:\CA-Check\AuthCerts.csv