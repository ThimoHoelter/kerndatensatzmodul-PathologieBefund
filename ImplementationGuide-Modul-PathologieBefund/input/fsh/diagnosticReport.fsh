// This is a simple example of a FSH file.
// This file can be renamed, and additional FSH files can be added.
// SUSHI will look for definitions in any file using the .fsh ending.

// Aliases
Alias: LOINC = http://loinc.org/

// Profile definition
Profile: PathologieBefundbericht
Parent: DiagnosticReport
Id: PathologieBefundbericht
Title: "Pathologie Befundbericht"
Description: "Defines the general pathology report structure for German hospitals with the defined terms by the Medical Informatics Initiative"

// set to draft
* ^status = #draft

// ID
* id MS
// Identifikator
* identifier 1.. MS
// Identifier Slice in Set-ID und Versionsnummer
* identifier ^slicing.discriminator[0].type = #pattern
* identifier ^slicing.discriminator[0].path = "$this"
* identifier ^slicing.rules = #open
* identifier contains Set-ID 1..1
// Versionsnummer
* meta MS
* meta.versionId MS
// Referenz zum Untersuchungsauftrag
* basedOn 1.. MS
* basedOn only Reference(ServiceRequest)
// Status
* status MS
// Code
* code MS
* code.coding.system MS
* code.coding.code MS
* code.coding.display MS
// define slice for pathology report code
* code ^slicing.discriminator[0].type = #pattern
* code ^slicing.discriminator[0].path = "$this"
* code ^slicing.rules = #open
* code contains pathology-report 1..1
* code[pathology-report] = LOINC#60568-3 "Pathology Synoptic report"

//LOINC#60568-3 "Pathology Synoptic report"
// Referenz zu Patient*in
* subject 1.. MS
* subject only Reference(Patient)
// Referenz zu Fall (z.B. ueber Aufnahmenummer/Fallnummer)
* encounter MS
// Dokumentationsdatum
* effective[x] MS
* effective[x] only dateTime
//* issued MS // nur fuer maschinell erstellte Zeitstempel, fuer manuell eingetragene Zeiten effective[x] dateTime nutzen
// Autor 
// TODO: kann der Autor auch eine Organisation sein oder handelt es sich hierbei immer um einen Practitioner? 
* performer 1.. MS
// Referenz zur Probe
* specimen 1.. MS
// Beobachtungsabschnitte bzw. Beobachtungen
* result 1.. MS
// Referenz zu angehaengten Bildern inkl. Informationen dazu (Bsp. DICOM)
* imagingStudy MS
// Referenz zu angehaengten Bildern
* media MS
* media.comment MS
* media.link MS
// zugehoeriges Dokument
* presentedForm MS

// Example