"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser.


"
Class {
	#name : #ManifestLobster,
	#superclass : #PackageManifest,
	#category : #'Lobster-Manifest'
}

{ #category : #'code-critics' }
ManifestLobster class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#Lobster)) #'2020-03-15T22:31:53.754845-03:00') )
]

{ #category : #'code-critics' }
ManifestLobster class >> ruleRBExtraBlockRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#Lobster)) #'2020-02-28T17:35:34.829329-03:00') )
]

{ #category : #'code-critics' }
ManifestLobster class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#Lobster)) #'2020-02-29T09:14:46.630825-03:00') )
]

{ #category : #'code-critics' }
ManifestLobster class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#LBServer)) #'2020-02-28T17:36:18.437521-03:00') )
]
