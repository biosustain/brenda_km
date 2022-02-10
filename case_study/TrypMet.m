function dydt = TrypMet(t, y)
%Parameter values:
global PGAT3_g_k PGDH6_c_Vmax PGDH6_c_Keq PGDH6_c_Km6PG PGDH6_c_KmNADP PGDH6_c_KmRul5P PGDH6_c_KmNADPH PGDH6_g_Vmax PGDH6_g_Keq PGDH6_g_Km6PG PGDH6_g_KmNADP PGDH6_g_KmRul5P PGDH6_g_KmNADPH AK_c_k1 AK_c_k2 AK_g_k1 AK_g_k2
global ALD_g_Vmax ALD_g_Keq ALD_g_KmFru16BP ALD_g_KiATP ALD_g_KiADP ALD_g_KiAMP ALD_g_KmGA3P ALD_g_KmDHAP ALD_g_KiGA3P ATPu_c_k ENO_c_Vmax ENO_c_Keq ENO_c_Km2PGA ENO_c_KmPEP G3PDH_g_Vmax G3PDH_g_Keq G3PDH_g_KmDHAP G3PDH_g_KmNADH G3PDH_g_KmGly3P G3PDH_g_KmNAD
global G6PDH_c_Vmax G6PDH_c_Keq G6PDH_c_KmGlc6P G6PDH_c_KmNADP G6PDH_c_Km6PGL G6PDH_c_KmNADPH G6PDH_g_Vmax G6PDH_g_Keq G6PDH_g_KmGlc6P G6PDH_g_KmNADP G6PDH_g_Km6PGL G6PDH_g_KmNADPH G6PP_c_Vmax G6PP_c_Keq G6PP_c_KmGlc6P G6PP_c_KmGlc
global GAPDH_g_Vmax GAPDH_g_Keq GAPDH_g_KmGA3P GAPDH_g_KmNAD GAPDH_g_Km13BPGA GAPDH_g_KmNADH GDA_g_k GK_g_Vmax GK_g_Keq GK_g_KmGly3P GK_g_KmADP GK_g_KmGly GK_g_KmATP GlcT_c_Vmax GlcT_c_KmGlc GlcT_c_alpha k1 k2 GPO_c_Vmax GPO_c_KmGly3P
global HXK_c_Vmax HXK_c_Keq HXK_c_KmGlc HXK_c_KmATP HXK_c_KmGlc6P HXK_c_KmADP HXK_g_Vmax HXK_g_Keq HXK_g_KmGlc HXK_g_KmATP HXK_g_KmGlc6P HXK_g_KmADP NADPHu_c_k NADPHu_g_k PFK_g_Vmax PFK_g_Ki1 PFK_g_Keq PFK_g_KmFru6P PFK_g_KmATP PFK_g_KsATP PFK_g_KmADP PFK_g_Ki2
global PGAM_c_Vmax PGAM_c_Keq PGAM_c_Km3PGA PGAM_c_Km2PGA PGI_g_Vmax PGI_g_Keq PGI_g_KmGlc6P PGI_g_KmFru6P PGI_g_Ki6PG PGK_g_Vmax PGK_g_Keq PGK_g_Km13BPGA PGK_g_KmADP PGK_g_Km3PGA PGK_g_KmATP PGL_c_k PGL_c_Keq PGL_c_Vmax PGL_c_Km6PGL PGL_c_Km6PG
global PGL_g_k PGL_g_Keq PGL_g_Vmax PGL_g_Km6PGL PGL_g_Km6PG PPI_c_Vmax PPI_c_Keq PPI_c_KmRul5P PPI_c_KmRib5P PPI_g_Vmax PPI_g_Keq PPI_g_KmRul5P PPI_g_KmRib5P PYK_c_Vmax PYK_c_Keq PYK_c_KmPEP PYK_c_KiADP PYK_c_n PYK_c_KmADP PYK_c_KmPyr PYK_c_KmATP PyrT_c_Vmax PyrT_c_KmPyr
global TPI_g_Vmax TPI_g_Keq TPI_g_KmDHAP TPI_g_KmGA3P TR_c_Vmax TR_c_Keq TR_c_KmTS2 TR_c_KmNADPH TR_c_KmTSH2 TR_c_KmNADP PYK_c_KiATP TOX_c_k

