%Import parameter sets from publication
DatasetS2 = readtable('Dataset_S2.csv');
Priors = readtable('Pred_Priors.csv');

%Compare distributions plots
PGDH6_c_Km6PG=DatasetS2{:,'PGDH6_c_Km6PG'};
PGDH6_c_KmNADP=DatasetS2{:,'PGDH6_c_KmNADP'};
PGDH6_c_KmRul5P=DatasetS2{:,'PGDH6_c_KmRul5P'};
PGDH6_c_KmNADPH=DatasetS2{:,'PGDH6_c_KmNADPH'};
PGDH6_g_Km6PG=DatasetS2{:,'PGDH6_g_Km6PG'};
PGDH6_g_KmNADP=DatasetS2{:,'PGDH6_g_KmNADP'};
PGDH6_g_KmRul5P=DatasetS2{:,'PGDH6_g_KmRul5P'};
PGDH6_g_KmNADPH=DatasetS2{:,'PGDH6_g_KmNADPH'};
AK_c_k1=DatasetS2{:,'AK_c_k1'};
AK_c_k2=DatasetS2{:,'AK_c_k2'};
AK_g_k1=DatasetS2{:,'AK_g_k1'};
AK_g_k2=DatasetS2{:,'AK_g_k2'};
ALD_g_KmFru16BP=DatasetS2{:,'ALD_g_KmFru16BP'};
ALD_g_KmGA3P=DatasetS2{:,'ALD_g_KmGA3P'};
ALD_g_KmDHAP=DatasetS2{:,'ALD_g_KmDHAP'};
ENO_c_Km2PGA=DatasetS2{:,'ENO_c_Km2PGA'};
ENO_c_KmPEP=DatasetS2{:,'ENO_c_KmPEP'};
G3PDH_g_KmDHAP=DatasetS2{:,'G3PDH_g_KmDHAP'};
G3PDH_g_KmNADH=DatasetS2{:,'G3PDH_g_KmNADH'};
G3PDH_g_KmGly3P=DatasetS2{:,'G3PDH_g_KmGly3P'};
G3PDH_g_KmNAD=DatasetS2{:,'G3PDH_g_KmNAD'};
G6PDH_c_KmGlc6P=DatasetS2{:,'G6PDH_c_KmGlc6P'};
G6PDH_c_KmNADP=DatasetS2{:,'G6PDH_c_KmNADP'};
G6PDH_c_Km6PGL=DatasetS2{:,'G6PDH_c_Km6PGL'};
G6PDH_c_KmNADPH=DatasetS2{:,'G6PDH_c_KmNADPH'};
G6PDH_g_KmGlc6P=DatasetS2{:,'G6PDH_g_KmGlc6P'};
G6PDH_g_KmNADP=DatasetS2{:,'G6PDH_g_KmNADP'};
G6PDH_g_Km6PGL=DatasetS2{:,'G6PDH_g_Km6PGL'};
G6PDH_g_KmNADPH=DatasetS2{:,'G6PDH_g_KmNADPH'};
G6PP_c_KmGlc6P=DatasetS2{:,'G6PP_c_KmGlc6P'};
G6PP_c_KmGlc=DatasetS2{:,'G6PP_c_KmGlc'};
GAPDH_g_KmGA3P=DatasetS2{:,'GAPDH_g_KmGA3P'};
GAPDH_g_KmNAD=DatasetS2{:,'GAPDH_g_KmNAD'};
GAPDH_g_Km13BPGA=DatasetS2{:,'GAPDH_g_Km13BPGA'};
GAPDH_g_KmNADH=DatasetS2{:,'GAPDH_g_KmNADH'};
GK_g_KmGly3P=DatasetS2{:,'GK_g_KmGly3P'};
GK_g_KmADP=DatasetS2{:,'GK_g_KmADP'};
GK_g_KmGly=DatasetS2{:,'GK_g_KmGly'};
GK_g_KmATP=DatasetS2{:,'GK_g_KmATP'};
GPO_c_KmGly3P=DatasetS2{:,'GPO_c_KmGly3P'};
HXK_c_KmGlc=DatasetS2{:,'HXK_c_KmGlc'};
HXK_c_KmATP=DatasetS2{:,'HXK_c_KmATP'};
HXK_c_KmGlc6P=DatasetS2{:,'HXK_c_KmGlc6P'};
HXK_c_KmADP=DatasetS2{:,'HXK_c_KmADP'};
HXK_g_KmGlc=DatasetS2{:,'HXK_g_KmGlc'};
HXK_g_KmATP=DatasetS2{:,'HXK_g_KmATP'};
HXK_g_KmGlc6P=DatasetS2{:,'HXK_g_KmGlc6P'};
HXK_g_KmADP=DatasetS2{:,'HXK_g_KmADP'};
PFK_g_KmFru6P=DatasetS2{:,'PFK_g_KmFru6P'};
PFK_g_KmATP=DatasetS2{:,'PFK_g_KmATP'};
PFK_g_KmADP=DatasetS2{:,'PFK_g_KmADP'};
PGAM_c_Km3PGA=DatasetS2{:,'PGAM_c_Km3PGA'};
PGAM_c_Km2PGA=DatasetS2{:,'PGAM_c_Km2PGA'};
PGI_g_KmGlc6P=DatasetS2{:,'PGI_g_KmGlc6P'};
PGI_g_KmFru6P=DatasetS2{:,'PGI_g_KmFru6P'};
PGK_g_Km13BPGA=DatasetS2{:,'PGK_g_Km13BPGA'};
PGK_g_KmADP=DatasetS2{:,'PGK_g_KmADP'};
PGK_g_Km3PGA=DatasetS2{:,'PGK_g_Km3PGA'};
PGK_g_KmATP=DatasetS2{:,'PGK_g_KmATP'};
PGL_c_Km6PGL=DatasetS2{:,'PGL_c_Km6PGL'};
PGL_c_Km6PG=DatasetS2{:,'PGL_c_Km6PG'};
PGL_g_Km6PGL=DatasetS2{:,'PGL_g_Km6PGL'};
PGL_g_Km6PG=DatasetS2{:,'PGL_g_Km6PG'};
PPI_c_KmRul5P=DatasetS2{:,'PPI_c_KmRul5P'};
PPI_g_KmRul5P=DatasetS2{:,'PPI_g_KmRul5P'};
PPI_g_KmRib5P=DatasetS2{:,'PPI_g_KmRib5P'};
PYK_c_KmPEP=DatasetS2{:,'PYK_c_KmPEP'};
PYK_c_KmADP=DatasetS2{:,'PYK_c_KmADP'};
PYK_c_KmPyr=DatasetS2{:,'PYK_c_KmPyr'};
PYK_c_KmATP=DatasetS2{:,'PYK_c_KmATP'};
TPI_g_KmDHAP=DatasetS2{:,'TPI_g_KmDHAP'};
TPI_g_KmGA3P=DatasetS2{:,'TPI_g_KmGA3P'};
TR_c_KmTS2=DatasetS2{:,'TR_c_KmTS2'};
TR_c_KmNADPH=DatasetS2{:,'TR_c_KmNADPH'};
TR_c_KmTSH2=DatasetS2{:,'TR_c_KmTSH2'};
TR_c_KmNADP=DatasetS2{:,'TR_c_KmNADP'};
    
