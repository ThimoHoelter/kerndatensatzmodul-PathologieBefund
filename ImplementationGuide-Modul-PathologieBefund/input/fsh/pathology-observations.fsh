// BasePathologyObservation
// Entweder neue Base Observation profilieren oder wenn passend Laboruntersuchung aus Modul Labor als Base Observation nehmen
Profile: BasePathologyObservation
Parent: Observation
Id: BasePathologyObservation
Title: "BasePathologyObservation"
Description: "Abstract Observation to define common features of a main pathology observation"
* insert RuleSet1
* ^abstract = true
* id MS
* identifier MS
* basedOn MS 
* basedOn only Reference(PathologyServiceRequest)
* status MS
* category 1.. MS 
  * coding 1.. MS
  * coding ^slicing.discriminator[0].type = #pattern
  * coding ^slicing.discriminator[0].path = "$this"
  * coding ^slicing.rules = #open
  * coding contains laboratory-category 1..1 MS
  * coding[laboratory-category] = $obs-category#laboratory
// Code
* code MS
  * coding MS
    * code MS
    * system MS
// Referenz - Patient:in
* subject MS
* subject only Reference(Patient)
// Befundzeit
* effective[x] MS
* effective[x] only dateTime
//* effectiveDateTime 1.. MS
// Wert
* value[x] MS
* value[x] only Quantity or CodeableConcept
// Koerperstelle
* bodySite MS
  * coding ^slicing.discriminator.type = #pattern
  * coding ^slicing.discriminator.path = "$this"
  * coding ^slicing.rules = #open
  * coding contains sct 0..1 MS
  * coding[sct] from $bio-bodystructure (required)
    * system 1.. 
    * system = $SCT
// Untersuchungsmethode
* method MS
// Referenz - Probe
* specimen MS


// ProcedureSteps
Profile: ProcedureSteps
Parent: BasePathologyObservation
Id: ProcedureSteps
Title: "ProcedureSteps"
Description: "Concrete Observation which contains the description of specimen collection and processing. Based on IHE PaLM APSR - ProcedureSteps"
* insert RuleSet1
* code.coding.code ^fixedCode = #46059-2
* code.coding.system ^fixedUri = $LOINC
* code.coding.display ^fixedString = "Special treatments and procedures section"
* specimen 1.. MS
* note 1.. MS


// GenericPathologyFinding
Profile: GenericPathologyFinding
Parent: BasePathologyObservation
Id: GenericPathologyFinding
Title: "GenericPathologyFinding"
Description: "Concrete Observation to describe a generic pathology finding, based on IHE PaLM APSR - Additional Specified Observation Section"
* insert RuleSet1
// tmp - later custom VS (extensible)
* code.coding from $LOINC (preferred)
// Moegliche Unterbeobachtungen
* hasMember MS
// Referenz - Eingebettetes Bild
* derivedFrom MS
* derivedFrom only Reference(AttachedImage)

// IntraoperativeObservation
Profile: IntraoperativeObservation
Parent: GenericPathologyFinding
Id: IntraoperativeObservation
Title: "IntraoperativeObservation"
Description: "Based on IHE PaLM APSR - Intraoperative Observation Section"
* insert RuleSet1
* code.coding.code ^fixedCode = #83321-0 
* code.coding.system ^fixedUri = $LOINC
* code.coding.display = "Pathology report intraoperative observation in Specimen Document"
* derivedFrom only Reference(AttachedImage)

// Macroscopic Observation
Profile: MacroscopicObservation
Parent: GenericPathologyFinding
Id: MacroscopicObservation
Title: "MacroscopicObservation"
Description: "Based on IHE PaLM APSR - Macroscopic Observation Finding"
* insert RuleSet1
* code.coding.code ^fixedCode = #22634-0
* code.coding.system ^fixedUri = $LOINC
* code.coding.display ^fixedString = "Pathology report gross observation Narrative"
// Makro-Bild
* derivedFrom ^slicing.discriminator[0].type = #pattern
* derivedFrom ^slicing.discriminator[0].path = "$this"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains macroscopic-image 0..1 MS
* derivedFrom[macroscopic-image] only Reference(AttachedImage)
// Skizze
* derivedFrom ^slicing.discriminator[1].type = #pattern
* derivedFrom ^slicing.discriminator[1].path = "$this"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains macroscopic-sketch 0..1 MS
* derivedFrom[macroscopic-sketch] only Reference(AttachedImage)

// Microscopic Observation
Profile: MicroscopicObservation
Parent: GenericPathologyFinding
Id: MicroscopicObservation
Title: "MicroscopicObservation"
Description: "Based on IHE PaLM APSR - Microscopic Observation Finding"
* insert RuleSet1
* code.coding.code ^fixedCode = #22635-7
* code.coding.system ^fixedUri = $LOINC
* code.coding.display ^fixedString = "Pathology report microscopic observation Narrative Other stain"
// Mikro-Bild
* derivedFrom ^slicing.discriminator[0].type = #pattern
* derivedFrom ^slicing.discriminator[0].path = "$this"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains microscopic-image 0..1 MS
* derivedFrom[microscopic-image] only Reference(AttachedImage)
// ROI
* derivedFrom ^slicing.discriminator[1].type = #pattern
* derivedFrom ^slicing.discriminator[1].path = "$this"
* derivedFrom ^slicing.rules = #open
* derivedFrom contains microscopic-ROI 0..1 MS
* derivedFrom[microscopic-ROI] only Reference(AttachedImage)

/*
// DiagnosticConclusion
Profile: DiagnosticConclusion
Parent: DiagnosticReport
Id: DiagnosticConclusion
Title: "DiagnosticConclusion"
Description: "tbd"
* insert RuleSet1
*/