k1=250000; k2=250000; NADPHu_c_k=2; NADPHu_g_k=2; TOX_c_k=2;
cytosol = 5.4549; glycosome = 0.2451;

% 2PGA_c = y(1)
% DHAP_c = y(2)
% ATP_g = y(3)
% DHAP_g = y(4)
% ADP_g = y(5)
% Glc6P_g = y(6)
% ADP_c = y(7)
% 3PGA_c = y(8)
% Fru6P_g = y(9)
% Pi_g = y(10)
% O2_c = y(11)
% NADP_c = y(12)
% ATP_c = y(13)
% NADP_g = y(14)
% 6PG_g = y(15)
% CO2_c = y(16)
% Rul5P_c = y(17)
% 6PG_c = y(18)
% Rul5P_g = y(19)
% Glc6P_c = y(20)
% Rib5P_c = y(21)
% 13BPGA_g = y(22)
% Glc_c = y(23)
% Rib5P_g = y(24)
% Glc_g = y(25)
% Glc_e = y(26)
% NADPH_g = y(27)
% NADPH_c = y(28)
% Pyr_c = y(29)
% Pyr_e = y(30)
% NAD_g = y(31)
% Fru16BP_g = y(32)
% GA3P_g = y(33)
% Gly_e = y(34)
% TSH2_c = y(35)
% CO2_g = y(36)
% Gly3P_c = y(37)
% Gly3P_g = y(38)
% 6PGL_c = y(39)
% TS2_c = y(40)
% 6PGL_g = y(41)
% PEP_c = y(42)
% AMP_g = y(43)
% 3PGA_g = y(44)
% AMP_c = y(45)
% NADH_g = y(46)


%Chemical Reactions and rate laws:

% 3PGA_g = 3PGA_c
r1 = PGAT3_g_k*y(44)-PGAT3_g_k*y(8);

% NADP_c + 6PG_c = CO2_c + NADPH_c + Rul5P_c
r2 = v2sub2prod(PGDH6_c_Vmax,PGDH6_c_Keq,y(18),PGDH6_c_Km6PG,y(12),PGDH6_c_KmNADP,y(17),PGDH6_c_KmRul5P,y(28),PGDH6_c_KmNADPH)/cytosol;

% 6PG_g + NADP_g = Rul5P_g + CO2_g + NADPH_g
r3 = v2sub2prod(PGDH6_g_Vmax,PGDH6_g_Keq,y(15),PGDH6_g_Km6PG,y(14),PGDH6_g_KmNADP,y(19),PGDH6_g_KmRul5P,y(27),PGDH6_g_KmNADPH)/glycosome;

% 2 * ADP_c = AMP_c + ATP_c
r4 = vAK(y(7),y(45),y(13),AK_c_k1,AK_c_k2)/cytosol;

% 2 * ADP_g = AMP_g + ATP_g
r5 = vAK(y(5),y(43),y(3),AK_g_k1,AK_g_k2)/glycosome;

% Fru16BP_g = GA3P_g + DHAP_g;  ATP_g ADP_g AMP_g
r6 = (ALD_g_Vmax*y(32)*(1-y(33)*y(4)/(y(32)*ALD_g_Keq))/(ALD_g_KmFru16BP*(1+y(3)/ALD_g_KiATP+y(5)/ALD_g_KiADP+y(43)/ALD_g_KiAMP)*(1+y(33)/ALD_g_KmGA3P+y(4)/ALD_g_KmDHAP+y(32)/(ALD_g_KmFru16BP*(1+y(3)/ALD_g_KiATP+y(5)/ALD_g_KiADP+y(43)/ALD_g_KiAMP))+y(33)*y(4)/(ALD_g_KmGA3P*ALD_g_KmDHAP)+y(32)*y(33)/(ALD_g_KmFru16BP*ALD_g_KiGA3P*(1+y(3)/ALD_g_KiATP+y(5)/ALD_g_KiADP+y(43)/ALD_g_KiAMP)))))/glycosome;