%%
pHat = lognfit(PGDH6_c_Km6PG);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{1,'mu'};
sigma2=Priors{1,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.002:0.00001:0.006;
x2 = 0.0001:0.00001:0.6;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.00013 0.00013], [0 200], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.035 0.035], [0 200], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0035 0.0035], [0 200], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0053 0.0053], [0 200], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0096 0.0096], [0 200], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGDH6-Km6PG values'), xlabel('PGDH6-Km6PG (mM)'),ylabel('Frequency');
PGDH6_c_Km6PG=random(pd2,1000,1);
PGDH6_g_Km6PG=random(pd2,1000,1);
%%
pHat = lognfit(PGDH6_c_KmNADP);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{2,'mu'};
sigma2=Priors{2,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0006:0.00001:0.0016;
x2 = 0.0005:0.000001:0.2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0046 0.0046], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0059 0.0059], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGDH6-KmNADP values'), xlabel('PGDH6-KmNADP (mM)'),ylabel('Frequency');
PGDH6_c_KmNADP=random(pd2,1000,1);
PGDH6_g_KmNADP=random(pd2,1000,1);
%%
pHat = lognfit(PGDH6_c_KmRul5P);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{3,'mu'};
sigma2=Priors{3,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.019:0.00001:0.05;
x2 = 0.000005:0.000001:1.7;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.00013 0.00013], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.035 0.035], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0035 0.0035], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0096 0.0096], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0046 0.0046], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0059 0.0059], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGDH6-KmRul5P values'), xlabel('PGDH6-KmRul5P (mM)'),ylabel('Frequency');
PGDH6_c_KmRul5P=random(pd2,1000,1);
PGDH6_g_KmRul5P=random(pd2,1000,1);
%%
pHat = lognfit(PGDH6_c_KmNADPH);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{4,'mu'};
sigma2=Priors{4,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0003:0.00001:0.0011;
x2 = 0.000002:0.000001:0.1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.00013 0.00013], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.035 0.035], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0035 0.0035], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0096 0.0096], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0046 0.0046], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.00077 0.00077], [0 1000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGDH6-KmNADPH values'), xlabel('PGDH6-KmNADPH (mM)'),ylabel('Frequency');
PGDH6_c_KmNADPH=random(pd2,1000,1);
PGDH6_g_KmNADPH=random(pd2,1000,1);
%% Look into
pHat = lognfit(AK_c_k1);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{5,'mu'};
sigma2=Priors{5,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.001:0.001:5000;
x2 = 0.001:0.0001:4.5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.00018 0.00018], [0 0.001], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.00017 0.00017], [0 0.001], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0032 0.0032], [0 0.001], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for AK-k1 values'), xlabel('AK-k1 (mM)'),ylabel('Frequency');
AK_c_k1=random(pd2,1000,1);
AK_g_k1=random(pd2,1000,1);
%% look into
pHat = lognfit(AK_c_k2);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{6,'mu'};
sigma2=Priors{6,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.001:0.001:5000;
x2 = 0.0005:0.00001:2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0032 0.0032], [0 0.0007], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for AK-k2 values'), xlabel('AK-k2 (mM)'),ylabel('Frequency');
AK_c_k2=random(pd2,1000,1);
AK_g_k2=random(pd2,1000,1);
%%
pHat = lognfit(ALD_g_KmFru16BP);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{7,'mu'};
sigma2=Priors{7,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.006:0.0001:0.013;
x2 = 0.0003:0.00001:0.7;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0092 0.0092], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0168 0.0168], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0728 0.0728], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0777 0.0777], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for ALD-KmFru16BP values'), xlabel('ALD-KmFru16BP (mM)'),ylabel('Frequency');
ALD_g_KmFru16BP=random(pd2,1000,1);
%% 
pHat = lognfit(ALD_g_KmGA3P);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{8,'mu'};
sigma2=Priors{8,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.04:0.0001:0.11;
x2 = 0.00003:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0092 0.0092], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0168 0.0168], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0728 0.0728], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0777 0.0777], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for ALD-KmGA3P values'), xlabel('ALD-KmGA3P (mM)'),ylabel('Frequency')
ALD_g_KmGA3P=random(pd2,1000,1);
%%
pHat = lognfit(ALD_g_KmDHAP);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{9,'mu'};
sigma2=Priors{9,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.009:0.0001:0.025;
x2 = 0.000001:0.0000001:0.5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0092 0.0092], [0 50], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0168 0.0168], [0 50], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0728 0.0728], [0 50], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0777 0.0777], [0 50], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for ALD-KmDHAP values'), xlabel('ALD-KmDHAP (mM)'),ylabel('Frequency')
ALD_g_KmDHAP=random(pd2,1000,1);
%%  
pHat = lognfit(ENO_c_Km2PGA);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{10,'mu'};
sigma2=Priors{10,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.03:0.0001:0.09;
x2 = 0.007:0.00001:2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.054 0.054], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.244 0.244], [0 10], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for ENO-Km2PGA values'), xlabel('ENO-Km2PGA (mM)'),ylabel('Frequency')    
ENO_c_Km2PGA=random(pd2,1000,1);
%% look into
pHat = lognfit(ENO_c_KmPEP);
mu=pHat(1);
sigma=pHat(2);
mu2=Priors{11,'mu'};
sigma2=Priors{11,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.12:0.0001:0.4;
x2 = 0.00001:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.054 0.054], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.244 0.244], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for ENO-KmPEP values'), xlabel('ENO-KmPEP (mM)'),ylabel('Frequency')
ENO_c_KmPEP=random(pd2,1000,1);
%% look into
pHat = lognfit(G3PDH_g_KmDHAP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{14,'mu'};
sigma2=Priors{14,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.06:0.0001:0.16;
x2 = 0.001:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.1 0.1], [0 7], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G3PDH-KmDHAP values'), xlabel('G3PDH-KmDHAP (mM)'),ylabel('Frequency')
G3PDH_g_KmDHAP=random(pd2,1000,1);
%% look into
pHat = lognfit(G3PDH_g_KmNADH);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{12,'mu'};
sigma2=Priors{12,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.006:0.0001:0.017;
x2 = 0.001:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.01 0.01], [0 70], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G3PDH-KmNADH values'), xlabel('G3PDH-KmNADH (mM)'),ylabel('Frequency')
G3PDH_g_KmNADH=random(pd2,1000,1);
%% to look into
pHat = lognfit(G3PDH_g_KmGly3P);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{15,'mu'};
sigma2=Priors{15,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 1.2:0.00001:3.2;
x2 = 0.000001:0.000001:3.5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([2.25 2.25], [0 0.4], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G3PDH-KmGly3P values'), xlabel('G3PDH-KmGly3P (mM)'),ylabel('Frequency')
G3PDH_g_KmGly3P=random(pd2,1000,1);
%% look into
pHat = lognfit(G3PDH_g_KmNAD);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{13,'mu'};
sigma2=Priors{13,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.2:0.0001:0.8;
x2 = 0.006:0.000001:1.3;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.32 0.32], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G3PDH-KmNAD values'), xlabel('G3PDH-KmNAD (mM)'),ylabel('Frequency')
G3PDH_g_KmNAD=random(pd2,1000,1);
%%
pHat = lognfit(G6PDH_c_KmGlc6P);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{18,'mu'};
sigma2=Priors{18,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.053:0.0001:0.064;
x2 = 0.006:0.000001:1.3;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0578 0.0578], [0 50], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.138 0.138], [0 50], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PDH-KmGlc6P values'), xlabel('G6PDH-KmGlc6P (mM)'),ylabel('Frequency')
G6PDH_c_KmGlc6P=random(pd2,1000,1);
G6PDH_g_KmGlc6P=random(pd2,1000,1);
%% look into
pHat = lognfit(G6PDH_c_Km6PGL);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{19,'mu'};
sigma2=Priors{19,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.025:0.0001:0.064;
x2 = 0.0000001:0.0000001:1.3;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.138 0.138], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0578 0.0578], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0053 0.0053], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0094 0.0094], [0 20], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PDH-Km6PGL values'), xlabel('G6PDH-Km6PGL (mM)'),ylabel('Frequency')
G6PDH_c_Km6PGL=random(pd2,1000,1);
G6PDH_g_Km6PGL=random(pd2,1000,1);
%% look into
pHat = lognfit(G6PDH_c_KmNADPH);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{17,'mu'};
sigma2=Priors{17,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.00006:0.000001:0.00016;
x2 = 0.000002:0.000001:0.08;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.138 0.138], [0 6000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0578 0.0578], [0 6000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0053 0.0053], [0 6000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0094 0.0094], [0 6000], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.0175 0.0175], [0 6000], 'Color',[0.47 0.67 0.19],'linestyle','--','LineWidth',1.5); %median of all Kms with same EC number and substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PDH-KmNADPH values'), xlabel('G6PDH-KmNADPH (mM)'),ylabel('Frequency')
G6PDH_c_KmNADPH=random(pd2,1000,1);
G6PDH_g_KmNADPH=random(pd2,1000,1);
%%
pHat = lognfit(G6PDH_c_KmNADP);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{16,'mu'};
sigma2=Priors{16,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0085:0.000001:0.0105;
x2 = 0.001:0.000001:0.08;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0053 0.0053], [0 300], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.0094 0.0094], [0 300], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PDH-KmNADP values'), xlabel('G6PDH-KmNADP (mM)'),ylabel('Frequency')
G6PDH_c_KmNADP=random(pd2,1000,1);
G6PDH_g_KmNADP=random(pd2,1000,1);
%% no data - look into
pHat = lognfit(G6PP_c_KmGlc6P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{21,'mu'};
sigma2=Priors{21,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 2:0.0001:10;
x2 = 0.0001:0.00001:10;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([8 8], [0 0.07], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PP-KmGlc6P values'), xlabel('G6PP-KmGlc6P (mM)'),ylabel('Frequency')
G6PP_c_KmGlc6P=random(pd2,1000,1);
%% no data
pHat = lognfit(G6PP_c_KmGlc);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{20,'mu'};
sigma2=Priors{20,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 2:0.0001:10;
x2 = 0.001:0.000001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0245 0.0245], [0 0.07], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for G6PP-KmGlc values'), xlabel('G6PP-KmGlc (mM)'),ylabel('Frequency')
G6PP_c_KmGlc=random(pd2,1000,1);
%% look into
pHat = lognfit(GAPDH_g_KmGA3P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{24,'mu'};
sigma2=Priors{24,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.08:0.0001:0.28;
x2 = 0.02:0.000001:0.7;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.17 0.17], [0 4], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.15 0.15], [0 4], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GAPDH-KmGA3P values'), xlabel('GAPDH-KmGA3P (mM)'),ylabel('Frequency')
GAPDH_g_KmGA3P=random(pd2,1000,1);
%%
pHat = lognfit(GAPDH_g_KmNAD);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{22,'mu'};
sigma2=Priors{22,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.23:0.00001:0.9;
x2 = 0.02:0.000001:1.5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.04 0.04], [0 1], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.674 0.674], [0 1], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.26 0.26], [0 1], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GAPDH-KmNAD values'), xlabel('GAPDH-KmNAD (mM)'),ylabel('Frequency')
GAPDH_g_KmNAD=random(pd2,1000,1);
%% look into
pHat = lognfit(GAPDH_g_Km13BPGA);
mu=pHat(1);
sigma=pHat(2); 	
mu2=Priors{25,'mu'};
sigma2=Priors{25,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.032:0.0001:0.3;
x2 = 0.00001:0.000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.14 0.14], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.1 0.1], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GAPDH-Km13BPGA values'), xlabel('GAPDH-Km13BPGA (mM)'),ylabel('Frequency')
GAPDH_g_Km13BPGA=random(pd2,1000,1);
%%
pHat = lognfit(GAPDH_g_KmNADH);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{23,'mu'};
sigma2=Priors{23,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.01:0.0001:0.04;
x2 = 0.0001:0.000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.02 0.02], [0 20], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.007 0.007], [0 20], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GAPDH-KmNADH values'), xlabel('GAPDH-KmNADH (mM)'),ylabel('Frequency')
GAPDH_g_KmNADH=random(pd2,1000,1);
%% look into
pHat = lognfit(GK_g_KmGly3P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{29,'mu'};
sigma2=Priors{29,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 2:0.0001:7;
x2 = 0.000001:0.0000001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([1.13 1.13], [0 0.1], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GK-KmGly3P values'), xlabel('GK-KmGly3P (mM)'),ylabel('Frequency')
GK_g_KmGly3P=random(pd2,1000,1);
%% look into
pHat = lognfit(GK_g_KmADP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{27,'mu'};
sigma2=Priors{27,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.52:0.0001:0.6;
x2 = 0.00001:0.00001:3;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.37 0.37], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.56 0.56], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.9 0.9], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GK-KmADP values'), xlabel('GK-KmADP (mM)'),ylabel('Frequency')
GK_g_KmADP=random(pd2,1000,1);
%%
pHat = lognfit(GK_g_KmGly);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{28,'mu'};
sigma2=Priors{28,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.27:0.00001:0.7;
x2 = 0.002:0.00001:10;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.169 0.169], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.26 0.26], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.44 0.44], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GK-KmGly values'), xlabel('GK-KmGly (mM)'),ylabel('Frequency')
GK_g_KmGly=random(pd2,1000,1);
%% Look into
pHat = lognfit(GK_g_KmATP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{26,'mu'};
sigma2=Priors{26,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.12:0.0001:0.45;
x2 = 0.0002:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.19 0.19], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.24 0.24], [0 2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GK-KmATP values'), xlabel('GK-KmATP (mM)'),ylabel('Frequency')
GK_g_KmATP=random(pd2,1000,1);
%% no data - look into
pHat = lognfit(GPO_c_KmGly3P);
mu=pHat(1);
sigma=pHat(2);		
mu2=Priors{31,'mu'};
sigma2=Priors{31,'sigma'};
% mu2=-2.0327;
% sigma2=2.1789;
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 1.5:0.00001:2;
x2 = 0.00001:0.000001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([5.11 5.11], [0 2], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for GPO-KmGly3P values'), xlabel('GPO-KmGly3P (mM)'),ylabel('Frequency')
GPO_c_KmGly3P=random(pd2,1000,1);
%%
pHat = lognfit(HXK_c_KmGlc);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{34,'mu'};
sigma2=Priors{34,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.06:0.000001:0.16;
x2 = 0.0001:0.00001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.009 0.009], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.04 0.04], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for HXK-KmGlc values'), xlabel('HXK-KmGlc (mM)'),ylabel('Frequency')
HXK_c_KmGlc=random(pd2,1000,1);
HXK_g_KmGlc=random(pd2,1000,1);
%%
pHat = lognfit(HXK_c_KmATP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{32,'mu'};
sigma2=Priors{32,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.07:0.0001:0.18;
x2 = 0.012:0.00001:0.8;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.03 0.03], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.3 0.3], [0 5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for HXK-KmATP values'), xlabel('HXK-KmATP (mM)'),ylabel('Frequency')
HXK_c_KmATP=random(pd2,1000,1);
HXK_g_KmATP=random(pd2,1000,1);
%%
pHat = lognfit(HXK_c_KmGlc6P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{35,'mu'};
sigma2=Priors{35,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 5.5:0.0001:23;
x2 = 0.0001:0.00001:23;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.1 0.1], [0 0.03], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
line([0.009 0.009], [0 0.03], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %value from other substrate but same organism+EC number
line([0.03 0.03], [0 0.03], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for HXK-KmGlc6P values'), xlabel('HXK-KmGlc6P (mM)'),ylabel('Frequency')
HXK_c_KmGlc6P=random(pd2,1000,1);
HXK_g_KmGlc6P=random(pd2,1000,1);
%%
pHat = lognfit(HXK_c_KmADP);
mu=pHat(1);
sigma=pHat(2);		
mu2=Priors{27,'mu'};
sigma2=Priors{27,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.07:0.0001:0.2;
x2 = 0.00001:0.00001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.009 0.009], [0 5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %value from other substrate but same organism+EC number
line([0.03 0.03], [0 5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for HXK-KmADP values'), xlabel('HXK-KmADP (mM)'),ylabel('Frequency')
HXK_c_KmADP=random(pd2,1000,1);
HXK_g_KmADP=random(pd2,1000,1);
%% look into
pHat = lognfit(PFK_g_KmFru6P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{38,'mu'};
sigma2=Priors{38,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.7:0.00001:1.4;
x2 = 0.0001:0.00001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.3 0.3], [0 0.5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
line([0.013 0.013], [0 0.5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); % same organism and EC, different substrate
line([0.023 0.023], [0 0.5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.026 0.026], [0 0.5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PFK-KmFru6P values'), xlabel('PFK-KmFru6P (mM)'),ylabel('Frequency')
PFK_g_KmFru6P=random(pd2,1000,1);
%%
pHat = lognfit(PFK_g_KmATP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{36,'mu'};
sigma2=Priors{36,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.04:0.0001:0.11;
x2 = 0.007:0.00001:0.4;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.013 0.013], [0 8], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.023 0.023], [0 8], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.026 0.026], [0 8], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PFK-KmATP values'), xlabel('PFK-KmATP (mM)'),ylabel('Frequency')
PFK_g_KmATP=random(pd2,1000,1);
%%
pHat = lognfit(PFK_g_KmADP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{33,'mu'};
sigma2=Priors{33,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.004:0.0001:12;
x2 = 0.00001:0.00001:12;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.013 0.013], [0 0.15], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); % same organism and EC, different substrate
line([0.023 0.023], [0 0.15], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
line([0.026 0.026], [0 0.15], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PFK-KmADP values'), xlabel('PFK-KmADP (mM)'),ylabel('Frequency')
PFK_g_KmADP=random(pd2,1000,1);
%%
pHat = lognfit(PGAM_c_Km3PGA);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{39,'mu'};
sigma2=Priors{39,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.12:0.000001:0.19;
x2 = 0.00001:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGAM-Km3PGA values'), xlabel('PGAM-Km3PGA (mM)'),ylabel('Frequency')
PGAM_c_Km3PGA=random(pd2,1000,1);
%% look into
pHat = lognfit(PGAM_c_Km2PGA);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{40,'mu'};
sigma2=Priors{40,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.1:0.0001:0.24;
x2 = 0.00001:0.00001:5;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.53 0.53], [0 5], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %median of all Kms with this EC number + substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGAM-Km2PGA values'), xlabel('PGAM-Km2PGA (mM)'),ylabel('Frequency')
PGAM_c_Km2PGA=random(pd2,1000,1);
%%
pHat = lognfit(PGI_g_KmGlc6P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{41,'mu'};
sigma2=Priors{41,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.25:0.00001:0.65;
x2 = 0.0000001:0.0000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.122 0.122], [0 2], 'Color',[1.00 0.41 0.16],'linestyle','--','LineWidth',1.5); %same organism and EC number but different substrate
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGI-KmGlc6P values'), xlabel('PGI-KmGlc6P (mM)'),ylabel('Frequency')
PGI_g_KmGlc6P=random(pd2,1000,1);
%% look into
pHat = lognfit(PGI_g_KmFru6P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{42,'mu'};
sigma2=Priors{42,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.09:0.0001:0.17;
x2 = 0.00001:0.000001:10;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.122 0.122], [0 7], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGI-KmFru6P values'), xlabel('PGI-KmFru6P (mM)'),ylabel('Frequency')
PGI_g_KmFru6P=random(pd2,1000,1);
%%
pHat = lognfit(PGK_g_Km13BPGA);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{46,'mu'};
sigma2=Priors{46,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.00001:0.000001:0.08;
x2 = 0.00001:0.000001:0.2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGK-Km13BPGA values'), xlabel('PGK-Km13BPGA (mM)'),ylabel('Frequency')
PGK_g_Km13BPGA=random(pd2,1000,1);
%%
pHat = lognfit(PGK_g_KmADP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{44,'mu'};
sigma2=Priors{44,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0004:0.000001:1.5;
x2 = 0.0004:0.000001:4;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGK-KmADP values'), xlabel('PGK-KmADP (mM)'),ylabel('Frequency')
PGK_g_KmADP=random(pd2,1000,1);
%% look into
pHat = lognfit(PGK_g_Km3PGA);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{45,'mu'};
sigma2=Priors{45,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.45:0.000001:5.1;
x2 = 0.01:0.000001:4;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([1.25 1.25], [0 0.2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5); 
line([2 2], [0 0.2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5); 
line([2.4 2.4], [0 0.2], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5); 
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGK-Km3PGA values'), xlabel('PGK-Km3PGA (mM)'),ylabel('Frequency')
PGK_g_Km3PGA=random(pd2,1000,1);
%%
pHat = lognfit(PGK_g_KmATP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{43,'mu'};
sigma2=Priors{43,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.095:0.00001:0.8;
x2 = 0.04:0.00001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.12 0.12], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.46 0.46], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.33 0.33], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGK-KmATP values'), xlabel('PGK-KmATP (mM)'),ylabel('Frequency')
PGK_g_KmATP=random(pd2,1000,1);
%%
pHat = lognfit(PGL_c_Km6PGL);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{47,'mu'};
sigma2=Priors{47,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.03:0.00001:0.08;
x2 = 0.0000001:0.0000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGL-Km6PGL values'), xlabel('PGL-Km6PGL (mM)'),ylabel('Frequency')
PGL_c_Km6PGL=random(pd2,1000,1);
PGL_g_Km6PGL=random(pd2,1000,1);
%%
pHat = lognfit(PGL_c_Km6PG);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{48,'mu'};
sigma2=Priors{48,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0002:0.00001:0.5;
x2 = 0.000001:0.000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PGL-Km6PG values'), xlabel('PGL-Km6PG (mM)'),ylabel('Frequency')
PGL_c_Km6PG=random(pd2,1000,1);
PGL_g_Km6PG=random(pd2,1000,1);
%%
pHat = lognfit(PPI_g_KmRul5P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{50,'mu'};
sigma2=Priors{50,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.8:0.00001:2.3;
x2 = 0.00001:0.000001:10;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PPI-KmRul5P values'), xlabel('PPI-KmRul5P (mM)'),ylabel('Frequency')
PPI_g_KmRul5P=random(pd2,1000,1);
PPI_c_KmRul5P=random(pd2,1000,1);
%%
pHat = lognfit(PPI_g_KmRib5P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{49,'mu'};
sigma2=Priors{49,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 2.5:0.00001:6.5;
x2 = 0.0000001:0.0000001:10;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PPI-KmRib5P values'), xlabel('PPI-KmRib5P (mM)'),ylabel('Frequency')
PPI_g_KmRib5P=random(pd2,1000,1);
%% look into
pHat = lognfit(PYK_c_KmPEP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{53,'mu'};
sigma2=Priors{53,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.2:0.00001:0.55;
x2 = 0.001:0.00001:2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.49 0.49], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([1.88 1.88], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.39 0.39], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PYK-KmPEP values'), xlabel('PYK-KmPEP (mM)'),ylabel('Frequency')
PYK_c_KmPEP=random(pd2,1000,1);
%%
pHat = lognfit(PYK_c_KmADP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{52,'mu'};
sigma2=Priors{52,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.075:0.000001:0.17;
x2 = 0.003:0.00001:8;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.082 0.082], [0 7], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PYK-KmADP values'), xlabel('PYK-KmADP (mM)'),ylabel('Frequency')
PYK_c_KmADP=random(pd2,1000,1);
%%
pHat = lognfit(PYK_c_KmPyr);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{54,'mu'};
sigma2=Priors{54,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 8:0.001:200;
x2 = 0.0001:0.00001:50;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PYK-KmPyr values'), xlabel('PYK-KmPyr (mM)'),ylabel('Frequency')
PYK_c_KmPyr=random(pd2,1000,1);
%%
pHat = lognfit(PYK_c_KmATP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{51,'mu'};
sigma2=Priors{51,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 11:0.0001:21;
x2 = 0.00005:0.00001:20;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for PYK-KmATP values'), xlabel('PYK-KmATP (mM)'),ylabel('Frequency')
PYK_c_KmATP=random(pd2,1000,1);
%%
pHat = lognfit(TPI_g_KmDHAP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{56,'mu'};
sigma2=Priors{56,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.95:0.001:1.5;
x2 = 0.003:0.00001:20;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.077 0.077], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.7 0.7], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.5 0.5], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.9 0.9], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([1.4 1.4], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([7.6 7.6], [0 1.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TPI-KmDHAP values'), xlabel('TPI-KmDHAP (mM)'),ylabel('Frequency')
TPI_g_KmDHAP=random(pd2,1000,1);
%% look into
pHat = lognfit(TPI_g_KmGA3P);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{55,'mu'};
sigma2=Priors{55,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.15:0.001:0.4;
x2 = 0.0000001:0.0000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.091 0.091], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.14 0.14], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.18 0.18], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.25 0.25], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.31 0.31], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.38 0.38], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.44 0.44], [0 2.5], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TPI-KmGA3P values'), xlabel('TPI-KmGA3P (mM)'),ylabel('Frequency')
TPI_g_KmGA3P=random(pd2,1000,1);
%%
pHat = lognfit(TR_c_KmTS2);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{59,'mu'};
sigma2=Priors{59,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0045:0.0001:0.011;
x2 = 0.001:0.0000001:0.2;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.0069 0.0069], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
line([0.058 0.058], [0 100], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TR-KmTS2 values'), xlabel('TR-KmTS2 (mM)'),ylabel('Frequency')
TR_c_KmTS2=random(pd2,1000,1);
%%
pHat = lognfit(TR_c_KmNADPH);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{58,'mu'};
sigma2=Priors{58,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.00073:0.000001:0.00082;
x2 = 0.0001:0.0000001:0.02;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
line([0.00077 0.00077], [0 10000], 'Color',[0.72 0.27 1.00],'linestyle','--','LineWidth',1.5);
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TR-KmNADPH values'), xlabel('TR-KmNADPH (mM)'),ylabel('Frequency')
TR_c_KmNADPH=random(pd2,1000,1);
%%
pHat = lognfit(TR_c_KmTSH2);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{60,'mu'};
sigma2=Priors{60,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.000004:0.000001:0.04;
x2 = 0.000001:0.0000001:0.9;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TR-KmTSH2 values'), xlabel('TR-KmTSH2 (mM)'),ylabel('Frequency')
TR_c_KmTSH2=random(pd2,1000,1);
%%
pHat = lognfit(TR_c_KmNADP);
mu=pHat(1);
sigma=pHat(2);	
mu2=Priors{57,'mu'};
sigma2=Priors{57,'sigma'};
pd=makedist('Lognormal',mu,sigma);
pd2=makedist('Lognormal',mu2,sigma2);
x = 0.0002:0.000001:0.9;
x2 = 0.00001:0.0000001:1;
figure()
yyaxis left
plot(x,pdf(pd,x),'Color',[0.6350 0.0780 0.1840],'LineWidth',2)
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,pdf(pd2,x2),'Color',[0 0.4470 0.7410],'linestyle','--','LineWidth',2)
set(gca, 'XScale', 'log')
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Probability Distribution for TR-KmNADP values'), xlabel('TR-KmNADP (mM)'),ylabel('Frequency')
TR_c_KmNADP=random(pd2,1000,1);
%% Create new dataset
DatasetN=DatasetS2;
DatasetN{:,'PGDH6_c_Km6PG'}=PGDH6_c_Km6PG;
DatasetN{:,'PGDH6_c_KmNADP'}=PGDH6_c_KmNADP;
DatasetN{:,'PGDH6_c_KmRul5P'}=PGDH6_c_KmRul5P;
DatasetN{:,'PGDH6_c_KmNADPH'}=PGDH6_c_KmNADPH;
DatasetN{:,'PGDH6_g_Km6PG'}=PGDH6_g_Km6PG;
DatasetN{:,'PGDH6_g_KmNADP'}=PGDH6_g_KmNADP;
DatasetN{:,'PGDH6_g_KmRul5P'}=PGDH6_g_KmRul5P;
DatasetN{:,'PGDH6_g_KmNADPH'}=PGDH6_g_KmNADPH;
DatasetN{:,'AK_c_k1'}=AK_c_k1;
DatasetN{:,'AK_c_k2'}=AK_c_k2;
DatasetN{:,'AK_g_k1'}=AK_g_k1;
DatasetN{:,'AK_g_k2'}=AK_g_k2;
DatasetN{:,'ALD_g_KmFru16BP'}=ALD_g_KmFru16BP;
DatasetN{:,'ALD_g_KmGA3P'}=ALD_g_KmGA3P;
DatasetN{:,'ALD_g_KmDHAP'}=ALD_g_KmDHAP;
DatasetN{:,'ENO_c_Km2PGA'}=ENO_c_Km2PGA;
DatasetN{:,'ENO_c_KmPEP'}=ENO_c_KmPEP;
DatasetN{:,'G3PDH_g_KmDHAP'}=G3PDH_g_KmDHAP;
DatasetN{:,'G3PDH_g_KmNADH'}=G3PDH_g_KmNADH;
DatasetN{:,'G3PDH_g_KmGly3P'}=G3PDH_g_KmGly3P;
DatasetN{:,'G3PDH_g_KmNAD'}=G3PDH_g_KmNAD;
DatasetN{:,'G6PDH_c_KmGlc6P'}=G6PDH_c_KmGlc6P;
DatasetN{:,'G6PDH_c_KmNADP'}=G6PDH_c_KmNADP;
DatasetN{:,'G6PDH_c_Km6PGL'}=G6PDH_c_Km6PGL;
DatasetN{:,'G6PDH_c_KmNADPH'}=G6PDH_c_KmNADPH;
DatasetN{:,'G6PDH_g_KmGlc6P'}=G6PDH_g_KmGlc6P;
DatasetN{:,'G6PDH_g_KmNADP'}=G6PDH_g_KmNADP;
DatasetN{:,'G6PDH_g_Km6PGL'}=G6PDH_g_Km6PGL;
DatasetN{:,'G6PDH_g_KmNADPH'}=G6PDH_g_KmNADPH;
DatasetN{:,'G6PP_c_KmGlc6P'}=G6PP_c_KmGlc6P;
DatasetN{:,'G6PP_c_KmGlc'}=G6PP_c_KmGlc;
DatasetN{:,'GAPDH_g_KmGA3P'}=GAPDH_g_KmGA3P;
DatasetN{:,'GAPDH_g_KmNAD'}=GAPDH_g_KmNAD;
DatasetN{:,'GAPDH_g_Km13BPGA'}=GAPDH_g_Km13BPGA;
DatasetN{:,'GAPDH_g_KmNADH'}=GAPDH_g_KmNADH;
DatasetN{:,'GK_g_KmGly3P'}=GK_g_KmGly3P;
DatasetN{:,'GK_g_KmADP'}=GK_g_KmADP;
DatasetN{:,'GK_g_KmGly'}=GK_g_KmGly;
DatasetN{:,'GK_g_KmATP'}=GK_g_KmATP;
DatasetN{:,'GPO_c_KmGly3P'}=GPO_c_KmGly3P;
DatasetN{:,'HXK_c_KmGlc'}=HXK_c_KmGlc;
DatasetN{:,'HXK_c_KmATP'}=HXK_c_KmATP;
DatasetN{:,'HXK_c_KmGlc6P'}=HXK_c_KmGlc6P;
DatasetN{:,'HXK_c_KmADP'}=HXK_c_KmADP;
DatasetN{:,'HXK_g_KmGlc'}=HXK_g_KmGlc;
DatasetN{:,'HXK_g_KmATP'}=HXK_g_KmATP;
DatasetN{:,'HXK_g_KmGlc6P'}=HXK_g_KmGlc6P;
DatasetN{:,'HXK_g_KmADP'}=HXK_g_KmADP;
DatasetN{:,'PFK_g_KmFru6P'}=PFK_g_KmFru6P;
DatasetN{:,'PFK_g_KmATP'}=PFK_g_KmATP;
DatasetN{:,'PFK_g_KmADP'}=PFK_g_KmADP;
DatasetN{:,'PGAM_c_Km3PGA'}=PGAM_c_Km3PGA;
DatasetN{:,'PGAM_c_Km2PGA'}=PGAM_c_Km2PGA;
DatasetN{:,'PGI_g_KmGlc6P'}=PGI_g_KmGlc6P;
DatasetN{:,'PGI_g_KmFru6P'}=PGI_g_KmFru6P;
DatasetN{:,'PGK_g_Km13BPGA'}=PGK_g_Km13BPGA;
DatasetN{:,'PGK_g_KmADP'}=PGK_g_KmADP;
DatasetN{:,'PGK_g_Km3PGA'}=PGK_g_Km3PGA;
DatasetN{:,'PGK_g_KmATP'}=PGK_g_KmATP;
DatasetN{:,'PGL_c_Km6PGL'}=PGL_c_Km6PGL;
DatasetN{:,'PGL_c_Km6PG'}=PGL_c_Km6PG;
DatasetN{:,'PGL_g_Km6PGL'}=PGL_g_Km6PGL;
DatasetN{:,'PGL_g_Km6PG'}=PGL_g_Km6PG;
DatasetN{:,'PPI_c_KmRul5P'}=PPI_c_KmRul5P;
DatasetN{:,'PPI_g_KmRul5P'}=PPI_g_KmRul5P;
DatasetN{:,'PPI_g_KmRib5P'}=PPI_g_KmRib5P;
DatasetN{:,'PYK_c_KmPEP'}=PYK_c_KmPEP;
DatasetN{:,'PYK_c_KmADP'}=PYK_c_KmADP;
DatasetN{:,'PYK_c_KmPyr'}=PYK_c_KmPyr;
DatasetN{:,'PYK_c_KmATP'}=PYK_c_KmATP;
DatasetN{:,'TPI_g_KmDHAP'}=TPI_g_KmDHAP;
DatasetN{:,'TPI_g_KmGA3P'}=TPI_g_KmGA3P;
DatasetN{:,'TR_c_KmTS2'}=TR_c_KmTS2;
DatasetN{:,'TR_c_KmNADPH'}=TR_c_KmNADPH;
DatasetN{:,'TR_c_KmTSH2'}=TR_c_KmTSH2;
DatasetN{:,'TR_c_KmNADP'}=TR_c_KmNADP;

%save dataset in csv file
%writetable(DatasetN,'DatasetN.csv','Delimiter',',','QuoteStrings',true)

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = num2str(get(FigHandle, 'Number'));
  set(0, 'CurrentFigure', FigHandle);
  saveas(FigHandle, fullfile('Parameter_plots', strcat(FigName, '.png')));
end
