<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.24 (Build 197) (http://www.copasi.org) at 2021-11-15 15:18:17 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="24" versionDevel="197" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_14" name="Mass action (reversible)" type="MassAction" reversible="true">
      <MiriamAnnotation>
<rdf:RDF xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
   <rdf:Description rdf:about="#Function_14">
   <CopasiMT:is rdf:resource="urn:miriam:obo.sbo:SBO:0000042" />
   </rdf:Description>
   </rdf:RDF>
      </MiriamAnnotation>
      <Comment>
        <body xmlns="http://www.w3.org/1999/xhtml">
<b>Mass action rate law for reversible reactions</b>
<p>
Reaction scheme where the products are created from the reactants and the change of a product quantity is proportional to the product of reactant activities. The reaction scheme does include a reverse process that creates the reactants from the products.
</p>
</body>
      </Comment>
      <Expression>
        k1*PRODUCT&lt;substrate_i>-k2*PRODUCT&lt;product_j>
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_69" name="k1" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_68" name="substrate" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_78" name="k2" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_79" name="product" order="3" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="vAK" type="UserDefined" reversible="unspecified">
      <Expression>
        k1*ADP^2-AMP*ATP*k2
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_276" name="ADP" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_277" name="AMP" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_278" name="ATP" order="2" role="variable"/>
        <ParameterDescription key="FunctionParameter_279" name="k1" order="3" role="variable"/>
        <ParameterDescription key="FunctionParameter_280" name="k2" order="4" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="v1sub1prod" type="UserDefined" reversible="unspecified">
      <Expression>
        Vfmax*S*(1-P/(Keq*S))/(Ks*(1+S/Ks+P/Kp))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_281" name="Vfmax" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_282" name="Keq" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_283" name="S" order="2" role="variable"/>
        <ParameterDescription key="FunctionParameter_284" name="Ks" order="3" role="variable"/>
        <ParameterDescription key="FunctionParameter_285" name="P" order="4" role="variable"/>
        <ParameterDescription key="FunctionParameter_286" name="Kp" order="5" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="v2sub2prod" type="UserDefined" reversible="unspecified">
      <Expression>
        Vfmax*S1*S2*(1-P1*P2/(Keq*S1*S2))/(Ks1*Ks2*(1+S1/Ks1+P1/Kp1)*(1+S2/Ks2+P2/Kp2))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_287" name="Vfmax" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_288" name="Keq" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_289" name="S1" order="2" role="variable"/>
        <ParameterDescription key="FunctionParameter_290" name="Ks1" order="3" role="variable"/>
        <ParameterDescription key="FunctionParameter_291" name="S2" order="4" role="variable"/>
        <ParameterDescription key="FunctionParameter_292" name="Ks2" order="5" role="variable"/>
        <ParameterDescription key="FunctionParameter_293" name="P1" order="6" role="variable"/>
        <ParameterDescription key="FunctionParameter_294" name="Kp1" order="7" role="variable"/>
        <ParameterDescription key="FunctionParameter_295" name="P2" order="8" role="variable"/>
        <ParameterDescription key="FunctionParameter_296" name="Kp2" order="9" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="v1sub" type="UserDefined" reversible="unspecified">
      <Expression>
        Vfmax*S/(Ks*(1+S/Ks))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_301" name="Vfmax" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_302" name="S" order="1" role="variable"/>
        <ParameterDescription key="FunctionParameter_303" name="Ks" order="2" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="Function for TPI_g" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(TPI_g_Vmax,TPI_g_Keq,DHAP_g,TPI_g_KmDHAP,GA3P_g,TPI_g_KmGA3P)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_317" name="DHAP_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_316" name="GA3P_g" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_315" name="TPI_g_Keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_314" name="TPI_g_KmDHAP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_313" name="TPI_g_KmGA3P" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_312" name="TPI_g_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_311" name="glycosome" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for PYK_c" type="UserDefined" reversible="true">
      <Expression>
        PYK_c_Vmax*ADP_c*(1-Pyr_c*ATP_c/(PYK_c_Keq*PEP_c*ADP_c))*(PEP_c/(PYK_c_KmPEP*(1+ADP_c/PYK_c_KiADP+ATP_c/PYK_c_KiATP)))^PYK_c_n/(PYK_c_KmADP*(1+(PEP_c/(PYK_c_KmPEP*(1+ADP_c/PYK_c_KiADP+ATP_c/PYK_c_KiATP)))^PYK_c_n+Pyr_c/PYK_c_KmPyr)*(1+ADP_c/PYK_c_KmADP+ATP_c/PYK_c_KmATP))/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_345" name="ADP_c" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_344" name="ATP_c" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_343" name="PEP_c" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_342" name="PYK_c_Keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_341" name="PYK_c_KiADP" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_340" name="PYK_c_KiATP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_339" name="PYK_c_KmADP" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_338" name="PYK_c_KmATP" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_337" name="PYK_c_KmPEP" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_336" name="PYK_c_KmPyr" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_335" name="PYK_c_Vmax" order="10" role="constant"/>
        <ParameterDescription key="FunctionParameter_334" name="PYK_c_n" order="11" role="constant"/>
        <ParameterDescription key="FunctionParameter_333" name="Pyr_c" order="12" role="product"/>
        <ParameterDescription key="FunctionParameter_332" name="cytosol" order="13" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="Function for PFK_g" type="UserDefined" reversible="true">
      <Expression>
        PFK_g_Vmax*PFK_g_Ki1*Fru6P_g*ATP_g*(1-Fru16BP_g*ADP_g/(PFK_g_Keq*Fru6P_g*ATP_g))/(PFK_g_KmFru6P*PFK_g_KmATP*(Fru16BP_g+PFK_g_Ki1)*(PFK_g_KsATP/PFK_g_KmATP+Fru6P_g/PFK_g_KmFru6P+ATP_g/PFK_g_KmATP+ADP_g/PFK_g_KmADP+Fru16BP_g*ADP_g/(PFK_g_KmADP*PFK_g_Ki2)+Fru6P_g*ATP_g/(PFK_g_KmFru6P*PFK_g_KmATP)))/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_371" name="ADP_g" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_370" name="ATP_g" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_369" name="Fru16BP_g" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_368" name="Fru6P_g" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_367" name="PFK_g_Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_366" name="PFK_g_Ki1" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_365" name="PFK_g_Ki2" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_364" name="PFK_g_KmADP" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_363" name="PFK_g_KmATP" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_362" name="PFK_g_KmFru6P" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_361" name="PFK_g_KsATP" order="10" role="constant"/>
        <ParameterDescription key="FunctionParameter_360" name="PFK_g_Vmax" order="11" role="constant"/>
        <ParameterDescription key="FunctionParameter_304" name="glycosome" order="12" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for PGAM_c" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(PGAM_c_Vmax,PGAM_c_Keq,_3PGA_c,PGAM_c_Km3PGA,_2PGA_c,PGAM_c_Km2PGA)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_389" name="PGAM_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_388" name="PGAM_c_Km2PGA" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_387" name="PGAM_c_Km3PGA" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_386" name="PGAM_c_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_385" name="_2PGA_c" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_306" name="_3PGA_c" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_310" name="cytosol" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="v1sub_1" type="UserDefined" reversible="false">
      <Expression>
        PyrT_c_Vmax*Pyr_c/(PyrT_c_KmPyr*(1+Pyr_c/PyrT_c_KmPyr))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_327" name="PyrT_c_KmPyr" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_309" name="PyrT_c_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_326" name="Pyr_c" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="Function for GlcT_c" type="UserDefined" reversible="true">
      <Expression>
        GlcT_c_Vmax*(Glc_e-Glc_c)/(GlcT_c_KmGlc+Glc_e+Glc_c+GlcT_c_alpha*Glc_e*Glc_c/GlcT_c_KmGlc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_405" name="GlcT_c_KmGlc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_404" name="GlcT_c_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_403" name="GlcT_c_alpha" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_402" name="Glc_c" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_401" name="Glc_e" order="4" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="Function for ALD_g" type="UserDefined" reversible="true">
      <Expression>
        ALD_g_Vmax*Fru16BP_g*(1-GA3P_g*DHAP_g/(Fru16BP_g*ALD_g_Keq))/(ALD_g_KmFru16BP*(1+ATP_g/ALD_g_KiATP+ADP_g/ALD_g_KiADP+AMP_g/ALD_g_KiAMP)*(1+GA3P_g/ALD_g_KmGA3P+DHAP_g/ALD_g_KmDHAP+Fru16BP_g/(ALD_g_KmFru16BP*(1+ATP_g/ALD_g_KiATP+ADP_g/ALD_g_KiADP+AMP_g/ALD_g_KiAMP))+GA3P_g*DHAP_g/(ALD_g_KmGA3P*ALD_g_KmDHAP)+Fru16BP_g*GA3P_g/(ALD_g_KmFru16BP*ALD_g_KiGA3P*(1+ATP_g/ALD_g_KiATP+ADP_g/ALD_g_KiADP+AMP_g/ALD_g_KiAMP))))/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_437" name="ADP_g" order="0" role="modifier"/>
        <ParameterDescription key="FunctionParameter_436" name="ALD_g_Keq" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_435" name="ALD_g_KiADP" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_434" name="ALD_g_KiAMP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_433" name="ALD_g_KiATP" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_432" name="ALD_g_KiGA3P" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_431" name="ALD_g_KmDHAP" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_430" name="ALD_g_KmFru16BP" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_429" name="ALD_g_KmGA3P" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_428" name="ALD_g_Vmax" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_427" name="AMP_g" order="10" role="modifier"/>
        <ParameterDescription key="FunctionParameter_426" name="ATP_g" order="11" role="modifier"/>
        <ParameterDescription key="FunctionParameter_425" name="DHAP_g" order="12" role="product"/>
        <ParameterDescription key="FunctionParameter_424" name="Fru16BP_g" order="13" role="substrate"/>
        <ParameterDescription key="FunctionParameter_423" name="GA3P_g" order="14" role="product"/>
        <ParameterDescription key="FunctionParameter_422" name="glycosome" order="15" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="Function for ENO_c" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(ENO_c_Vmax,ENO_c_Keq,_2PGA_c,ENO_c_Km2PGA,PEP_c,ENO_c_KmPEP)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_415" name="ENO_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_417" name="ENO_c_Km2PGA" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_413" name="ENO_c_KmPEP" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_420" name="ENO_c_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_419" name="PEP_c" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_411" name="_2PGA_c" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_418" name="cytosol" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="Function for HXK_g" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(HXK_g_Vmax,HXK_g_Keq,Glc_g,HXK_g_KmGlc,ATP_g,HXK_g_KmATP,Glc6P_g,HXK_g_KmGlc6P,ADP_g,HXK_g_KmADP)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_473" name="ADP_g" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_472" name="ATP_g" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_471" name="Glc6P_g" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_470" name="Glc_g" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_469" name="HXK_g_Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_468" name="HXK_g_KmADP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_467" name="HXK_g_KmATP" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_466" name="HXK_g_KmGlc" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_465" name="HXK_g_KmGlc6P" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_464" name="HXK_g_Vmax" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_463" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="mass_action_rev_1" type="UserDefined" reversible="true">
      <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Function_56">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2021-11-15T11:46:48Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

      </MiriamAnnotation>
      <Expression>
        _3PGAT_g_k*_3PGA_g-_3PGAT_g_k*_3PGA_c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_461" name="_3PGAT_g_k" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_308" name="_3PGA_c" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_421" name="_3PGA_g" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="Function for PGK_g" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(PGK_g_Vmax,PGK_g_Keq,_13BPGA_g,PGK_g_Km13BPGA,ADP_g,PGK_g_KmADP,_3PGA_g,PGK_g_Km3PGA,ATP_g,PGK_g_KmATP)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_501" name="ADP_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_500" name="ATP_g" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_499" name="PGK_g_Keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_498" name="PGK_g_Km13BPGA" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_497" name="PGK_g_Km3PGA" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_496" name="PGK_g_KmADP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_495" name="PGK_g_KmATP" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_494" name="PGK_g_Vmax" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_493" name="_13BPGA_g" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_492" name="_3PGA_g" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_491" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="Function for G3PDH_g" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(G3PDH_g_Vmax,G3PDH_g_Keq,DHAP_g,G3PDH_g_KmDHAP,NADH_g,G3PDH_g_KmNADH,Gly3P_g,G3PDH_g_KmGly3P,NAD_g,G3PDH_g_KmNAD)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_523" name="DHAP_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_522" name="G3PDH_g_Keq" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_521" name="G3PDH_g_KmDHAP" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_520" name="G3PDH_g_KmGly3P" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_519" name="G3PDH_g_KmNAD" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_518" name="G3PDH_g_KmNADH" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_517" name="G3PDH_g_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_516" name="Gly3P_g" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_515" name="NADH_g" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_514" name="NAD_g" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_513" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="Function for GPO_c" type="UserDefined" reversible="false">
      <Expression>
        v1sub(GPO_c_Vmax,Gly3P_c,GPO_c_KmGly3P)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_416" name="GPO_c_KmGly3P" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_488" name="GPO_c_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_485" name="Gly3P_c" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_490" name="cytosol" order="3" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="Function for ATPu_c" type="UserDefined" reversible="false">
      <Expression>
        ATPu_c_k*ATP_c/ADP_c/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_539" name="ADP_c" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_538" name="ATP_c" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_537" name="ATPu_c_k" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_536" name="cytosol" order="3" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="v2sub2prod_1" type="UserDefined" reversible="true">
      <Expression>
        GK_g_Vmax*Gly3P_g*ADP_g*(1-Gly_e*ATP_g/(GK_g_Keq*Gly3P_g*ADP_g))/(GK_g_KmGly3P*GK_g_KmADP*(1+Gly3P_g/GK_g_KmGly3P+Gly_e/GK_g_KmGly)*(1+ADP_g/GK_g_KmADP+ATP_g/GK_g_KmATP))
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_559" name="ADP_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_558" name="ATP_g" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_557" name="GK_g_Keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_556" name="GK_g_KmADP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_555" name="GK_g_KmATP" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_554" name="GK_g_KmGly" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_553" name="GK_g_KmGly3P" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_552" name="GK_g_Vmax" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_551" name="Gly3P_g" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_550" name="Gly_e" order="9" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="Function for AK_c" type="UserDefined" reversible="true">
      <Expression>
        vAK(ADP_c,AMP_c,ATP_c,AK_c_k1,AK_c_k2)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_571" name="ADP_c" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_570" name="AK_c_k1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_459" name="AK_c_k2" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_544" name="AMP_c" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_545" name="ATP_c" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_547" name="cytosol" order="5" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="Function for PGI_g" type="UserDefined" reversible="true">
      <Expression>
        PGI_g_Vmax*Glc6P_g*(1-Fru6P_g/(PGI_g_Keq*Glc6P_g))/(PGI_g_KmGlc6P*(1+Glc6P_g/PGI_g_KmGlc6P+Fru6P_g/PGI_g_KmFru6P+_6PG_g/PGI_g_Ki6PG))/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_589" name="Fru6P_g" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_588" name="Glc6P_g" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_587" name="PGI_g_Keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_586" name="PGI_g_Ki6PG" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_585" name="PGI_g_KmFru6P" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_584" name="PGI_g_KmGlc6P" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_583" name="PGI_g_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_582" name="_6PG_g" order="7" role="modifier"/>
        <ParameterDescription key="FunctionParameter_581" name="glycosome" order="8" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="Function for GAPDH_g" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(GAPDH_g_Vmax,GAPDH_g_Keq,GA3P_g,GAPDH_g_KmGA3P,NAD_g,GAPDH_g_KmNAD,_13BPGA_g,GAPDH_g_Km13BPGA,NADH_g,GAPDH_g_KmNADH)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_611" name="GA3P_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_610" name="GAPDH_g_Keq" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_609" name="GAPDH_g_Km13BPGA" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_608" name="GAPDH_g_KmGA3P" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_607" name="GAPDH_g_KmNAD" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_606" name="GAPDH_g_KmNADH" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_605" name="GAPDH_g_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_604" name="NADH_g" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_603" name="NAD_g" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_602" name="_13BPGA_g" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_601" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="Function for AK_g" type="UserDefined" reversible="true">
      <Expression>
        vAK(ADP_g,AMP_g,ATP_g,AK_g_k1,AK_g_k2)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_623" name="ADP_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_549" name="AK_g_k1" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_578" name="AK_g_k2" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_489" name="AMP_g" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_546" name="ATP_g" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_579" name="glycosome" order="5" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="Function for GDA_g" type="UserDefined" reversible="true">
      <Expression>
        Gly3P_g*GDA_g_k*DHAP_c-Gly3P_c*GDA_g_k*DHAP_g
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_633" name="DHAP_c" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_632" name="DHAP_g" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_631" name="GDA_g_k" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_630" name="Gly3P_c" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_600" name="Gly3P_g" order="4" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="mass_action_irrev" type="UserDefined" reversible="unspecified">
      <Expression>
        k*S
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_641" name="k" order="0" role="variable"/>
        <ParameterDescription key="FunctionParameter_642" name="S" order="1" role="variable"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="Function for G6PDH_g" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(G6PDH_g_Vmax,G6PDH_g_Keq,Glc6P_g,G6PDH_g_KmGlc6P,NADP_g,G6PDH_g_KmNADP,_6PGL_g,G6PDH_g_Km6PGL,NADPH_g,G6PDH_g_KmNADPH)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_649" name="G6PDH_g_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_645" name="G6PDH_g_Km6PGL" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_666" name="G6PDH_g_KmGlc6P" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_667" name="G6PDH_g_KmNADP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_668" name="G6PDH_g_KmNADPH" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_669" name="G6PDH_g_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_670" name="Glc6P_g" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_671" name="NADPH_g" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_672" name="NADP_g" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_673" name="_6PGL_g" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_674" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="Function for G6PDH_c" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(G6PDH_c_Vmax,G6PDH_c_Keq,Glc6P_c,G6PDH_c_KmGlc6P,NADP_c,G6PDH_c_KmNADP,_6PGL_c,G6PDH_c_Km6PGL,NADPH_c,G6PDH_c_KmNADPH)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_720" name="G6PDH_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_721" name="G6PDH_c_Km6PGL" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_722" name="G6PDH_c_KmGlc6P" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_723" name="G6PDH_c_KmNADP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_724" name="G6PDH_c_KmNADPH" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_725" name="G6PDH_c_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_726" name="Glc6P_c" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_727" name="NADPH_c" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_728" name="NADP_c" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_729" name="_6PGL_c" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_730" name="cytosol" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="Function for NADPHu_c" type="UserDefined" reversible="false">
      <Expression>
        mass_action_irrev(NADPHu_c_k,NADPH_c)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_742" name="NADPH_c" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_648" name="NADPHu_c_k" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_644" name="cytosol" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="Function for HXK_c" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(HXK_c_Vmax,HXK_c_Keq,Glc_c,HXK_c_KmGlc,ATP_c,HXK_c_KmATP,Glc6P_c,HXK_c_KmGlc6P,ADP_c,HXK_c_KmADP)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_646" name="ADP_c" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_650" name="ATP_c" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_771" name="Glc6P_c" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_772" name="Glc_c" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_773" name="HXK_c_Keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_774" name="HXK_c_KmADP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_775" name="HXK_c_KmATP" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_776" name="HXK_c_KmGlc" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_777" name="HXK_c_KmGlc6P" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_778" name="HXK_c_Vmax" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_779" name="cytosol" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_73" name="Function for NADPHu_g" type="UserDefined" reversible="false">
      <Expression>
        mass_action_irrev(NADPHu_g_k,NADPH_g)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_758" name="NADPH_g" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_756" name="NADPHu_g_k" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_752" name="glycosome" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_74" name="Function for G6PP_c" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(G6PP_c_Vmax,G6PP_c_Keq,Glc6P_c,G6PP_c_KmGlc6P,Glc_c,G6PP_c_KmGlc)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_796" name="G6PP_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_795" name="G6PP_c_KmGlc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_794" name="G6PP_c_KmGlc6P" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_793" name="G6PP_c_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_792" name="Glc6P_c" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_804" name="Glc_c" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_805" name="cytosol" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_75" name="Function for _6PGDH_g" type="UserDefined" reversible="unspecified">
      <Expression>
        v2sub2prod(_6PGDH_g_Vmax,_6PGDH_g_Keq,_6PG_g,_6PGDH_g_Km6PG,NADP_g,_6PGDH_g_KmNADP,Rul5P_g,_6PGDH_g_KmRul5P,NADPH_g,_6PGDH_g_KmNADPH)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_817" name="NADPH_g" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_818" name="NADP_g" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_819" name="Rul5P_g" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_820" name="_6PGDH_g_Keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_821" name="_6PGDH_g_Km6PG" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_822" name="_6PGDH_g_KmNADP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_823" name="_6PGDH_g_KmNADPH" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_824" name="_6PGDH_g_KmRul5P" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_825" name="_6PGDH_g_Vmax" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_826" name="_6PG_g" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_827" name="glycosome" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_76" name="Function for TOX_c" type="UserDefined" reversible="false">
      <Expression>
        mass_action_irrev(TOX_c_k,TSH2_c)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_754" name="TOX_c_k" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_815" name="TSH2_c" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_654" name="cytosol" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_77" name="Function for PGL_c" type="UserDefined" reversible="true">
      <Expression>
        (PGL_c_k*cytosol*(_6PGL_c-_6PG_c/PGL_c_Keq)+v1sub1prod(PGL_c_Vmax,PGL_c_Keq,_6PGL_c,PGL_c_Km6PGL,_6PG_c,PGL_c_Km6PG))/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_855" name="PGL_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_813" name="PGL_c_Km6PG" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_864" name="PGL_c_Km6PGL" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_865" name="PGL_c_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_866" name="PGL_c_k" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_867" name="_6PGL_c" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_868" name="_6PG_c" order="6" role="product"/>
        <ParameterDescription key="FunctionParameter_869" name="cytosol" order="7" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_78" name="Function for _6PGDH_c" type="UserDefined" reversible="unspecified">
      <Expression>
        v2sub2prod(_6PGDH_c_Vmax,_6PGDH_c_Keq,_6PG_c,_6PGDH_c_Km6PG,NADP_c,_6PGDH_c_KmNADP,Rul5P_c,_6PGDH_c_KmRul5P,NADPH_c,_6PGDH_c_KmNADPH)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_881" name="NADPH_c" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_882" name="NADP_c" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_883" name="Rul5P_c" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_884" name="_6PGDH_c_Keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_885" name="_6PGDH_c_Km6PG" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_886" name="_6PGDH_c_KmNADP" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_887" name="_6PGDH_c_KmNADPH" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_888" name="_6PGDH_c_KmRul5P" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_889" name="_6PGDH_c_Vmax" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_890" name="_6PG_c" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_891" name="cytosol" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_79" name="Function for PPI_c" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(PPI_c_Vmax,PPI_c_Keq,Rul5P_c,PPI_c_KmRul5P,Rib5P_c,PPI_c_KmRib5P)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_652" name="PPI_c_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_856" name="PPI_c_KmRib5P" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_858" name="PPI_c_KmRul5P" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_878" name="PPI_c_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_903" name="Rib5P_c" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_904" name="Rul5P_c" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_905" name="cytosol" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_80" name="Function for PPI_g" type="UserDefined" reversible="true">
      <Expression>
        v1sub1prod(PPI_g_Vmax,PPI_g_Keq,Rul5P_g,PPI_g_KmRul5P,Rib5P_g,PPI_g_KmRib5P)/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_913" name="PPI_g_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_914" name="PPI_g_KmRib5P" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_915" name="PPI_g_KmRul5P" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_916" name="PPI_g_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_917" name="Rib5P_g" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_918" name="Rul5P_g" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_919" name="glycosome" order="6" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_81" name="Function for PGL_g" type="UserDefined" reversible="true">
      <Expression>
        (glycosome*PGL_g_k*(_6PGL_g-_6PG_g/PGL_g_Keq)+v1sub1prod(PGL_g_Vmax,PGL_g_Keq,_6PGL_g,PGL_g_Km6PGL,_6PG_g,PGL_g_Km6PG))/glycosome
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_930" name="PGL_g_Keq" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_929" name="PGL_g_Km6PG" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_939" name="PGL_g_Km6PGL" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_940" name="PGL_g_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_941" name="PGL_g_k" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_942" name="_6PGL_g" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_943" name="_6PG_g" order="6" role="product"/>
        <ParameterDescription key="FunctionParameter_944" name="glycosome" order="7" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_82" name="Function for TR_c" type="UserDefined" reversible="true">
      <Expression>
        v2sub2prod(TR_c_Vmax,TR_c_Keq,TS2_c,TR_c_KmTS2,NADPH_c,TR_c_KmNADPH,TSH2_c,TR_c_KmTSH2,NADP_c,TR_c_KmNADP)/cytosol
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_956" name="NADPH_c" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_957" name="NADP_c" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_958" name="TR_c_Keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_959" name="TR_c_KmNADP" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_960" name="TR_c_KmNADPH" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_961" name="TR_c_KmTS2" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_962" name="TR_c_KmTSH2" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_963" name="TR_c_Vmax" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_964" name="TS2_c" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_965" name="TSH2_c" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_966" name="cytosol" order="10" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_1" name="GlycPPP_Kerkhoven13_modelB" simulationType="time" timeUnit="min" volumeUnit="µl" areaUnit="m²" lengthUnit="m" quantityUnit="nmol" type="deterministic" avogadroConstant="6.0221408570000002e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_1">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2021-11-15T12:23:18Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <ListOfCompartments>
      <Compartment key="Compartment_3" name="cytosol" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
      <Compartment key="Compartment_4" name="glycosome" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
      <Compartment key="Compartment_5" name="default" simulationType="fixed" dimensionality="3" addNoise="false">
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_31" name="_2PGA_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_32" name="DHAP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_33" name="ATP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_34" name="DHAP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_35" name="ADP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_36" name="Glc6P_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_37" name="ADP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_38" name="_3PGA_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_39" name="Fru6P_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_40" name="Pi_g" simulationType="fixed" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_41" name="O2_c" simulationType="fixed" compartment="Compartment_5" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_42" name="NADP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_43" name="ATP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_44" name="NADP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_45" name="_6PG_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_46" name="CO2_c" simulationType="fixed" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_47" name="Rul5P_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_48" name="_6PG_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_49" name="Rul5P_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_50" name="Glc6P_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_51" name="Rib5P_c" simulationType="fixed" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_52" name="_13BPGA_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_53" name="Glc_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_54" name="Rib5P_g" simulationType="fixed" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_55" name="Glc_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_56" name="Glc_e" simulationType="fixed" compartment="Compartment_5" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_57" name="NADPH_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_58" name="NADPH_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_59" name="Pyr_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_60" name="Pyr_e" simulationType="fixed" compartment="Compartment_5" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_61" name="NAD_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_62" name="Fru16BP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_63" name="GA3P_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_64" name="Gly_e" simulationType="fixed" compartment="Compartment_5" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_65" name="TSH2_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_66" name="CO2_g" simulationType="fixed" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_67" name="Gly3P_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_68" name="Gly3P_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_69" name="_6PGL_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_70" name="TS2_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_71" name="_6PGL_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_72" name="PEP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_73" name="AMP_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_74" name="_3PGA_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_75" name="AMP_c" simulationType="reactions" compartment="Compartment_3" addNoise="false">
      </Metabolite>
      <Metabolite key="Metabolite_76" name="NADH_g" simulationType="reactions" compartment="Compartment_4" addNoise="false">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfReactions>
      <Reaction key="Reaction_21" name="TPI_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3655" name="TPI_g_Vmax" value="999.3"/>
          <Constant key="Parameter_3657" name="TPI_g_Keq" value="0.046"/>
          <Constant key="Parameter_3654" name="TPI_g_KmDHAP" value="1.2"/>
          <Constant key="Parameter_3652" name="TPI_g_KmGA3P" value="0.25"/>
        </ListOfConstants>
        <KineticLaw function="Function_47" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_317">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="Parameter_3657"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="Parameter_3654"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="Parameter_3652"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_312">
              <SourceParameter reference="Parameter_3655"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_311">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="PYK_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_72" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3653" name="PYK_c_Vmax" value="1020"/>
          <Constant key="Parameter_3656" name="PYK_c_KmPEP" value="0.34"/>
          <Constant key="Parameter_3666" name="PYK_c_KiATP" value="0.57"/>
          <Constant key="Parameter_3669" name="PYK_c_KiADP" value="0.64"/>
          <Constant key="Parameter_3667" name="PYK_c_n" value="2.5"/>
          <Constant key="Parameter_3664" name="PYK_c_KmADP" value="0.114"/>
          <Constant key="Parameter_3665" name="PYK_c_Keq" value="10800"/>
          <Constant key="Parameter_3668" name="PYK_c_KmPyr" value="50"/>
          <Constant key="Parameter_3679" name="PYK_c_KmATP" value="15"/>
        </ListOfConstants>
        <KineticLaw function="Function_48" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_344">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_343">
              <SourceParameter reference="Metabolite_72"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_342">
              <SourceParameter reference="Parameter_3665"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_341">
              <SourceParameter reference="Parameter_3669"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_340">
              <SourceParameter reference="Parameter_3666"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="Parameter_3664"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="Parameter_3679"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="Parameter_3656"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_336">
              <SourceParameter reference="Parameter_3668"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_335">
              <SourceParameter reference="Parameter_3653"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_334">
              <SourceParameter reference="Parameter_3667"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="PFK_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_62" stoichiometry="1"/>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3681" name="PFK_g_Vmax" value="1708"/>
          <Constant key="Parameter_3678" name="PFK_g_Ki1" value="15.8"/>
          <Constant key="Parameter_3676" name="PFK_g_KmFru6P" value="0.999"/>
          <Constant key="Parameter_3677" name="PFK_g_KmATP" value="0.0648"/>
          <Constant key="Parameter_3680" name="PFK_g_Keq" value="1035"/>
          <Constant key="Parameter_3691" name="PFK_g_KsATP" value="0.0393"/>
          <Constant key="Parameter_3693" name="PFK_g_KmADP" value="1"/>
          <Constant key="Parameter_3690" name="PFK_g_Ki2" value="10.7"/>
        </ListOfConstants>
        <KineticLaw function="Function_49" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_368">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_367">
              <SourceParameter reference="Parameter_3680"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_366">
              <SourceParameter reference="Parameter_3678"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="Parameter_3690"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Parameter_3693"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_363">
              <SourceParameter reference="Parameter_3677"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_362">
              <SourceParameter reference="Parameter_3676"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_361">
              <SourceParameter reference="Parameter_3691"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_360">
              <SourceParameter reference="Parameter_3681"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_304">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="G6PDH_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_36" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_71" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3688" name="G6PDH_g_Vmax" value="8.4"/>
          <Constant key="Parameter_3689" name="G6PDH_g_Keq" value="5.02"/>
          <Constant key="Parameter_3692" name="G6PDH_g_KmGlc6P" value="0.058"/>
          <Constant key="Parameter_3703" name="G6PDH_g_KmNADP" value="0.0094"/>
          <Constant key="Parameter_3705" name="G6PDH_g_Km6PGL" value="0.04"/>
          <Constant key="Parameter_3702" name="G6PDH_g_KmNADPH" value="0.0001"/>
        </ListOfConstants>
        <KineticLaw function="Function_69" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_649">
              <SourceParameter reference="Parameter_3689"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_645">
              <SourceParameter reference="Parameter_3705"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_666">
              <SourceParameter reference="Parameter_3692"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_667">
              <SourceParameter reference="Parameter_3703"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_668">
              <SourceParameter reference="Parameter_3702"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_669">
              <SourceParameter reference="Parameter_3688"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_670">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_671">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_672">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_673">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_674">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="PGAM_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3700" name="PGAM_c_Vmax" value="225"/>
          <Constant key="Parameter_3701" name="PGAM_c_Keq" value="0.17"/>
          <Constant key="Parameter_3704" name="PGAM_c_Km3PGA" value="0.15"/>
          <Constant key="Parameter_3715" name="PGAM_c_Km2PGA" value="0.16"/>
        </ListOfConstants>
        <KineticLaw function="Function_50" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="Parameter_3701"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_388">
              <SourceParameter reference="Parameter_3715"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_387">
              <SourceParameter reference="Parameter_3704"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_386">
              <SourceParameter reference="Parameter_3700"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_306">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_310">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="PyrT_c" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_60" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3717" name="PyrT_c_Vmax" value="230"/>
          <Constant key="Parameter_3714" name="PyrT_c_KmPyr" value="1.96"/>
        </ListOfConstants>
        <KineticLaw function="Function_51" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_327">
              <SourceParameter reference="Parameter_3714"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="Parameter_3717"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="G6PDH_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_50" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_42" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_58" stoichiometry="1"/>
          <Product metabolite="Metabolite_69" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3712" name="G6PDH_c_Vmax" value="8.4"/>
          <Constant key="Parameter_3713" name="G6PDH_c_Keq" value="5.02"/>
          <Constant key="Parameter_3716" name="G6PDH_c_KmGlc6P" value="0.058"/>
          <Constant key="Parameter_3727" name="G6PDH_c_KmNADP" value="0.0094"/>
          <Constant key="Parameter_3729" name="G6PDH_c_Km6PGL" value="0.04"/>
          <Constant key="Parameter_3726" name="G6PDH_c_KmNADPH" value="0.0001"/>
        </ListOfConstants>
        <KineticLaw function="Function_70" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_720">
              <SourceParameter reference="Parameter_3713"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_721">
              <SourceParameter reference="Parameter_3729"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_722">
              <SourceParameter reference="Parameter_3716"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_723">
              <SourceParameter reference="Parameter_3727"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_724">
              <SourceParameter reference="Parameter_3726"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_725">
              <SourceParameter reference="Parameter_3712"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_726">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_727">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_728">
              <SourceParameter reference="Metabolite_42"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_729">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_730">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="ENO_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_72" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3724" name="ENO_c_Vmax" value="598"/>
          <Constant key="Parameter_3725" name="ENO_c_Keq" value="4.17"/>
          <Constant key="Parameter_3728" name="ENO_c_Km2PGA" value="0.054"/>
          <Constant key="Parameter_3739" name="ENO_c_KmPEP" value="0.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_54" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="Parameter_3725"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_417">
              <SourceParameter reference="Parameter_3728"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_413">
              <SourceParameter reference="Parameter_3739"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_420">
              <SourceParameter reference="Parameter_3724"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_419">
              <SourceParameter reference="Metabolite_72"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_411">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_418">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="HXK_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_36" stoichiometry="1"/>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3741" name="HXK_g_Vmax" value="1774.68"/>
          <Constant key="Parameter_3738" name="HXK_g_Keq" value="759"/>
          <Constant key="Parameter_3736" name="HXK_g_KmGlc" value="0.1"/>
          <Constant key="Parameter_3737" name="HXK_g_KmATP" value="0.116"/>
          <Constant key="Parameter_3740" name="HXK_g_KmGlc6P" value="2.7"/>
          <Constant key="Parameter_3751" name="HXK_g_KmADP" value="0.126"/>
        </ListOfConstants>
        <KineticLaw function="Function_55" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_473">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_472">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_471">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_470">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_469">
              <SourceParameter reference="Parameter_3738"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_468">
              <SourceParameter reference="Parameter_3751"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_467">
              <SourceParameter reference="Parameter_3737"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_466">
              <SourceParameter reference="Parameter_3736"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_465">
              <SourceParameter reference="Parameter_3740"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_464">
              <SourceParameter reference="Parameter_3741"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_463">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="_3PGAT_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_74" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3753" name="_3PGAT_g_k" value="250"/>
        </ListOfConstants>
        <KineticLaw function="Function_56" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_461">
              <SourceParameter reference="Parameter_3753"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_308">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_421">
              <SourceParameter reference="Metabolite_74"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="NADPHu_c" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_42" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3750" name="NADPHu_c_k" value="2"/>
        </ListOfConstants>
        <KineticLaw function="Function_71" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_742">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_648">
              <SourceParameter reference="Parameter_3750"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_644">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="HXK_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_53" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_50" stoichiometry="1"/>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3748" name="HXK_c_Vmax" value="154.32"/>
          <Constant key="Parameter_3749" name="HXK_c_Keq" value="759"/>
          <Constant key="Parameter_3752" name="HXK_c_KmGlc" value="0.1"/>
          <Constant key="Parameter_3763" name="HXK_c_KmATP" value="0.116"/>
          <Constant key="Parameter_3765" name="HXK_c_KmGlc6P" value="2.7"/>
          <Constant key="Parameter_3762" name="HXK_c_KmADP" value="0.126"/>
        </ListOfConstants>
        <KineticLaw function="Function_72" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_646">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_650">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_771">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_772">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_773">
              <SourceParameter reference="Parameter_3749"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_774">
              <SourceParameter reference="Parameter_3762"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_775">
              <SourceParameter reference="Parameter_3763"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_776">
              <SourceParameter reference="Parameter_3752"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_777">
              <SourceParameter reference="Parameter_3765"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_778">
              <SourceParameter reference="Parameter_3748"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_779">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_33" name="NADPHu_g" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3760" name="NADPHu_g_k" value="2"/>
        </ListOfConstants>
        <KineticLaw function="Function_73" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_758">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_756">
              <SourceParameter reference="Parameter_3760"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_752">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_34" name="AK_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_37" stoichiometry="2"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_75" stoichiometry="1"/>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3761" name="AK_c_k1" value="480"/>
          <Constant key="Parameter_3764" name="AK_c_k2" value="1000"/>
        </ListOfConstants>
        <KineticLaw function="Function_62" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_571">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_570">
              <SourceParameter reference="Parameter_3761"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_459">
              <SourceParameter reference="Parameter_3764"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_544">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_545">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_547">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_35" name="G6PP_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_50" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3775" name="G6PP_c_Vmax" value="28"/>
          <Constant key="Parameter_3777" name="G6PP_c_Keq" value="263"/>
          <Constant key="Parameter_3774" name="G6PP_c_KmGlc6P" value="5.6"/>
          <Constant key="Parameter_3772" name="G6PP_c_KmGlc" value="5.6"/>
        </ListOfConstants>
        <KineticLaw function="Function_74" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_796">
              <SourceParameter reference="Parameter_3777"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_795">
              <SourceParameter reference="Parameter_3772"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_794">
              <SourceParameter reference="Parameter_3774"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_793">
              <SourceParameter reference="Parameter_3775"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_792">
              <SourceParameter reference="Metabolite_50"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_804">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_805">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_36" name="_6PGDH_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_45" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_44" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
          <Product metabolite="Metabolite_66" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3773" name="_6PGDH_g_Vmax" value="10.6"/>
          <Constant key="Parameter_3776" name="_6PGDH_g_Keq" value="47"/>
          <Constant key="Parameter_3787" name="_6PGDH_g_Km6PG" value="0.0035"/>
          <Constant key="Parameter_3789" name="_6PGDH_g_KmNADP" value="0.001"/>
          <Constant key="Parameter_3786" name="_6PGDH_g_KmRul5P" value="0.03"/>
          <Constant key="Parameter_3784" name="_6PGDH_g_KmNADPH" value="0.0006"/>
        </ListOfConstants>
        <KineticLaw function="Function_75" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_817">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_818">
              <SourceParameter reference="Metabolite_44"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_819">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_820">
              <SourceParameter reference="Parameter_3776"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_821">
              <SourceParameter reference="Parameter_3787"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_822">
              <SourceParameter reference="Parameter_3789"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_823">
              <SourceParameter reference="Parameter_3784"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_824">
              <SourceParameter reference="Parameter_3786"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_825">
              <SourceParameter reference="Parameter_3773"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_826">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_827">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_37" name="PGI_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3785" name="PGI_g_Vmax" value="1305"/>
          <Constant key="Parameter_3788" name="PGI_g_KmGlc6P" value="0.4"/>
          <Constant key="Parameter_3799" name="PGI_g_Keq" value="0.457"/>
          <Constant key="Parameter_3801" name="PGI_g_KmFru6P" value="0.12"/>
          <Constant key="Parameter_3798" name="PGI_g_Ki6PG" value="0.14"/>
          <Constant key="Parameter_3796" name="_6PG_g" value="1.24275e+13"/>
        </ListOfConstants>
        <KineticLaw function="Function_63" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_589">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_588">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_587">
              <SourceParameter reference="Parameter_3799"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_586">
              <SourceParameter reference="Parameter_3798"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_585">
              <SourceParameter reference="Parameter_3801"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_584">
              <SourceParameter reference="Parameter_3788"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_583">
              <SourceParameter reference="Parameter_3785"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_582">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_581">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_38" name="AK_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="2"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_73" stoichiometry="1"/>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3797" name="AK_g_k1" value="480"/>
          <Constant key="Parameter_3800" name="AK_g_k2" value="1000"/>
        </ListOfConstants>
        <KineticLaw function="Function_65" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_623">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_549">
              <SourceParameter reference="Parameter_3797"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_578">
              <SourceParameter reference="Parameter_3800"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_489">
              <SourceParameter reference="Metabolite_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_546">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_579">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_39" name="TOX_c" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_65" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_70" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3811" name="TOX_c_k" value="2"/>
        </ListOfConstants>
        <KineticLaw function="Function_76" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_754">
              <SourceParameter reference="Parameter_3811"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_815">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_654">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_40" name="GDA_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_68" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_67" stoichiometry="1"/>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3813" name="GDA_g_k" value="600"/>
        </ListOfConstants>
        <KineticLaw function="Function_66" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_633">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_632">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_631">
              <SourceParameter reference="Parameter_3813"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_630">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_600">
              <SourceParameter reference="Metabolite_68"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_41" name="PGL_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_69" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_48" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3810" name="PGL_c_Vmax" value="28"/>
          <Constant key="Parameter_3808" name="PGL_c_Keq" value="20000"/>
          <Constant key="Parameter_3809" name="PGL_c_Km6PGL" value="0.05"/>
          <Constant key="Parameter_3812" name="PGL_c_Km6PG" value="0.05"/>
          <Constant key="Parameter_3823" name="PGL_c_k" value="0.055"/>
        </ListOfConstants>
        <KineticLaw function="Function_77" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_855">
              <SourceParameter reference="Parameter_3808"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_813">
              <SourceParameter reference="Parameter_3812"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_864">
              <SourceParameter reference="Parameter_3809"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_865">
              <SourceParameter reference="Parameter_3810"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_866">
              <SourceParameter reference="Parameter_3823"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_867">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_868">
              <SourceParameter reference="Metabolite_48"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_869">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_42" name="_6PGDH_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_42" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_48" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_46" stoichiometry="1"/>
          <Product metabolite="Metabolite_58" stoichiometry="1"/>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3825" name="_6PGDH_c_Vmax" value="10.6"/>
          <Constant key="Parameter_3822" name="_6PGDH_c_Keq" value="47"/>
          <Constant key="Parameter_3820" name="_6PGDH_c_Km6PG" value="0.0035"/>
          <Constant key="Parameter_3821" name="_6PGDH_c_KmNADP" value="0.001"/>
          <Constant key="Parameter_3824" name="_6PGDH_c_KmRul5P" value="0.03"/>
          <Constant key="Parameter_3835" name="_6PGDH_c_KmNADPH" value="0.0006"/>
        </ListOfConstants>
        <KineticLaw function="Function_78" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_881">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_882">
              <SourceParameter reference="Metabolite_42"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_883">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_884">
              <SourceParameter reference="Parameter_3822"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_885">
              <SourceParameter reference="Parameter_3820"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_886">
              <SourceParameter reference="Parameter_3821"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_887">
              <SourceParameter reference="Parameter_3835"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_888">
              <SourceParameter reference="Parameter_3824"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_889">
              <SourceParameter reference="Parameter_3825"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_890">
              <SourceParameter reference="Metabolite_48"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_891">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_43" name="PPI_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3837" name="PPI_c_Vmax" value="72"/>
          <Constant key="Parameter_3834" name="PPI_c_Keq" value="5.6"/>
          <Constant key="Parameter_3832" name="PPI_c_KmRul5P" value="1.4"/>
          <Constant key="Parameter_3833" name="PPI_c_KmRib5P" value="4"/>
        </ListOfConstants>
        <KineticLaw function="Function_79" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_652">
              <SourceParameter reference="Parameter_3834"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_856">
              <SourceParameter reference="Parameter_3833"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_858">
              <SourceParameter reference="Parameter_3832"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_878">
              <SourceParameter reference="Parameter_3837"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_903">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_904">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_905">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_44" name="PPI_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_54" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3836" name="PPI_g_Vmax" value="72"/>
          <Constant key="Parameter_3847" name="PPI_g_Keq" value="5.6"/>
          <Constant key="Parameter_3849" name="PPI_g_KmRul5P" value="1.4"/>
          <Constant key="Parameter_3846" name="PPI_g_KmRib5P" value="4"/>
        </ListOfConstants>
        <KineticLaw function="Function_80" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_913">
              <SourceParameter reference="Parameter_3847"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_914">
              <SourceParameter reference="Parameter_3846"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_915">
              <SourceParameter reference="Parameter_3849"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_916">
              <SourceParameter reference="Parameter_3836"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_917">
              <SourceParameter reference="Metabolite_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_918">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_919">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_45" name="GlcT_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3844" name="k1" value="250000"/>
          <Constant key="Parameter_3845" name="k2" value="250000"/>
        </ListOfConstants>
        <KineticLaw function="Function_14" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_69">
              <SourceParameter reference="Parameter_3844"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_68">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_78">
              <SourceParameter reference="Parameter_3845"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_79">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_46" name="GlcT_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_56" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3848" name="GlcT_c_Vmax" value="111.7"/>
          <Constant key="Parameter_3859" name="GlcT_c_KmGlc" value="1"/>
          <Constant key="Parameter_3861" name="GlcT_c_alpha" value="0.75"/>
        </ListOfConstants>
        <KineticLaw function="Function_52" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_405">
              <SourceParameter reference="Parameter_3859"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_404">
              <SourceParameter reference="Parameter_3848"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="Parameter_3861"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_401">
              <SourceParameter reference="Metabolite_56"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_47" name="PGL_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3858" name="PGL_g_Vmax" value="5"/>
          <Constant key="Parameter_3856" name="PGL_g_Keq" value="20000"/>
          <Constant key="Parameter_3857" name="PGL_g_Km6PGL" value="0.05"/>
          <Constant key="Parameter_3860" name="PGL_g_Km6PG" value="0.05"/>
          <Constant key="Parameter_3871" name="PGL_g_k" value="0.055"/>
        </ListOfConstants>
        <KineticLaw function="Function_81" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_930">
              <SourceParameter reference="Parameter_3856"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_929">
              <SourceParameter reference="Parameter_3860"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_939">
              <SourceParameter reference="Parameter_3857"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_940">
              <SourceParameter reference="Parameter_3858"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_941">
              <SourceParameter reference="Parameter_3871"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_942">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_943">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_944">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_48" name="TR_c" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_70" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_58" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_42" stoichiometry="1"/>
          <Product metabolite="Metabolite_65" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3873" name="TR_c_Vmax" value="252"/>
          <Constant key="Parameter_3870" name="TR_c_Keq" value="434"/>
          <Constant key="Parameter_3868" name="TR_c_KmTS2" value="0.0069"/>
          <Constant key="Parameter_3869" name="TR_c_KmNADPH" value="0.00077"/>
          <Constant key="Parameter_3872" name="TR_c_KmTSH2" value="0.0018"/>
          <Constant key="Parameter_3883" name="TR_c_KmNADP" value="0.081"/>
        </ListOfConstants>
        <KineticLaw function="Function_82" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_956">
              <SourceParameter reference="Metabolite_58"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_957">
              <SourceParameter reference="Metabolite_42"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_958">
              <SourceParameter reference="Parameter_3870"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_959">
              <SourceParameter reference="Parameter_3883"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_960">
              <SourceParameter reference="Parameter_3869"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_961">
              <SourceParameter reference="Parameter_3868"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_962">
              <SourceParameter reference="Parameter_3872"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_963">
              <SourceParameter reference="Parameter_3873"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_964">
              <SourceParameter reference="Metabolite_70"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_965">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_966">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_49" name="PGK_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_52" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_74" stoichiometry="1"/>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3885" name="PGK_g_Vmax" value="2862"/>
          <Constant key="Parameter_3882" name="PGK_g_Keq" value="3377"/>
          <Constant key="Parameter_3880" name="PGK_g_Km13BPGA" value="0.003"/>
          <Constant key="Parameter_3881" name="PGK_g_KmADP" value="0.1"/>
          <Constant key="Parameter_3884" name="PGK_g_Km3PGA" value="1.62"/>
          <Constant key="Parameter_3895" name="PGK_g_KmATP" value="0.29"/>
        </ListOfConstants>
        <KineticLaw function="Function_57" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_501">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_500">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_499">
              <SourceParameter reference="Parameter_3882"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_498">
              <SourceParameter reference="Parameter_3880"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_497">
              <SourceParameter reference="Parameter_3884"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_496">
              <SourceParameter reference="Parameter_3881"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_495">
              <SourceParameter reference="Parameter_3895"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_494">
              <SourceParameter reference="Parameter_3885"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_493">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_492">
              <SourceParameter reference="Metabolite_74"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_491">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_50" name="G3PDH_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_76" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_68" stoichiometry="1"/>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3897" name="G3PDH_g_Vmax" value="465"/>
          <Constant key="Parameter_3894" name="G3PDH_g_Keq" value="17085"/>
          <Constant key="Parameter_3892" name="G3PDH_g_KmDHAP" value="0.1"/>
          <Constant key="Parameter_3893" name="G3PDH_g_KmNADH" value="0.01"/>
          <Constant key="Parameter_3896" name="G3PDH_g_KmGly3P" value="2"/>
          <Constant key="Parameter_3907" name="G3PDH_g_KmNAD" value="0.4"/>
        </ListOfConstants>
        <KineticLaw function="Function_58" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_523">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_522">
              <SourceParameter reference="Parameter_3894"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_521">
              <SourceParameter reference="Parameter_3892"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_520">
              <SourceParameter reference="Parameter_3896"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_519">
              <SourceParameter reference="Parameter_3907"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_518">
              <SourceParameter reference="Parameter_3893"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_517">
              <SourceParameter reference="Parameter_3897"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_516">
              <SourceParameter reference="Metabolite_68"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_515">
              <SourceParameter reference="Metabolite_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_514">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_513">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_51" name="ATPu_c" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3909" name="ATPu_c_k" value="50"/>
        </ListOfConstants>
        <KineticLaw function="Function_60" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_539">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_538">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_537">
              <SourceParameter reference="Parameter_3909"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_536">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_52" name="GK_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_68" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_64" stoichiometry="1"/>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3906" name="GK_g_Vmax" value="200"/>
          <Constant key="Parameter_3904" name="GK_g_Keq" value="0.000837"/>
          <Constant key="Parameter_3905" name="GK_g_KmGly3P" value="3.83"/>
          <Constant key="Parameter_3908" name="GK_g_KmADP" value="0.56"/>
          <Constant key="Parameter_3919" name="GK_g_KmGly" value="0.44"/>
          <Constant key="Parameter_3921" name="GK_g_KmATP" value="0.24"/>
        </ListOfConstants>
        <KineticLaw function="Function_61" unitType="Default">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_559">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_558">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_557">
              <SourceParameter reference="Parameter_3904"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_556">
              <SourceParameter reference="Parameter_3908"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_555">
              <SourceParameter reference="Parameter_3921"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_554">
              <SourceParameter reference="Parameter_3919"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_553">
              <SourceParameter reference="Parameter_3905"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_552">
              <SourceParameter reference="Parameter_3906"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_551">
              <SourceParameter reference="Metabolite_68"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_550">
              <SourceParameter reference="Metabolite_64"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_53" name="ALD_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_62" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_63" stoichiometry="1"/>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3916" name="ALD_g_Vmax" value="560"/>
          <Constant key="Parameter_3917" name="ALD_g_KmFru16BP" value="0.009"/>
          <Constant key="Parameter_3918" name="ALD_g_KiATP" value="0.68"/>
          <Constant key="Parameter_3920" name="ALD_g_KiADP" value="1.51"/>
          <Constant key="Parameter_3931" name="ALD_g_KiAMP" value="3.65"/>
          <Constant key="Parameter_3933" name="ALD_g_Keq" value="0.084"/>
          <Constant key="Parameter_3930" name="ALD_g_KmGA3P" value="0.067"/>
          <Constant key="Parameter_3928" name="ALD_g_KmDHAP" value="0.015"/>
          <Constant key="Parameter_3929" name="ALD_g_KiGA3P" value="0.098"/>
        </ListOfConstants>
        <KineticLaw function="Function_53" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_437">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_436">
              <SourceParameter reference="Parameter_3933"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_435">
              <SourceParameter reference="Parameter_3920"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_434">
              <SourceParameter reference="Parameter_3931"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_433">
              <SourceParameter reference="Parameter_3918"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_432">
              <SourceParameter reference="Parameter_3929"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_431">
              <SourceParameter reference="Parameter_3928"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_430">
              <SourceParameter reference="Parameter_3917"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_429">
              <SourceParameter reference="Parameter_3930"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_428">
              <SourceParameter reference="Parameter_3916"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_427">
              <SourceParameter reference="Metabolite_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_425">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_424">
              <SourceParameter reference="Metabolite_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_423">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_422">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_54" name="GAPDH_g" reversible="true" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_63" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_61" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_76" stoichiometry="1"/>
          <Product metabolite="Metabolite_52" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3932" name="GAPDH_g_Vmax" value="720.9"/>
          <Constant key="Parameter_3943" name="GAPDH_g_Keq" value="0.066"/>
          <Constant key="Parameter_3945" name="GAPDH_g_KmGA3P" value="0.15"/>
          <Constant key="Parameter_3942" name="GAPDH_g_KmNAD" value="0.45"/>
          <Constant key="Parameter_3940" name="GAPDH_g_Km13BPGA" value="0.1"/>
          <Constant key="Parameter_3941" name="GAPDH_g_KmNADH" value="0.02"/>
        </ListOfConstants>
        <KineticLaw function="Function_64" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_611">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_610">
              <SourceParameter reference="Parameter_3943"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_609">
              <SourceParameter reference="Parameter_3940"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_608">
              <SourceParameter reference="Parameter_3945"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_607">
              <SourceParameter reference="Parameter_3942"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_606">
              <SourceParameter reference="Parameter_3941"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_605">
              <SourceParameter reference="Parameter_3932"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_604">
              <SourceParameter reference="Metabolite_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_603">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_602">
              <SourceParameter reference="Metabolite_52"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_601">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_55" name="GPO_c" reversible="false" fast="false" addNoise="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_32" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3944" name="GPO_c_Vmax" value="368"/>
          <Constant key="Parameter_3955" name="GPO_c_KmGly3P" value="1.7"/>
        </ListOfConstants>
        <KineticLaw function="Function_59" unitType="Default" scalingCompartment="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_416">
              <SourceParameter reference="Parameter_3955"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_488">
              <SourceParameter reference="Parameter_3944"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_485">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_490">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_1">
      <ModelParameterSet key="ModelParameterSet_1" name="Initial State">
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol]" value="5.4549000000000003" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome]" value="0.24510000000000001" type="Compartment" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default]" value="1" type="Compartment" simulationType="fixed"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_2PGA_c]" value="328501761608493" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[DHAP_c]" value="7329955466483286" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ATP_g]" value="35498442713419.336" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[DHAP_g]" value="1252132750316086.2" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ADP_g]" value="224208459383301.31" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc6P_g]" value="73801336202535" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ADP_c]" value="4324725691575810.5" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_3PGA_c]" value="328501761608493" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru6P_g]" value="73801336202535" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Pi_g]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[O2_c]" value="602214085700000" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADP_c]" value="328501761608493" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ATP_c]" value="1122490519416221" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADP_g]" value="14760267240507.006" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PG_g]" value="12427525085282.793" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[CO2_c]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rul5P_c]" value="1356120972272181.2" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PG_c]" value="276584686200363.56" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rul5P_g]" value="60933335222261" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc6P_c]" value="1642508808042465" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rib5P_c]" value="32850176160849.309" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_13BPGA_g]" value="73801336202535" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc_c]" value="328501761608493" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rib5P_g]" value="1476026724050.7" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc_g]" value="14760267240507.006" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Glc_e]" value="3011070428500000" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADPH_g]" value="575650422379773" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADPH_c]" value="12811568702731230" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Pyr_c]" value="32850176160849308" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Pyr_e]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NAD_g]" value="295205344810140" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru16BP_g]" value="1476026724050700" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[GA3P_g]" value="369006681012675" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Gly_e]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TSH2_c]" value="32850176160849.309" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[CO2_g]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Gly3P_c]" value="9095132613941366" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Gly3P_g]" value="1552318025823051.5" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PGL_c]" value="261250223968479.09" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TS2_c]" value="1215456517951424" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PGL_g]" value="11738515810495.926" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[PEP_c]" value="3285017616084930" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[AMP_g]" value="625909132333699.38" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_3PGA_g]" value="14760267240507.006" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[AMP_c]" value="7364352491739198" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADH_g]" value="295205344810140" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TPI_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TPI_g],ParameterGroup=Parameters,Parameter=TPI_g_Vmax" value="999.29999999999995" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TPI_g],ParameterGroup=Parameters,Parameter=TPI_g_Keq" value="0.045999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TPI_g],ParameterGroup=Parameters,Parameter=TPI_g_KmDHAP" value="1.2" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TPI_g],ParameterGroup=Parameters,Parameter=TPI_g_KmGA3P" value="0.25" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_Vmax" value="1020" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KmPEP" value="0.34000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KiATP" value="0.56999999999999995" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KiADP" value="0.64000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_n" value="2.5" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KmADP" value="0.114" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_Keq" value="10800" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KmPyr" value="50" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PYK_c],ParameterGroup=Parameters,Parameter=PYK_c_KmATP" value="15" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_Vmax" value="1708" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_Ki1" value="15.800000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_KmFru6P" value="0.999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_KmATP" value="0.064799999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_Keq" value="1035" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_KsATP" value="0.039300000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_KmADP" value="1" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PFK_g],ParameterGroup=Parameters,Parameter=PFK_g_Ki2" value="10.699999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_Vmax" value="8.4000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_Keq" value="5.0199999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_KmGlc6P" value="0.058000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_KmNADP" value="0.0094000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_Km6PGL" value="0.040000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_g],ParameterGroup=Parameters,Parameter=G6PDH_g_KmNADPH" value="0.0001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGAM_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGAM_c],ParameterGroup=Parameters,Parameter=PGAM_c_Vmax" value="225" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGAM_c],ParameterGroup=Parameters,Parameter=PGAM_c_Keq" value="0.17000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGAM_c],ParameterGroup=Parameters,Parameter=PGAM_c_Km3PGA" value="0.14999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGAM_c],ParameterGroup=Parameters,Parameter=PGAM_c_Km2PGA" value="0.16" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PyrT_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PyrT_c],ParameterGroup=Parameters,Parameter=PyrT_c_Vmax" value="230" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PyrT_c],ParameterGroup=Parameters,Parameter=PyrT_c_KmPyr" value="1.96" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_Vmax" value="8.4000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_Keq" value="5.0199999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_KmGlc6P" value="0.058000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_KmNADP" value="0.0094000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_Km6PGL" value="0.040000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PDH_c],ParameterGroup=Parameters,Parameter=G6PDH_c_KmNADPH" value="0.0001" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ENO_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ENO_c],ParameterGroup=Parameters,Parameter=ENO_c_Vmax" value="598" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ENO_c],ParameterGroup=Parameters,Parameter=ENO_c_Keq" value="4.1699999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ENO_c],ParameterGroup=Parameters,Parameter=ENO_c_Km2PGA" value="0.053999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ENO_c],ParameterGroup=Parameters,Parameter=ENO_c_KmPEP" value="0.23999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_Vmax" value="1774.6800000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_Keq" value="759" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_KmGlc" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_KmATP" value="0.11600000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_KmGlc6P" value="2.7000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_g],ParameterGroup=Parameters,Parameter=HXK_g_KmADP" value="0.126" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_3PGAT_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_3PGAT_g],ParameterGroup=Parameters,Parameter=_3PGAT_g_k" value="250" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[NADPHu_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[NADPHu_c],ParameterGroup=Parameters,Parameter=NADPHu_c_k" value="2" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_Vmax" value="154.31999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_Keq" value="759" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_KmGlc" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_KmATP" value="0.11600000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_KmGlc6P" value="2.7000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[HXK_c],ParameterGroup=Parameters,Parameter=HXK_c_KmADP" value="0.126" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[NADPHu_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[NADPHu_g],ParameterGroup=Parameters,Parameter=NADPHu_g_k" value="2" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_c],ParameterGroup=Parameters,Parameter=AK_c_k1" value="480" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_c],ParameterGroup=Parameters,Parameter=AK_c_k2" value="1000" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PP_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PP_c],ParameterGroup=Parameters,Parameter=G6PP_c_Vmax" value="28" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PP_c],ParameterGroup=Parameters,Parameter=G6PP_c_Keq" value="263" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PP_c],ParameterGroup=Parameters,Parameter=G6PP_c_KmGlc6P" value="5.5999999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G6PP_c],ParameterGroup=Parameters,Parameter=G6PP_c_KmGlc" value="5.5999999999999996" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_Vmax" value="10.6" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_Keq" value="47" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_Km6PG" value="0.0035000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_KmNADP" value="0.001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_KmRul5P" value="0.029999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_g],ParameterGroup=Parameters,Parameter=_6PGDH_g_KmNADPH" value="0.00059999999999999995" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=PGI_g_Vmax" value="1305" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=PGI_g_KmGlc6P" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=PGI_g_Keq" value="0.45700000000000002" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=PGI_g_KmFru6P" value="0.12" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=PGI_g_Ki6PG" value="0.14000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGI_g],ParameterGroup=Parameters,Parameter=_6PG_g" value="12427525085282.793" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PG_g],Reference=InitialParticleNumber>
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_g],ParameterGroup=Parameters,Parameter=AK_g_k1" value="480" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[AK_g],ParameterGroup=Parameters,Parameter=AK_g_k2" value="1000" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TOX_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TOX_c],ParameterGroup=Parameters,Parameter=TOX_c_k" value="2" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GDA_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GDA_g],ParameterGroup=Parameters,Parameter=GDA_g_k" value="600" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c],ParameterGroup=Parameters,Parameter=PGL_c_Vmax" value="28" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c],ParameterGroup=Parameters,Parameter=PGL_c_Keq" value="20000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c],ParameterGroup=Parameters,Parameter=PGL_c_Km6PGL" value="0.050000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c],ParameterGroup=Parameters,Parameter=PGL_c_Km6PG" value="0.050000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_c],ParameterGroup=Parameters,Parameter=PGL_c_k" value="0.055" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_Vmax" value="10.6" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_Keq" value="47" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_Km6PG" value="0.0035000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_KmNADP" value="0.001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_KmRul5P" value="0.029999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[_6PGDH_c],ParameterGroup=Parameters,Parameter=_6PGDH_c_KmNADPH" value="0.00059999999999999995" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_c],ParameterGroup=Parameters,Parameter=PPI_c_Vmax" value="72" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_c],ParameterGroup=Parameters,Parameter=PPI_c_Keq" value="5.5999999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_c],ParameterGroup=Parameters,Parameter=PPI_c_KmRul5P" value="1.3999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_c],ParameterGroup=Parameters,Parameter=PPI_c_KmRib5P" value="4" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_g],ParameterGroup=Parameters,Parameter=PPI_g_Vmax" value="72" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_g],ParameterGroup=Parameters,Parameter=PPI_g_Keq" value="5.5999999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_g],ParameterGroup=Parameters,Parameter=PPI_g_KmRul5P" value="1.3999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PPI_g],ParameterGroup=Parameters,Parameter=PPI_g_KmRib5P" value="4" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_g],ParameterGroup=Parameters,Parameter=k1" value="250000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_g],ParameterGroup=Parameters,Parameter=k2" value="250000" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_c],ParameterGroup=Parameters,Parameter=GlcT_c_Vmax" value="111.7" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_c],ParameterGroup=Parameters,Parameter=GlcT_c_KmGlc" value="1" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GlcT_c],ParameterGroup=Parameters,Parameter=GlcT_c_alpha" value="0.75" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g],ParameterGroup=Parameters,Parameter=PGL_g_Vmax" value="5" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g],ParameterGroup=Parameters,Parameter=PGL_g_Keq" value="20000" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g],ParameterGroup=Parameters,Parameter=PGL_g_Km6PGL" value="0.050000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g],ParameterGroup=Parameters,Parameter=PGL_g_Km6PG" value="0.050000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGL_g],ParameterGroup=Parameters,Parameter=PGL_g_k" value="0.055" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_Vmax" value="252" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_Keq" value="434" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_KmTS2" value="0.0068999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_KmNADPH" value="0.00076999999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_KmTSH2" value="0.0018" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[TR_c],ParameterGroup=Parameters,Parameter=TR_c_KmNADP" value="0.081000000000000003" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_Vmax" value="2862" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_Keq" value="3377" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_Km13BPGA" value="0.0030000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_KmADP" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_Km3PGA" value="1.6200000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[PGK_g],ParameterGroup=Parameters,Parameter=PGK_g_KmATP" value="0.28999999999999998" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_Vmax" value="465" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_Keq" value="17085" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_KmDHAP" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_KmNADH" value="0.01" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_KmGly3P" value="2" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[G3PDH_g],ParameterGroup=Parameters,Parameter=G3PDH_g_KmNAD" value="0.40000000000000002" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ATPu_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ATPu_c],ParameterGroup=Parameters,Parameter=ATPu_c_k" value="50" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_Vmax" value="200" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_Keq" value="0.00083699999999999996" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_KmGly3P" value="3.8300000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_KmADP" value="0.56000000000000005" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_KmGly" value="0.44" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GK_g],ParameterGroup=Parameters,Parameter=GK_g_KmATP" value="0.23999999999999999" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_Vmax" value="560" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KmFru16BP" value="0.0089999999999999993" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KiATP" value="0.68000000000000005" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KiADP" value="1.51" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KiAMP" value="3.6499999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_Keq" value="0.084000000000000005" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KmGA3P" value="0.067000000000000004" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KmDHAP" value="0.014999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[ALD_g],ParameterGroup=Parameters,Parameter=ALD_g_KiGA3P" value="0.098000000000000004" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_Vmax" value="720.89999999999998" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_Keq" value="0.066000000000000003" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_KmGA3P" value="0.14999999999999999" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_KmNAD" value="0.45000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_Km13BPGA" value="0.10000000000000001" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GAPDH_g],ParameterGroup=Parameters,Parameter=GAPDH_g_KmNADH" value="0.02" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GPO_c]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GPO_c],ParameterGroup=Parameters,Parameter=GPO_c_Vmax" value="368" type="ReactionParameter" simulationType="fixed"/>
            <ModelParameter cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Reactions[GPO_c],ParameterGroup=Parameters,Parameter=GPO_c_KmGly3P" value="1.7" type="ReactionParameter" simulationType="fixed"/>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_1"/>
      <StateTemplateVariable objectReference="Metabolite_35"/>
      <StateTemplateVariable objectReference="Metabolite_37"/>
      <StateTemplateVariable objectReference="Metabolite_42"/>
      <StateTemplateVariable objectReference="Metabolite_34"/>
      <StateTemplateVariable objectReference="Metabolite_53"/>
      <StateTemplateVariable objectReference="Metabolite_44"/>
      <StateTemplateVariable objectReference="Metabolite_63"/>
      <StateTemplateVariable objectReference="Metabolite_36"/>
      <StateTemplateVariable objectReference="Metabolite_38"/>
      <StateTemplateVariable objectReference="Metabolite_68"/>
      <StateTemplateVariable objectReference="Metabolite_59"/>
      <StateTemplateVariable objectReference="Metabolite_65"/>
      <StateTemplateVariable objectReference="Metabolite_69"/>
      <StateTemplateVariable objectReference="Metabolite_47"/>
      <StateTemplateVariable objectReference="Metabolite_45"/>
      <StateTemplateVariable objectReference="Metabolite_67"/>
      <StateTemplateVariable objectReference="Metabolite_39"/>
      <StateTemplateVariable objectReference="Metabolite_52"/>
      <StateTemplateVariable objectReference="Metabolite_31"/>
      <StateTemplateVariable objectReference="Metabolite_49"/>
      <StateTemplateVariable objectReference="Metabolite_50"/>
      <StateTemplateVariable objectReference="Metabolite_55"/>
      <StateTemplateVariable objectReference="Metabolite_61"/>
      <StateTemplateVariable objectReference="Metabolite_72"/>
      <StateTemplateVariable objectReference="Metabolite_71"/>
      <StateTemplateVariable objectReference="Metabolite_48"/>
      <StateTemplateVariable objectReference="Metabolite_74"/>
      <StateTemplateVariable objectReference="Metabolite_43"/>
      <StateTemplateVariable objectReference="Metabolite_62"/>
      <StateTemplateVariable objectReference="Metabolite_33"/>
      <StateTemplateVariable objectReference="Metabolite_76"/>
      <StateTemplateVariable objectReference="Metabolite_73"/>
      <StateTemplateVariable objectReference="Metabolite_70"/>
      <StateTemplateVariable objectReference="Metabolite_57"/>
      <StateTemplateVariable objectReference="Metabolite_75"/>
      <StateTemplateVariable objectReference="Metabolite_32"/>
      <StateTemplateVariable objectReference="Metabolite_58"/>
      <StateTemplateVariable objectReference="Metabolite_46"/>
      <StateTemplateVariable objectReference="Metabolite_51"/>
      <StateTemplateVariable objectReference="Metabolite_40"/>
      <StateTemplateVariable objectReference="Metabolite_54"/>
      <StateTemplateVariable objectReference="Metabolite_66"/>
      <StateTemplateVariable objectReference="Metabolite_41"/>
      <StateTemplateVariable objectReference="Metabolite_56"/>
      <StateTemplateVariable objectReference="Metabolite_60"/>
      <StateTemplateVariable objectReference="Metabolite_64"/>
      <StateTemplateVariable objectReference="Compartment_3"/>
      <StateTemplateVariable objectReference="Compartment_4"/>
      <StateTemplateVariable objectReference="Compartment_5"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 224208459383301.31 4324725691575810.5 328501761608493 1252132750316086.2 328501761608493 14760267240507.006 369006681012675 73801336202535 328501761608493 1552318025823051.5 32850176160849308 32850176160849.309 261250223968479.09 1356120972272181.2 12427525085282.793 9095132613941366 73801336202535 73801336202535 328501761608493 60933335222261 1642508808042465 14760267240507.006 295205344810140 3285017616084930 11738515810495.926 276584686200363.56 14760267240507.006 1122490519416221 1476026724050700 35498442713419.336 295205344810140 625909132333699.38 1215456517951424 575650422379773 7364352491739198 7329955466483286 12811568702731230 0 32850176160849.309 0 1476026724050.7 0 602214085700000 3011070428500000 0 0 5.4549000000000003 0.24510000000000001 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_26" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_17" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Derivation Factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Use Newton" type="bool" value="1"/>
        <Parameter name="Use Integration" type="bool" value="1"/>
        <Parameter name="Use Back Integration" type="bool" value="0"/>
        <Parameter name="Accept Negative Concentrations" type="bool" value="0"/>
        <Parameter name="Iteration Limit" type="unsignedInteger" value="50"/>
        <Parameter name="Maximum duration for forward integration" type="unsignedFloat" value="1000000000"/>
        <Parameter name="Maximum duration for backward integration" type="unsignedFloat" value="1000000"/>
      </Method>
    </Task>
    <Task key="Task_25" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.29999999999999999"/>
        <Parameter name="Duration" type="float" value="30"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_24" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_23" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_16" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_22" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_15" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
          
        </ParameterText>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
      </Problem>
      <Method name="Random Search" type="RandomSearch">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_21" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <ParameterGroup name="Experiment Set">
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Log Verbosity" type="unsignedInteger" value="0"/>
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
        <Parameter name="Stop after # Stalled Generations" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_20" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_26"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1.0000000000000001e-09"/>
        <Parameter name="Use Reder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_19" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_12" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_18" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_11" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="0.0001"/>
      </Method>
    </Task>
    <Task key="Task_17" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="SubtaskType" type="unsignedInteger" value="1"/>
        <ParameterGroup name="TargetFunctions">
          <Parameter name="SingleObject" type="cn" value=""/>
          <Parameter name="ObjectListType" type="unsignedInteger" value="7"/>
        </ParameterGroup>
        <ParameterGroup name="ListOfVariables">
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="41"/>
          </ParameterGroup>
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
      </Problem>
      <Method name="Sensitivities Method" type="SensitivitiesMethod">
        <Parameter name="Delta factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Delta minimum" type="unsignedFloat" value="9.9999999999999998e-13"/>
      </Method>
    </Task>
    <Task key="Task_16" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_15" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="AutomaticStepSize" type="bool" value="0"/>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Start in Steady State" type="bool" value="0"/>
        <Parameter name="LimitCrossings" type="bool" value="0"/>
        <Parameter name="NumCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitOutTime" type="bool" value="0"/>
        <Parameter name="LimitOutCrossings" type="bool" value="0"/>
        <Parameter name="PositiveDirection" type="bool" value="1"/>
        <Parameter name="NumOutCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitUntilConvergence" type="bool" value="0"/>
        <Parameter name="ConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <Parameter name="Threshold" type="float" value="0"/>
        <Parameter name="DelayOutputUntilConvergence" type="bool" value="0"/>
        <Parameter name="OutputConvergenceTolerance" type="float" value="9.9999999999999995e-07"/>
        <ParameterText name="TriggerExpression" type="expression">
          
        </ParameterText>
        <Parameter name="SingleVariable" type="cn" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="9.9999999999999995e-07"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="9.9999999999999998e-13"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
        <Parameter name="Max Internal Step Size" type="unsignedFloat" value="0"/>
      </Method>
    </Task>
    <Task key="Task_27" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value=""/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_17" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_16" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_15" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_14" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_13" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_12" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_11" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_10" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_9" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Result"/>
      </Footer>
    </Report>
  </ListOfReports>
  <ListOfPlots>
    <PlotSpecification name="concentration vs time" type="Plot2D" active="1" taskTypes="">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[ADP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ADP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[ADP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ADP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[AMP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[AMP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[AMP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[AMP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[ATP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ATP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[ATP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ATP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[CO2_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[CO2_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[CO2_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[CO2_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[DHAP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[DHAP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[DHAP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[DHAP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Fru16BP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru16BP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Fru6P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru6P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[GA3P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[GA3P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Glc6P_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc6P_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Glc6P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc6P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Glc_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Glc_e]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Glc_e],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Glc_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Gly3P_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Gly3P_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Gly3P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Gly3P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Gly_e]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Gly_e],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADH_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADH_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADPH_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADPH_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADPH_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADPH_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADP_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADP_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NAD_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NAD_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[O2_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[O2_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[PEP_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[PEP_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Pi_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Pi_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Pyr_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Pyr_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Pyr_e]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Pyr_e],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Rib5P_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rib5P_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Rib5P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rib5P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Rul5P_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rul5P_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Rul5P_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rul5P_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[TS2_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TS2_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[TSH2_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TSH2_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_13BPGA_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_13BPGA_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_2PGA_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_2PGA_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_3PGA_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_3PGA_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_3PGA_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_3PGA_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_6PGL_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PGL_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_6PGL_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PGL_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_6PG_c]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PG_c],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[_6PG_g]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PG_g],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="rates vs time" type="Plot2D" active="1" taskTypes="">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="ADP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ADP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="ADP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ADP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="AMP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[AMP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="AMP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[AMP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="ATP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[ATP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="ATP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[ATP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="CO2_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[CO2_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="CO2_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[CO2_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="DHAP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[DHAP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="DHAP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[DHAP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Fru16BP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru16BP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Fru6P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Fru6P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="GA3P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[GA3P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Glc6P_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc6P_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Glc6P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc6P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Glc_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Glc_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Glc_e.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Glc_e],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Glc_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Glc_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Gly3P_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Gly3P_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Gly3P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Gly3P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Gly_e.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Gly_e],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NADH_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADH_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NADPH_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADPH_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NADPH_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADPH_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NADP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[NADP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NADP_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NADP_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="NAD_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[NAD_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="O2_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[O2_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="PEP_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[PEP_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Pi_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Pi_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Pyr_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Pyr_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Pyr_e.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[default],Vector=Metabolites[Pyr_e],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Rib5P_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rib5P_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Rib5P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rib5P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Rul5P_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[Rul5P_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="Rul5P_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[Rul5P_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="TS2_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TS2_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="TSH2_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[TSH2_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_13BPGA_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_13BPGA_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_2PGA_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_2PGA_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_3PGA_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_3PGA_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_3PGA_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_3PGA_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_6PGL_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PGL_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_6PGL_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PGL_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_6PG_c.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[cytosol],Vector=Metabolites[_6PG_c],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="_6PG_g.Rate|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=GlycPPP_Kerkhoven13_modelB,Vector=Compartments[glycosome],Vector=Metabolites[_6PG_g],Reference=Rate"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <SBMLReference file="Kerkhoven2013_PPP_modelB_K19424">
    <SBMLMap SBMLid="ADP_c" COPASIkey="Metabolite_37"/>
    <SBMLMap SBMLid="ADP_g" COPASIkey="Metabolite_35"/>
    <SBMLMap SBMLid="AK_c" COPASIkey="Reaction_34"/>
    <SBMLMap SBMLid="AK_g" COPASIkey="Reaction_38"/>
    <SBMLMap SBMLid="ALD_g" COPASIkey="Reaction_53"/>
    <SBMLMap SBMLid="AMP_c" COPASIkey="Metabolite_75"/>
    <SBMLMap SBMLid="AMP_g" COPASIkey="Metabolite_73"/>
    <SBMLMap SBMLid="ATP_c" COPASIkey="Metabolite_43"/>
    <SBMLMap SBMLid="ATP_g" COPASIkey="Metabolite_33"/>
    <SBMLMap SBMLid="ATPu_c" COPASIkey="Reaction_51"/>
    <SBMLMap SBMLid="CO2_c" COPASIkey="Metabolite_46"/>
    <SBMLMap SBMLid="CO2_g" COPASIkey="Metabolite_66"/>
    <SBMLMap SBMLid="DHAP_c" COPASIkey="Metabolite_32"/>
    <SBMLMap SBMLid="DHAP_g" COPASIkey="Metabolite_34"/>
    <SBMLMap SBMLid="ENO_c" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="Fru16BP_g" COPASIkey="Metabolite_62"/>
    <SBMLMap SBMLid="Fru6P_g" COPASIkey="Metabolite_39"/>
    <SBMLMap SBMLid="G3PDH_g" COPASIkey="Reaction_50"/>
    <SBMLMap SBMLid="G6PDH_c" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="G6PDH_g" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="G6PP_c" COPASIkey="Reaction_35"/>
    <SBMLMap SBMLid="GA3P_g" COPASIkey="Metabolite_63"/>
    <SBMLMap SBMLid="GAPDH_g" COPASIkey="Reaction_54"/>
    <SBMLMap SBMLid="GDA_g" COPASIkey="Reaction_40"/>
    <SBMLMap SBMLid="GK_g" COPASIkey="Reaction_52"/>
    <SBMLMap SBMLid="GPO_c" COPASIkey="Reaction_55"/>
    <SBMLMap SBMLid="Glc6P_c" COPASIkey="Metabolite_50"/>
    <SBMLMap SBMLid="Glc6P_g" COPASIkey="Metabolite_36"/>
    <SBMLMap SBMLid="GlcT_c" COPASIkey="Reaction_46"/>
    <SBMLMap SBMLid="GlcT_g" COPASIkey="Reaction_45"/>
    <SBMLMap SBMLid="Glc_c" COPASIkey="Metabolite_53"/>
    <SBMLMap SBMLid="Glc_e" COPASIkey="Metabolite_56"/>
    <SBMLMap SBMLid="Glc_g" COPASIkey="Metabolite_55"/>
    <SBMLMap SBMLid="Gly3P_c" COPASIkey="Metabolite_67"/>
    <SBMLMap SBMLid="Gly3P_g" COPASIkey="Metabolite_68"/>
    <SBMLMap SBMLid="Gly_e" COPASIkey="Metabolite_64"/>
    <SBMLMap SBMLid="HXK_c" COPASIkey="Reaction_32"/>
    <SBMLMap SBMLid="HXK_g" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="NADH_g" COPASIkey="Metabolite_76"/>
    <SBMLMap SBMLid="NADPH_c" COPASIkey="Metabolite_58"/>
    <SBMLMap SBMLid="NADPH_g" COPASIkey="Metabolite_57"/>
    <SBMLMap SBMLid="NADPHu_c" COPASIkey="Reaction_31"/>
    <SBMLMap SBMLid="NADPHu_g" COPASIkey="Reaction_33"/>
    <SBMLMap SBMLid="NADP_c" COPASIkey="Metabolite_42"/>
    <SBMLMap SBMLid="NADP_g" COPASIkey="Metabolite_44"/>
    <SBMLMap SBMLid="NAD_g" COPASIkey="Metabolite_61"/>
    <SBMLMap SBMLid="O2_c" COPASIkey="Metabolite_41"/>
    <SBMLMap SBMLid="PEP_c" COPASIkey="Metabolite_72"/>
    <SBMLMap SBMLid="PFK_g" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="PGAM_c" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="PGI_g" COPASIkey="Reaction_37"/>
    <SBMLMap SBMLid="PGK_g" COPASIkey="Reaction_49"/>
    <SBMLMap SBMLid="PGL_c" COPASIkey="Reaction_41"/>
    <SBMLMap SBMLid="PGL_g" COPASIkey="Reaction_47"/>
    <SBMLMap SBMLid="PPI_c" COPASIkey="Reaction_43"/>
    <SBMLMap SBMLid="PPI_g" COPASIkey="Reaction_44"/>
    <SBMLMap SBMLid="PYK_c" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="Pi_g" COPASIkey="Metabolite_40"/>
    <SBMLMap SBMLid="PyrT_c" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="Pyr_c" COPASIkey="Metabolite_59"/>
    <SBMLMap SBMLid="Pyr_e" COPASIkey="Metabolite_60"/>
    <SBMLMap SBMLid="Rib5P_c" COPASIkey="Metabolite_51"/>
    <SBMLMap SBMLid="Rib5P_g" COPASIkey="Metabolite_54"/>
    <SBMLMap SBMLid="Rul5P_c" COPASIkey="Metabolite_47"/>
    <SBMLMap SBMLid="Rul5P_g" COPASIkey="Metabolite_49"/>
    <SBMLMap SBMLid="TOX_c" COPASIkey="Reaction_39"/>
    <SBMLMap SBMLid="TPI_g" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="TR_c" COPASIkey="Reaction_48"/>
    <SBMLMap SBMLid="TS2_c" COPASIkey="Metabolite_70"/>
    <SBMLMap SBMLid="TSH2_c" COPASIkey="Metabolite_65"/>
    <SBMLMap SBMLid="_13BPGA_g" COPASIkey="Metabolite_52"/>
    <SBMLMap SBMLid="_2PGA_c" COPASIkey="Metabolite_31"/>
    <SBMLMap SBMLid="_3PGAT_g" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="_3PGA_c" COPASIkey="Metabolite_38"/>
    <SBMLMap SBMLid="_3PGA_g" COPASIkey="Metabolite_74"/>
    <SBMLMap SBMLid="_6PGDH_c" COPASIkey="Reaction_42"/>
    <SBMLMap SBMLid="_6PGDH_g" COPASIkey="Reaction_36"/>
    <SBMLMap SBMLid="_6PGL_c" COPASIkey="Metabolite_69"/>
    <SBMLMap SBMLid="_6PGL_g" COPASIkey="Metabolite_71"/>
    <SBMLMap SBMLid="_6PG_c" COPASIkey="Metabolite_48"/>
    <SBMLMap SBMLid="_6PG_g" COPASIkey="Metabolite_45"/>
    <SBMLMap SBMLid="cytosol" COPASIkey="Compartment_3"/>
    <SBMLMap SBMLid="default" COPASIkey="Compartment_5"/>
    <SBMLMap SBMLid="glycosome" COPASIkey="Compartment_4"/>
    <SBMLMap SBMLid="mass_action_irrev" COPASIkey="Function_68"/>
  </SBMLReference>
  <ListOfUnitDefinitions>
    <UnitDefinition key="Unit_0" name="meter" symbol="m">
      <Expression>
        m
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_2" name="second" symbol="s">
      <Expression>
        s
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_6" name="Avogadro" symbol="Avogadro">
      <Expression>
        Avogadro
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_8" name="item" symbol="#">
      <Expression>
        #
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_17" name="liter" symbol="l">
      <Expression>
        0.001*m^3
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_20" name="mole" symbol="mol">
      <Expression>
        Avogadro*#
      </Expression>
    </UnitDefinition>
    <UnitDefinition key="Unit_32" name="minute" symbol="min">
      <Expression>
        60*s
      </Expression>
    </UnitDefinition>
  </ListOfUnitDefinitions>
</COPASI>