% ATP_c -> ADP_c
r7 = (ATPu_c_k*y(13)/y(7))/cytosol;

% 2PGA_c = PEP_c
r8 = v1sub1prod(ENO_c_Vmax,ENO_c_Keq,y(1),ENO_c_Km2PGA,y(42),ENO_c_KmPEP)/cytosol;

% NADH_g + DHAP_g = Gly3P_g + NAD_g
r9 = v2sub2prod(G3PDH_g_Vmax,G3PDH_g_Keq,y(4),G3PDH_g_KmDHAP,y(46),G3PDH_g_KmNADH,y(38),G3PDH_g_KmGly3P,y(31),G3PDH_g_KmNAD)/glycosome;

% Glc6P_c + NADP_c = NADPH_c + 6PGL_c
r10 = v2sub2prod(G6PDH_c_Vmax,G6PDH_c_Keq,y(20),G6PDH_c_KmGlc6P,y(12),G6PDH_c_KmNADP,y(39),G6PDH_c_Km6PGL,y(28),G6PDH_c_KmNADPH)/cytosol;

% Glc6P_g + NADP_g = 6PGL_g + NADPH_g
r11 = v2sub2prod(G6PDH_g_Vmax,G6PDH_g_Keq,y(6),G6PDH_g_KmGlc6P,y(14),G6PDH_g_KmNADP,y(41),G6PDH_g_Km6PGL,y(27),G6PDH_g_KmNADPH)/glycosome;

% Glc6P_c = Glc_c
r12 = v1sub1prod(G6PP_c_Vmax,G6PP_c_Keq,y(20),G6PP_c_KmGlc6P,y(23),G6PP_c_KmGlc)/cytosol;

% GA3P_g + NAD_g + Pi_g = NADH_g + 13BPGA_g
r13 = v2sub2prod(GAPDH_g_Vmax,GAPDH_g_Keq,y(33),GAPDH_g_KmGA3P,y(31),GAPDH_g_KmNAD,y(22),GAPDH_g_Km13BPGA,y(46),GAPDH_g_KmNADH)/glycosome;

% Gly3P_g + DHAP_c = Gly3P_c + DHAP_g
r14 = y(38)*GDA_g_k*y(2)-y(37)*GDA_g_k*y(4);

% Gly3P_g + ADP_g = Gly_e + ATP_g
r15 = GK_g_Vmax*y(38)*y(5)*(1-y(34)*y(3)/(GK_g_Keq*y(38)*y(5)))/(GK_g_KmGly3P*GK_g_KmADP*(1+y(38)/GK_g_KmGly3P+y(34)/GK_g_KmGly)*(1+y(5)/GK_g_KmADP+y(3)/GK_g_KmATP));

% Glc_e = Glc_c
r16 = GlcT_c_Vmax*(y(26)-y(23))/(GlcT_c_KmGlc+y(26)+y(23)+GlcT_c_alpha*y(26)*y(23)/GlcT_c_KmGlc);

% Glc_c = Glc_g
r17 = k1*y(23) - k2* y(25);

% Gly3P_c -> DHAP_c
r18 = v1sub(GPO_c_Vmax,y(37),GPO_c_KmGly3P)/cytosol;

% Glc_c + ATP_c = Glc6P_c + ADP_c
r19 = v2sub2prod(HXK_c_Vmax,HXK_c_Keq,y(23),HXK_c_KmGlc,y(13),HXK_c_KmATP,y(20),HXK_c_KmGlc6P,y(7),HXK_c_KmADP)/cytosol;

% ATP_g + Glc_g = Glc6P_g + ADP_g
r20 = v2sub2prod(HXK_g_Vmax,HXK_g_Keq,y(25),HXK_g_KmGlc,y(3),HXK_g_KmATP,y(6),HXK_g_KmGlc6P,y(5),HXK_g_KmADP)/glycosome;

% NADPH_c -> NADP_c
r21 = (NADPHu_c_k*y(28))/cytosol;

% NADPH_g -> NADP_g
r22 = (NADPHu_g_k*y(27))/glycosome;

% ATP_g + Fru6P_g = Fru16BP_g + ADP_g
r23 = (PFK_g_Vmax*PFK_g_Ki1*y(9)*y(3)*(1-y(32)*y(5)/(PFK_g_Keq*y(9)*y(3)))/(PFK_g_KmFru6P*PFK_g_KmATP*(y(32)+PFK_g_Ki1)*(PFK_g_KsATP/PFK_g_KmATP+y(9)/PFK_g_KmFru6P+y(3)/PFK_g_KmATP+y(5)/PFK_g_KmADP+y(32)*y(5)/(PFK_g_KmADP*PFK_g_Ki2)+y(9)*y(3)/(PFK_g_KmFru6P*PFK_g_KmATP))))/glycosome;

% 3PGA_c = 2PGA_c
r24 = v1sub1prod(PGAM_c_Vmax,PGAM_c_Keq,y(8),PGAM_c_Km3PGA,y(1),PGAM_c_Km2PGA)/cytosol;

% Glc6P_g = Fru6P_g;  6PG_g
r25 = (PGI_g_Vmax*y(6)*(1-y(9)/(PGI_g_Keq*y(6)))/(PGI_g_KmGlc6P*(1+y(6)/PGI_g_KmGlc6P+y(9)/PGI_g_KmFru6P+y(15)/PGI_g_Ki6PG)))/glycosome; 

% 13BPGA_g + ADP_g = 3PGA_g + ATP_g
r26 = v2sub2prod(PGK_g_Vmax,PGK_g_Keq,y(22),PGK_g_Km13BPGA,y(5),PGK_g_KmADP,y(44),PGK_g_Km3PGA,y(3),PGK_g_KmATP)/glycosome;

% 6PGL_c = 6PG_c
r27 = (PGL_c_k*cytosol*(y(39)-y(18)/PGL_c_Keq)+v1sub1prod(PGL_c_Vmax,PGL_c_Keq,y(39),PGL_c_Km6PGL,y(18),PGL_c_Km6PG))/cytosol;

% 6PGL_g = 6PG_g
r28 = (glycosome*PGL_g_k*(y(41)-y(15)/PGL_g_Keq)+v1sub1prod(PGL_g_Vmax,PGL_g_Keq,y(41),PGL_g_Km6PGL,y(15),PGL_g_Km6PG))/glycosome;

% Rul5P_c = Rib5P_c
r29 = v1sub1prod(PPI_c_Vmax,PPI_c_Keq,y(17),PPI_c_KmRul5P,y(21),PPI_c_KmRib5P)/cytosol;

% Rul5P_g = Rib5P_g
r30 = v1sub1prod(PPI_g_Vmax,PPI_g_Keq,y(19),PPI_g_KmRul5P,y(24),PPI_g_KmRib5P)/glycosome;

% PEP_c + ADP_c = Pyr_c + ATP_c
r31 = (PYK_c_Vmax*y(7)*(1-y(29)*y(13)/(PYK_c_Keq*y(42)*y(7)))*(y(42)/(PYK_c_KmPEP*(1+y(7)/PYK_c_KiADP+y(13)/PYK_c_KiATP))).^PYK_c_n/(PYK_c_KmADP*(1+(y(42)/(PYK_c_KmPEP*(1+y(7)/PYK_c_KiADP+y(13)/PYK_c_KiATP))).^PYK_c_n+y(29)/PYK_c_KmPyr)*(1+y(7)/PYK_c_KmADP+y(13)/PYK_c_KmATP)))/cytosol;

% Pyr_c -> Pyr_e
r32 = PyrT_c_Vmax*y(29)/(PyrT_c_KmPyr*(1+y(29)/PyrT_c_KmPyr));

% TSH2_c -> TS2_c
r33 = TOX_c_k*y(35)/cytosol;

% DHAP_g = GA3P_g
r34 = v1sub1prod(TPI_g_Vmax,TPI_g_Keq,y(4),TPI_g_KmDHAP,y(33),TPI_g_KmGA3P)/glycosome;

% TS2_c + NADPH_c = NADP_c + TSH2_c
r35 = v2sub2prod(TR_c_Vmax,TR_c_Keq,y(40),TR_c_KmTS2,y(28),TR_c_KmNADPH,y(35),TR_c_KmTSH2,y(12),TR_c_KmNADP)/cytosol;

% Differential equations:
dydt=[r24-r8;... %2PGA_c 
r18-r14;... % DHAP_c 
r5+r15-r20-r23+r26;... % ATP_g 
r6+r9-r14-r34;... % DHAP_g 
r20-r5-r26-r15+r23;... % ADP_g 
r20-r25-r11;... % Glc6P_g 
r7-r4+r19-r31;... % ADP_c
r1-r24;... % 3PGA_c
r25-r23;... % Fru6P_g 
0;... % Pi_g
0;... % O2_c
r35-r2-r10+r21;... % NADP_c
r4-r7-r19+r31;... % ATP_c
r22-r3-r11;... % NADP_g
r28-r3;... % 6PG_g
0;...  % CO2_c
r2-r29;... % Rul5P_c 
r27-r2;... % 6PG_c
r3-r30;... %Rul5P_g
r19-r10-r12;... %Glc6P_c
0;... %Rib5P_c
r13-r26;... %13BPGA_g
r12+r16-r17-r19;... %Glc_c
0;... %Rib5P_g
r20-r17;... %Glc_g
0;... %Glc_e
r3+r11-r22;... %NADPH_g
r2+r10-r21-r35;... %NADPH_c
r32-r31;... %Pyr_c
0;... %Pyr_e
r9-r13;... %NAD_g
r23-r6;... %Fru16BP_g
r6-r13+r34;... %GA3P_g
0;... %Gly_e
r35-r33;... %TSH2_c
0;... %CO2_g
r14-r18;... %Gly3P_c
r9-r14-r15;... %Gly3P_g
r10-r27;... %6PGL_c
r33-r35;... %TS2_c
r11-r28;... %6PGL_g
r8-r31;... %PEP_c
r5;... %AMP_g
r26-r1;... %3PGA_g
r4;... %AMP_c
r13-r9]; %NADH_g

% disp(dydt(10))
end


function [v2sub2prod] = v2sub2prod(Vfmax,Keq,S1,Ks1,S2,Ks2,P1,Kp1,P2,Kp2)

v2sub2prod = Vfmax*S1*S2*(1-P1*P2/(Keq*S1*S2))/(Ks1*Ks2*(1+S1/Ks1+P1/Kp1)*(1+S2/Ks2+P2/Kp2));

end


function [vAK] = vAK(ADP,AMP,ATP,k1,k2)

vAK = k1.*ADP.^2-AMP.*ATP.*k2;

end


function [v1sub1prod] = v1sub1prod(Vfmax,Keq,S, Ks, P, Kp)

v1sub1prod = Vfmax.*S.*(1-P./(Keq.*S))./(Ks.*(1+S./Ks+P./Kp));

end

function [v1sub] = v1sub(Vfmax,S, Ks)

v1sub = Vfmax.*S./(Ks.*(1+S./Ks));

end




% 44,43,42,39,38,34,32,29,25,23,20,18,9,8,6,4,1











