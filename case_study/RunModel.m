tic;
DatasetS2 = readtable('Dataset_S2.csv');
DatasetN = readtable('DatasetN.csv');

global PGAT3_g_k PGDH6_c_Vmax PGDH6_c_Keq PGDH6_c_Km6PG PGDH6_c_KmNADP PGDH6_c_KmRul5P PGDH6_c_KmNADPH PGDH6_g_Vmax PGDH6_g_Keq PGDH6_g_Km6PG PGDH6_g_KmNADP PGDH6_g_KmRul5P PGDH6_g_KmNADPH AK_c_k1 AK_c_k2 AK_g_k1 AK_g_k2
global ALD_g_Vmax ALD_g_Keq ALD_g_KmFru16BP ALD_g_KiATP ALD_g_KiADP ALD_g_KiAMP ALD_g_KmGA3P ALD_g_KmDHAP ALD_g_KiGA3P ATPu_c_k ENO_c_Vmax ENO_c_Keq ENO_c_Km2PGA ENO_c_KmPEP G3PDH_g_Vmax G3PDH_g_Keq G3PDH_g_KmDHAP G3PDH_g_KmNADH G3PDH_g_KmGly3P G3PDH_g_KmNAD
global G6PDH_c_Vmax G6PDH_c_Keq G6PDH_c_KmGlc6P G6PDH_c_KmNADP G6PDH_c_Km6PGL G6PDH_c_KmNADPH G6PDH_g_Vmax G6PDH_g_Keq G6PDH_g_KmGlc6P G6PDH_g_KmNADP G6PDH_g_Km6PGL G6PDH_g_KmNADPH G6PP_c_Vmax G6PP_c_Keq G6PP_c_KmGlc6P G6PP_c_KmGlc
global GAPDH_g_Vmax GAPDH_g_Keq GAPDH_g_KmGA3P GAPDH_g_KmNAD GAPDH_g_Km13BPGA GAPDH_g_KmNADH GDA_g_k GK_g_Vmax GK_g_Keq GK_g_KmGly3P GK_g_KmADP GK_g_KmGly GK_g_KmATP GlcT_c_Vmax GlcT_c_KmGlc GlcT_c_alpha GPO_c_Vmax GPO_c_KmGly3P
global HXK_c_Vmax HXK_c_Keq HXK_c_KmGlc HXK_c_KmATP HXK_c_KmGlc6P HXK_c_KmADP HXK_g_Vmax HXK_g_Keq HXK_g_KmGlc HXK_g_KmATP HXK_g_KmGlc6P HXK_g_KmADP PFK_g_Vmax PFK_g_Ki1 PFK_g_Keq PFK_g_KmFru6P PFK_g_KmATP PFK_g_KsATP PFK_g_KmADP PFK_g_Ki2
global PGAM_c_Vmax PGAM_c_Keq PGAM_c_Km3PGA PGAM_c_Km2PGA PGI_g_Vmax PGI_g_Keq PGI_g_KmGlc6P PGI_g_KmFru6P PGI_g_Ki6PG PGK_g_Vmax PGK_g_Keq PGK_g_Km13BPGA PGK_g_KmADP PGK_g_Km3PGA PGK_g_KmATP PGL_c_k PGL_c_Keq PGL_c_Vmax PGL_c_Km6PGL PGL_c_Km6PG
global PGL_g_k PGL_g_Keq PGL_g_Vmax PGL_g_Km6PGL PGL_g_Km6PG PPI_c_Vmax PPI_c_Keq PPI_c_KmRul5P PPI_c_KmRib5P PPI_g_Vmax PPI_g_Keq PPI_g_KmRul5P PPI_g_KmRib5P PYK_c_Vmax PYK_c_Keq PYK_c_KmPEP PYK_c_KiADP PYK_c_n PYK_c_KmADP PYK_c_KmPyr PYK_c_KmATP PyrT_c_Vmax PyrT_c_KmPyr
global TPI_g_Vmax TPI_g_Keq TPI_g_KmDHAP TPI_g_KmGA3P TR_c_Vmax TR_c_Keq TR_c_KmTS2 TR_c_KmNADPH TR_c_KmTSH2 TR_c_KmNADP PYK_c_KiATP 

time=120;
tspan=0:0.1:time;
y0=[0.1 2.23 0.2405 8.483 1.519 0.5 1.3165 0.1 0.5 0 1 0.1 0.3417 0.1 0.084 0 0.413 0.0842 0.413 0.5 0.01 0.5 0.1 0.01 0.1 5 3.9 3.9 10 0 2 10 2.5 0 0.01 0 2.769 10.52 0.0795 0.37 0.0795 1 4.241 0.1 2.242 2];

options = odeset('RelTol',1e-9,'AbsTol',1e-16,'NormControl','on');
iter = 1000;

failed = cell(iter, 3);
normal =  cell(iter, 3);

countFailed = 0;
countNormal = 0;

for i=1:iter
    PGAT3_g_k=DatasetS2{i,'PGAT3_g_k'};
    PGDH6_c_Vmax= DatasetS2{i,'PGDH6_c_Vmax'};
    PGDH6_c_Keq=DatasetS2{i,'PGDH6_c_Keq'};
    PGDH6_c_Km6PG=DatasetS2{i,'PGDH6_c_Km6PG'};
    PGDH6_c_KmNADP=DatasetS2{i,'PGDH6_c_KmNADP'};
    PGDH6_c_KmRul5P=DatasetS2{i,'PGDH6_c_KmRul5P'};
    PGDH6_c_KmNADPH=DatasetS2{i,'PGDH6_c_KmNADPH'};
    PGDH6_g_Vmax=DatasetS2{i,'PGDH6_g_Vmax'};
    PGDH6_g_Keq=DatasetS2{i,'PGDH6_g_Keq'};
    PGDH6_g_Km6PG=DatasetS2{i,'PGDH6_g_Km6PG'};
    PGDH6_g_KmNADP=DatasetS2{i,'PGDH6_g_KmNADP'};
    PGDH6_g_KmRul5P=DatasetS2{i,'PGDH6_g_KmRul5P'};
    PGDH6_g_KmNADPH=DatasetS2{i,'PGDH6_g_KmNADPH'};
    AK_c_k1=DatasetS2{i,'AK_c_k1'};
    AK_c_k2=DatasetS2{i,'AK_c_k2'};
    AK_g_k1=DatasetS2{i,'AK_g_k1'};
    AK_g_k2=DatasetS2{i,'AK_g_k2'};
    ALD_g_Vmax=DatasetS2{i,'ALD_g_Vmax'};
    ALD_g_Keq=DatasetS2{i,'ALD_g_Keq'};
    ALD_g_KmFru16BP=DatasetS2{i,'ALD_g_KmFru16BP'};
    ALD_g_KiATP=DatasetS2{i,'ALD_g_KiATP'};
    ALD_g_KiADP=DatasetS2{i,'ALD_g_KiADP'};
    ALD_g_KiAMP=DatasetS2{i,'ALD_g_KiAMP'};
    ALD_g_KmGA3P=DatasetS2{i,'ALD_g_KmGA3P'};
    ALD_g_KmDHAP=DatasetS2{i,'ALD_g_KmDHAP'};
    ALD_g_KiGA3P=DatasetS2{i,'ALD_g_KiGA3P'};
    ATPu_c_k=DatasetS2{i,'ATPu_c_k'};
    ENO_c_Vmax=DatasetS2{i,'ENO_c_Vmax'};
    ENO_c_Keq=DatasetS2{i,'ENO_c_Keq'};
    ENO_c_Km2PGA=DatasetS2{i,'ENO_c_Km2PGA'};
    ENO_c_KmPEP=DatasetS2{i,'ENO_c_KmPEP'};
    G3PDH_g_Vmax=DatasetS2{i,'G3PDH_g_Vmax'};
    G3PDH_g_Keq=DatasetS2{i,'G3PDH_g_Keq'};
    G3PDH_g_KmDHAP=DatasetS2{i,'G3PDH_g_KmDHAP'};
    G3PDH_g_KmNADH=DatasetS2{i,'G3PDH_g_KmNADH'};
    G3PDH_g_KmGly3P=DatasetS2{i,'G3PDH_g_KmGly3P'};
    G3PDH_g_KmNAD=DatasetS2{i,'G3PDH_g_KmNAD'};
    G6PDH_c_Vmax=DatasetS2{i,'G6PDH_c_Vmax'};
    G6PDH_c_Keq=DatasetS2{i,'G6PDH_c_Keq'};
    G6PDH_c_KmGlc6P=DatasetS2{i,'G6PDH_c_KmGlc6P'};
    G6PDH_c_KmNADP=DatasetS2{i,'G6PDH_c_KmNADP'};
    G6PDH_c_Km6PGL=DatasetS2{i,'G6PDH_c_Km6PGL'};
    G6PDH_c_KmNADPH=DatasetS2{i,'G6PDH_c_KmNADPH'};
    G6PDH_g_Vmax=DatasetS2{i,'G6PDH_g_Vmax'};
    G6PDH_g_Keq=DatasetS2{i,'G6PDH_g_Keq'};
    G6PDH_g_KmGlc6P=DatasetS2{i,'G6PDH_g_KmGlc6P'};
    G6PDH_g_KmNADP=DatasetS2{i,'G6PDH_g_KmNADP'};
    G6PDH_g_Km6PGL=DatasetS2{i,'G6PDH_g_Km6PGL'};
    G6PDH_g_KmNADPH=DatasetS2{i,'G6PDH_g_KmNADPH'};
    G6PP_c_Vmax=DatasetS2{i,'G6PP_c_Vmax'};
    G6PP_c_Keq=DatasetS2{i,'G6PP_c_Keq'};
    G6PP_c_KmGlc6P=DatasetS2{i,'G6PP_c_KmGlc6P'};
    G6PP_c_KmGlc=DatasetS2{i,'G6PP_c_KmGlc'};
    GAPDH_g_Vmax=DatasetS2{i,'GAPDH_g_Vmax'};
    GAPDH_g_Keq=DatasetS2{i,'GAPDH_g_Keq'};
    GAPDH_g_KmGA3P=DatasetS2{i,'GAPDH_g_KmGA3P'};
    GAPDH_g_KmNAD=DatasetS2{i,'GAPDH_g_KmNAD'};
    GAPDH_g_Km13BPGA=DatasetS2{i,'GAPDH_g_Km13BPGA'};
    GAPDH_g_KmNADH=DatasetS2{i,'GAPDH_g_KmNADH'};
    GDA_g_k=DatasetS2{i,'GDA_g_k'};
    GK_g_Vmax=DatasetS2{i,'GK_g_Vmax'};
    GK_g_Keq=DatasetS2{i,'GK_g_Keq'};
    GK_g_KmGly3P=DatasetS2{i,'GK_g_KmGly3P'};
    GK_g_KmADP=DatasetS2{i,'GK_g_KmADP'};
    GK_g_KmGly=DatasetS2{i,'GK_g_KmGly'};
    GK_g_KmATP=DatasetS2{i,'GK_g_KmATP'};
    GlcT_c_Vmax=DatasetS2{i,'GlcT_c_Vmax'};
    GlcT_c_KmGlc=DatasetS2{i,'GlcT_c_KmGlc'};
    GlcT_c_alpha=DatasetS2{i,'GlcT_c_alpha'};
    GPO_c_Vmax=DatasetS2{i,'GPO_c_Vmax'};
    GPO_c_KmGly3P=DatasetS2{i,'GPO_c_KmGly3P'};
    HXK_c_Vmax=DatasetS2{i,'HXK_c_Vmax'};
    HXK_c_Keq=DatasetS2{i,'HXK_c_Keq'};
    HXK_c_KmGlc=DatasetS2{i,'HXK_c_KmGlc'};
    HXK_c_KmATP=DatasetS2{i,'HXK_c_KmATP'};
    HXK_c_KmGlc6P=DatasetS2{i,'HXK_c_KmGlc6P'};
    HXK_c_KmADP=DatasetS2{i,'HXK_c_KmADP'};
    HXK_g_Vmax=DatasetS2{i,'HXK_g_Vmax'};
    HXK_g_Keq=DatasetS2{i,'HXK_g_Keq'};
    HXK_g_KmGlc=DatasetS2{i,'HXK_g_KmGlc'};
    HXK_g_KmATP=DatasetS2{i,'HXK_g_KmATP'};
    HXK_g_KmGlc6P=DatasetS2{i,'HXK_g_KmGlc6P'};
    HXK_g_KmADP=DatasetS2{i,'HXK_g_KmADP'};
    PFK_g_Vmax=DatasetS2{i,'PFK_g_Vmax'};
    PFK_g_Ki1=DatasetS2{i,'PFK_g_Ki1'};
    PFK_g_Keq=DatasetS2{i,'PFK_g_Keq'};
    PFK_g_KmFru6P=DatasetS2{i,'PFK_g_KmFru6P'};
    PFK_g_KmATP=DatasetS2{i,'PFK_g_KmATP'};
    PFK_g_KsATP=DatasetS2{i,'PFK_g_KsATP'};
    PFK_g_KmADP=DatasetS2{i,'PFK_g_KmADP'};
    PFK_g_Ki2=DatasetS2{i,'PFK_g_Ki2'};
    PGAM_c_Vmax=DatasetS2{i,'PGAM_c_Vmax'};
    PGAM_c_Keq=DatasetS2{i,'PGAM_c_Keq'};
    PGAM_c_Km3PGA=DatasetS2{i,'PGAM_c_Km3PGA'};
    PGAM_c_Km2PGA=DatasetS2{i,'PGAM_c_Km2PGA'};
    PGI_g_Vmax=DatasetS2{i,'PGI_g_Vmax'};
    PGI_g_Keq=DatasetS2{i,'PGI_g_Keq'};
    PGI_g_KmGlc6P=DatasetS2{i,'PGI_g_KmGlc6P'};
    PGI_g_KmFru6P=DatasetS2{i,'PGI_g_KmFru6P'};
    PGI_g_Ki6PG=DatasetS2{i,'PGI_g_Ki6PG'};
    PGK_g_Vmax=DatasetS2{i,'PGK_g_Vmax'};
    PGK_g_Keq=DatasetS2{i,'PGK_g_Keq'};
    PGK_g_Km13BPGA=DatasetS2{i,'PGK_g_Km13BPGA'};
    PGK_g_KmADP=DatasetS2{i,'PGK_g_KmADP'};
    PGK_g_Km3PGA=DatasetS2{i,'PGK_g_Km3PGA'};
    PGK_g_KmATP=DatasetS2{i,'PGK_g_KmATP'};
    PGL_c_Keq=DatasetS2{i,'PGL_c_Keq'};
    PGL_c_k=DatasetS2{i,'PGL_c_k'};
    PGL_c_Vmax=DatasetS2{i,'PGL_c_Vmax'};
    PGL_c_Km6PGL=DatasetS2{i,'PGL_c_Km6PGL'};
    PGL_c_Km6PG=DatasetS2{i,'PGL_c_Km6PG'};
    PGL_g_Keq=DatasetS2{i,'PGL_g_Keq'};
    PGL_g_k=DatasetS2{i,'PGL_g_k'};
    PGL_g_Vmax=DatasetS2{i,'PGL_g_Vmax'};
    PGL_g_Km6PGL=DatasetS2{i,'PGL_g_Km6PGL'};
    PGL_g_Km6PG=DatasetS2{i,'PGL_g_Km6PG'};
    PPI_c_Vmax=DatasetS2{i,'PPI_c_Vmax'};
    PPI_c_Keq=DatasetS2{i,'PPI_c_Keq'};
    PPI_c_KmRul5P=DatasetS2{i,'PPI_c_KmRul5P'};
    PPI_c_KmRib5P=DatasetS2{i,'PPI_c_KmRib5P'};
    PPI_g_Vmax=DatasetS2{i,'PPI_g_Vmax'};
    PPI_g_Keq=DatasetS2{i,'PPI_g_Keq'};
    PPI_g_KmRul5P=DatasetS2{i,'PPI_g_KmRul5P'};
    PPI_g_KmRib5P=DatasetS2{i,'PPI_g_KmRib5P'};
    PYK_c_Vmax=DatasetS2{i,'PYK_c_Vmax'};
    PYK_c_Keq=DatasetS2{i,'PYK_c_Keq'};
    PYK_c_KmPEP=DatasetS2{i,'PYK_c_KmPEP'};
    PYK_c_KiADP=DatasetS2{i,'PYK_c_KiADP'};
    PYK_c_n=DatasetS2{i,'PYK_c_n'};
    PYK_c_KmADP=DatasetS2{i,'PYK_c_KmADP'};
    PYK_c_KmPyr=DatasetS2{i,'PYK_c_KmPyr'};
    PYK_c_KmATP=DatasetS2{i,'PYK_c_KmATP'};
    PyrT_c_Vmax=DatasetS2{i,'PyrT_c_Vmax'};
    PyrT_c_KmPyr=DatasetS2{i,'PyrT_c_KmPyr'};
    TPI_g_Vmax=DatasetS2{i,'TPI_g_Vmax'};
    TPI_g_Keq=DatasetS2{i,'TPI_g_Keq'};
    TPI_g_KmDHAP=DatasetS2{i,'TPI_g_KmDHAP'};
    TPI_g_KmGA3P=DatasetS2{i,'TPI_g_KmGA3P'};
    TR_c_Vmax=DatasetS2{i,'TR_c_Vmax'};
    TR_c_Keq=DatasetS2{i,'TR_c_Keq'};
    TR_c_KmTS2=DatasetS2{i,'TR_c_KmTS2'};
    TR_c_KmNADPH=DatasetS2{i,'TR_c_KmNADPH'};
    TR_c_KmTSH2=DatasetS2{i,'TR_c_KmTSH2'};
    TR_c_KmNADP=DatasetS2{i,'TR_c_KmNADP'};
    PYK_c_KiATP=DatasetS2{i,'PYK_c_KiATP'};

[t,y] = ode15s(@TrypMet,tspan,y0,options);

if (max(t)<time)
        display(i);
        countFailed = countFailed + 1;
        failed{countFailed,1} = [i];
        failed{countFailed,2} = t;
        failed{countFailed,3} = y;  
        
        else
            countNormal = countNormal + 1;
            normal{countNormal,1} = [i];
            normal{countNormal,2} = t;
            normal{countNormal,3} = y;
end

end

failedB = cell(iter, 3);
normalB =  cell(iter, 3);

countFailedB = 0;
countNormalB = 0;

for i=1:iter
    PGAT3_g_k=DatasetN{i,'PGAT3_g_k'};
    PGDH6_c_Vmax= DatasetN{i,'PGDH6_c_Vmax'};
    PGDH6_c_Keq=DatasetN{i,'PGDH6_c_Keq'};
    PGDH6_c_Km6PG=DatasetN{i,'PGDH6_c_Km6PG'};
    PGDH6_c_KmNADP=DatasetN{i,'PGDH6_c_KmNADP'};
    PGDH6_c_KmRul5P=DatasetN{i,'PGDH6_c_KmRul5P'};
    PGDH6_c_KmNADPH=DatasetN{i,'PGDH6_c_KmNADPH'};
    PGDH6_g_Vmax=DatasetN{i,'PGDH6_g_Vmax'};
    PGDH6_g_Keq=DatasetN{i,'PGDH6_g_Keq'};
    PGDH6_g_Km6PG=DatasetN{i,'PGDH6_g_Km6PG'};
    PGDH6_g_KmNADP=DatasetN{i,'PGDH6_g_KmNADP'};
    PGDH6_g_KmRul5P=DatasetN{i,'PGDH6_g_KmRul5P'};
    PGDH6_g_KmNADPH=DatasetN{i,'PGDH6_g_KmNADPH'};
    AK_c_k1=DatasetN{i,'AK_c_k1'};
    AK_c_k2=DatasetN{i,'AK_c_k2'};
    AK_g_k1=DatasetN{i,'AK_g_k1'};
    AK_g_k2=DatasetN{i,'AK_g_k2'};
    ALD_g_Vmax=DatasetN{i,'ALD_g_Vmax'};
    ALD_g_Keq=DatasetN{i,'ALD_g_Keq'};
    ALD_g_KmFru16BP=DatasetN{i,'ALD_g_KmFru16BP'};
    ALD_g_KiATP=DatasetN{i,'ALD_g_KiATP'};
    ALD_g_KiADP=DatasetN{i,'ALD_g_KiADP'};
    ALD_g_KiAMP=DatasetN{i,'ALD_g_KiAMP'};
    ALD_g_KmGA3P=DatasetN{i,'ALD_g_KmGA3P'};
    ALD_g_KmDHAP=DatasetN{i,'ALD_g_KmDHAP'};
    ALD_g_KiGA3P=DatasetN{i,'ALD_g_KiGA3P'};
    ATPu_c_k=DatasetN{i,'ATPu_c_k'};
    ENO_c_Vmax=DatasetN{i,'ENO_c_Vmax'};
    ENO_c_Keq=DatasetN{i,'ENO_c_Keq'};
    ENO_c_Km2PGA=DatasetN{i,'ENO_c_Km2PGA'};
    ENO_c_KmPEP=DatasetN{i,'ENO_c_KmPEP'};
    G3PDH_g_Vmax=DatasetN{i,'G3PDH_g_Vmax'};
    G3PDH_g_Keq=DatasetN{i,'G3PDH_g_Keq'};
    G3PDH_g_KmDHAP=DatasetN{i,'G3PDH_g_KmDHAP'};
    G3PDH_g_KmNADH=DatasetN{i,'G3PDH_g_KmNADH'};
    G3PDH_g_KmGly3P=DatasetN{i,'G3PDH_g_KmGly3P'};
    G3PDH_g_KmNAD=DatasetN{i,'G3PDH_g_KmNAD'};
    G6PDH_c_Vmax=DatasetN{i,'G6PDH_c_Vmax'};
    G6PDH_c_Keq=DatasetN{i,'G6PDH_c_Keq'};
    G6PDH_c_KmGlc6P=DatasetN{i,'G6PDH_c_KmGlc6P'};
    G6PDH_c_KmNADP=DatasetN{i,'G6PDH_c_KmNADP'};
    G6PDH_c_Km6PGL=DatasetN{i,'G6PDH_c_Km6PGL'};
    G6PDH_c_KmNADPH=DatasetN{i,'G6PDH_c_KmNADPH'};
    G6PDH_g_Vmax=DatasetN{i,'G6PDH_g_Vmax'};
    G6PDH_g_Keq=DatasetN{i,'G6PDH_g_Keq'};
    G6PDH_g_KmGlc6P=DatasetN{i,'G6PDH_g_KmGlc6P'};
    G6PDH_g_KmNADP=DatasetN{i,'G6PDH_g_KmNADP'};
    G6PDH_g_Km6PGL=DatasetN{i,'G6PDH_g_Km6PGL'};
    G6PDH_g_KmNADPH=DatasetN{i,'G6PDH_g_KmNADPH'};
    G6PP_c_Vmax=DatasetN{i,'G6PP_c_Vmax'};
    G6PP_c_Keq=DatasetN{i,'G6PP_c_Keq'};
    G6PP_c_KmGlc6P=DatasetN{i,'G6PP_c_KmGlc6P'};
    G6PP_c_KmGlc=DatasetN{i,'G6PP_c_KmGlc'};
    GAPDH_g_Vmax=DatasetN{i,'GAPDH_g_Vmax'};
    GAPDH_g_Keq=DatasetN{i,'GAPDH_g_Keq'};
    GAPDH_g_KmGA3P=DatasetN{i,'GAPDH_g_KmGA3P'};
    GAPDH_g_KmNAD=DatasetN{i,'GAPDH_g_KmNAD'};
    GAPDH_g_Km13BPGA=DatasetN{i,'GAPDH_g_Km13BPGA'};
    GAPDH_g_KmNADH=DatasetN{i,'GAPDH_g_KmNADH'};
    GDA_g_k=DatasetN{i,'GDA_g_k'};
    GK_g_Vmax=DatasetN{i,'GK_g_Vmax'};
    GK_g_Keq=DatasetN{i,'GK_g_Keq'};
    GK_g_KmGly3P=DatasetN{i,'GK_g_KmGly3P'};
    GK_g_KmADP=DatasetN{i,'GK_g_KmADP'};
    GK_g_KmGly=DatasetN{i,'GK_g_KmGly'};
    GK_g_KmATP=DatasetN{i,'GK_g_KmATP'};
    GlcT_c_Vmax=DatasetN{i,'GlcT_c_Vmax'};
    GlcT_c_KmGlc=DatasetN{i,'GlcT_c_KmGlc'};
    GlcT_c_alpha=DatasetN{i,'GlcT_c_alpha'};
    GPO_c_Vmax=DatasetN{i,'GPO_c_Vmax'};
    GPO_c_KmGly3P=DatasetN{i,'GPO_c_KmGly3P'};
    HXK_c_Vmax=DatasetN{i,'HXK_c_Vmax'};
    HXK_c_Keq=DatasetN{i,'HXK_c_Keq'};
    HXK_c_KmGlc=DatasetN{i,'HXK_c_KmGlc'};
    HXK_c_KmATP=DatasetN{i,'HXK_c_KmATP'};
    HXK_c_KmGlc6P=DatasetN{i,'HXK_c_KmGlc6P'};
    HXK_c_KmADP=DatasetN{i,'HXK_c_KmADP'};
    HXK_g_Vmax=DatasetN{i,'HXK_g_Vmax'};
    HXK_g_Keq=DatasetN{i,'HXK_g_Keq'};
    HXK_g_KmGlc=DatasetN{i,'HXK_g_KmGlc'};
    HXK_g_KmATP=DatasetN{i,'HXK_g_KmATP'};
    HXK_g_KmGlc6P=DatasetN{i,'HXK_g_KmGlc6P'};
    HXK_g_KmADP=DatasetN{i,'HXK_g_KmADP'};
    PFK_g_Vmax=DatasetN{i,'PFK_g_Vmax'};
    PFK_g_Ki1=DatasetN{i,'PFK_g_Ki1'};
    PFK_g_Keq=DatasetN{i,'PFK_g_Keq'};
    PFK_g_KmFru6P=DatasetN{i,'PFK_g_KmFru6P'};
    PFK_g_KmATP=DatasetN{i,'PFK_g_KmATP'};
    PFK_g_KsATP=DatasetN{i,'PFK_g_KsATP'};
    PFK_g_KmADP=DatasetN{i,'PFK_g_KmADP'};
    PFK_g_Ki2=DatasetN{i,'PFK_g_Ki2'};
    PGAM_c_Vmax=DatasetN{i,'PGAM_c_Vmax'};
    PGAM_c_Keq=DatasetN{i,'PGAM_c_Keq'};
    PGAM_c_Km3PGA=DatasetN{i,'PGAM_c_Km3PGA'};
    PGAM_c_Km2PGA=DatasetN{i,'PGAM_c_Km2PGA'};
    PGI_g_Vmax=DatasetN{i,'PGI_g_Vmax'};
    PGI_g_Keq=DatasetN{i,'PGI_g_Keq'};
    PGI_g_KmGlc6P=DatasetN{i,'PGI_g_KmGlc6P'};
    PGI_g_KmFru6P=DatasetN{i,'PGI_g_KmFru6P'};
    PGI_g_Ki6PG=DatasetN{i,'PGI_g_Ki6PG'};
    PGK_g_Vmax=DatasetN{i,'PGK_g_Vmax'};
    PGK_g_Keq=DatasetN{i,'PGK_g_Keq'};
    PGK_g_Km13BPGA=DatasetN{i,'PGK_g_Km13BPGA'};
    PGK_g_KmADP=DatasetN{i,'PGK_g_KmADP'};
    PGK_g_Km3PGA=DatasetN{i,'PGK_g_Km3PGA'};
    PGK_g_KmATP=DatasetN{i,'PGK_g_KmATP'};
    PGL_c_Keq=DatasetN{i,'PGL_c_Keq'};
    PGL_c_k=DatasetN{i,'PGL_c_k'};
    PGL_c_Vmax=DatasetN{i,'PGL_c_Vmax'};
    PGL_c_Km6PGL=DatasetN{i,'PGL_c_Km6PGL'};
    PGL_c_Km6PG=DatasetN{i,'PGL_c_Km6PG'};
    PGL_g_Keq=DatasetN{i,'PGL_g_Keq'};
    PGL_g_k=DatasetN{i,'PGL_g_k'};
    PGL_g_Vmax=DatasetN{i,'PGL_g_Vmax'};
    PGL_g_Km6PGL=DatasetN{i,'PGL_g_Km6PGL'};
    PGL_g_Km6PG=DatasetN{i,'PGL_g_Km6PG'};
    PPI_c_Vmax=DatasetN{i,'PPI_c_Vmax'};
    PPI_c_Keq=DatasetN{i,'PPI_c_Keq'};
    PPI_c_KmRul5P=DatasetN{i,'PPI_c_KmRul5P'};
    PPI_c_KmRib5P=DatasetN{i,'PPI_c_KmRib5P'};
    PPI_g_Vmax=DatasetN{i,'PPI_g_Vmax'};
    PPI_g_Keq=DatasetN{i,'PPI_g_Keq'};
    PPI_g_KmRul5P=DatasetN{i,'PPI_g_KmRul5P'};
    PPI_g_KmRib5P=DatasetN{i,'PPI_g_KmRib5P'};
    PYK_c_Vmax=DatasetN{i,'PYK_c_Vmax'};
    PYK_c_Keq=DatasetN{i,'PYK_c_Keq'};
    PYK_c_KmPEP=DatasetN{i,'PYK_c_KmPEP'};
    PYK_c_KiADP=DatasetN{i,'PYK_c_KiADP'};
    PYK_c_n=DatasetN{i,'PYK_c_n'};
    PYK_c_KmADP=DatasetN{i,'PYK_c_KmADP'};
    PYK_c_KmPyr=DatasetN{i,'PYK_c_KmPyr'};
    PYK_c_KmATP=DatasetN{i,'PYK_c_KmATP'};
    PyrT_c_Vmax=DatasetN{i,'PyrT_c_Vmax'};
    PyrT_c_KmPyr=DatasetN{i,'PyrT_c_KmPyr'};
    TPI_g_Vmax=DatasetN{i,'TPI_g_Vmax'};
    TPI_g_Keq=DatasetN{i,'TPI_g_Keq'};
    TPI_g_KmDHAP=DatasetN{i,'TPI_g_KmDHAP'};
    TPI_g_KmGA3P=DatasetN{i,'TPI_g_KmGA3P'};
    TR_c_Vmax=DatasetN{i,'TR_c_Vmax'};
    TR_c_Keq=DatasetN{i,'TR_c_Keq'};
    TR_c_KmTS2=DatasetN{i,'TR_c_KmTS2'};
    TR_c_KmNADPH=DatasetN{i,'TR_c_KmNADPH'};
    TR_c_KmTSH2=DatasetN{i,'TR_c_KmTSH2'};
    TR_c_KmNADP=DatasetN{i,'TR_c_KmNADP'};
    PYK_c_KiATP=DatasetN{i,'PYK_c_KiATP'};

[t,y] = ode15s(@TrypMet,tspan,y0,options);

if (max(t)<time)
        display(i);
        countFailedB = countFailedB + 1;
        failedB{countFailedB,1} = [i];
        failedB{countFailedB,2} = t;
        failedB{countFailedB,3} = y;  
        
        else
            countNormalB = countNormalB + 1;
            normalB{countNormalB,1} = [i];
            normalB{countNormalB,2} = t;
            normalB{countNormalB,3} = y;
end

end

toc;

%% Plot ensemble selected species
% 
% figure (1)
%     for j=1:countNormal
%         plot(normal{j,2},normal{j,3}(:,29));
%         title('Pyr_c vs time'), xlabel('Time'),ylabel('Pyr_c');
%         hold on;
%     end
%     hold off;
% 
%     
% figure (2)
%     for j=1:countNormal
%         plot(normal{j,2},normal{j,3}(:,23));
%         title('Glc_c vs time'), xlabel('Time'),ylabel('Glc_c');
%         hold on;
%     end
%     hold off;
    
    
 %% Plot everything
 
%  a=size(normal{1,3});
%  h=a(2);
%  for k=1:h
%  figure ()
%     for j=1:countNormal
%         plot(normal{j,2},normal{j,3}(:,k));
%         title(['y',sprintf('%d',k),' vs time']), xlabel('Time'),ylabel(['y',sprintf('%d',k)]);
%         hold on;
%     end
%     hold off;
%  end
%%
% figure (1)
%     for j=1:countNormal
%         plot(normal{j,2},normal{j,3}(:,1));
%         hold on;
%     end
%     hold off;

%% Plot ensemble
y29=[]; %Pyr_c
y23=[]; %Glc_c

for t=1:length(normal{1,3}) % time
    for ii=1:countNormal % iteration
        NewRow29(ii)=(normal{ii,3}(t,29));  %Pyr_c
        NewRow23(ii)=(normal{ii,3}(t,23));  %Glc_c
    end
    
    y29=[y29;NewRow29];
    y23=[y23;NewRow23];
    
end

uppercent=0.75;
lowpercent=0.25;

median_29=[]; 
SEM_29=[]; 
hi_29=[]; 
lo_29=[]; 
for ii=1:size(y29,1)
    Hour=y29(ii,:); 
    NewCol29=median(Hour);

    median_29=[median_29, NewCol29]; 
    
    Hi=quantile(Hour,uppercent);
    Lo=quantile(Hour,lowpercent);
    
    hi_29=[hi_29, Hi];  
    lo_29=[lo_29, Lo]; 
    
end

% This will plot the metabolite individually
figure
x=tspan;
plot(x, median_29,'b', 'linewidth', 2); 
hold on;
patch([x fliplr(x)],[hi_29 fliplr(lo_29)],[0.7 0.7 0.7], 'FaceColor','blue','FaceAlpha',.2, 'EdgeColor', 'None'); 
hold off

% to make plot prettier
title('Change in Pyr_c over time')
ylabel('Concentration (nM)'); xlabel('Time (min)');
set(gca, 'Color', 'None', 'box', 'off', 'FontSize', 18, 'FontWeight', 'bold', 'linewidth',2)

median_23=[]; 
SEM_23=[]; 
hi_23=[]; 
lo_23=[]; 
for ii=1:size(y23,1)
    Hour=y23(ii,:); 
    NewCol23=median(Hour);

    median_23=[median_23, NewCol23]; 
    
    Hi=quantile(Hour,uppercent);
    Lo=quantile(Hour,lowpercent);
    
    hi_23=[hi_23, Hi];  
    lo_23=[lo_23, Lo]; 
    
end

% This will plot the metabolite individually
figure
x=tspan;
plot(x, median_23,'b', 'linewidth', 2); 
hold on;
patch([x fliplr(x)],[hi_23 fliplr(lo_23)],[0.7 0.7 0.7], 'FaceColor','blue','FaceAlpha',.2, 'EdgeColor', 'None'); 
hold off

% to make plot prettier
title('Change in Glc_c over time')
ylabel('Concentration (nM)'); xlabel('Time (min)');
set(gca, 'Color', 'None', 'box', 'off', 'FontSize', 18, 'FontWeight', 'bold', 'linewidth',2)

%%
y29b=[]; %Pyr_c
y23b=[]; %Glc_c

for t=1:length(normalB{1,3}) % time
    for ii=1:countNormalB % iteration
        NewRow29b(ii)=(normalB{ii,3}(t,29));  %Pyr_c
        NewRow23b(ii)=(normalB{ii,3}(t,23));  %Glc_c
    end
    
    y29b=[y29b;NewRow29b];
    y23b=[y23b;NewRow23b];
    
end

uppercent=0.75;
lowpercent=0.25;

median_29b=[]; 
SEM_29b=[]; 
hi_29b=[]; 
lo_29b=[]; 
for ii=1:size(y29b,1)
    Hour=y29b(ii,:); 
    NewCol29b=median(Hour);

    median_29b=[median_29b, NewCol29b]; 
    
    Hi=quantile(Hour,uppercent);
    Lo=quantile(Hour,lowpercent);
    
    hi_29b=[hi_29b, Hi];  
    lo_29b=[lo_29b, Lo]; 
    
end

% This will plot the metabolite individually
figure
x=tspan;
plot(x, median_29b,'b', 'linewidth', 2); 
hold on;
patch([x fliplr(x)],[hi_29b fliplr(lo_29b)],[0.7 0.7 0.7], 'FaceColor','blue','FaceAlpha',.2, 'EdgeColor', 'None'); 
hold off

% to make plot prettier
title('Change in Pyr_c over time')
ylabel('Concentration (nM)'); xlabel('Time (min)');
set(gca, 'Color', 'None', 'box', 'off', 'FontSize', 18, 'FontWeight', 'bold', 'linewidth',2)

median_23b=[]; 
SEM_23b=[]; 
hi_23b=[]; 
lo_23b=[]; 
for ii=1:size(y23b,1)
    Hour=y23b(ii,:); 
    NewCol23b=median(Hour);

    median_23b=[median_23b, NewCol23b]; 
    
    Hi=quantile(Hour,uppercent);
    Lo=quantile(Hour,lowpercent);
    
    hi_23b=[hi_23b, Hi];  
    lo_23b=[lo_23b, Lo]; 
    
end

% This will plot the metabolite individually
figure
x=tspan;
plot(x, median_23b,'b', 'linewidth', 2); 
hold on;
patch([x fliplr(x)],[hi_23b fliplr(lo_23b)],[0.7 0.7 0.7], 'FaceColor','blue','FaceAlpha',.2, 'EdgeColor', 'None'); 
hold off

% to make plot prettier
title('Change in Glc_c over time')
ylabel('Concentration (nM)'); xlabel('Time (min)');
set(gca, 'Color', 'None', 'box', 'off', 'FontSize', 18, 'FontWeight', 'bold', 'linewidth',2)

%%
FinalRes=[];
for j=1:countNormal
        Temp=normal{j,3}(end,:);
        FinalRes=[FinalRes;Temp];
end

FinalResB=[];
for j=1:countNormalB
        TempB=normalB{j,3}(end,:);
        FinalResB=[FinalResB;TempB];
end

%%
pd = fitdist(FinalRes(:,1),'Kernel');
pd2 = fitdist(FinalResB(:,1),'Kernel');
x1 = 0.0000001:0.0000001:0.01;
x2 = 0.0000001:0.0000001:0.004;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
figure()
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('2PGA_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 2PGA_c concentrations');
hold off;

%%
pd = fitdist(FinalRes(:,2),'Kernel');
pd2 = fitdist(FinalResB(:,2),'Kernel');
x = 4.998:0.0001:5.001;
x2 = 4.998:0.0001:5.001;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
figure()
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for 2PGA_c concentrations'), xlabel('2PGA_c (mM)'),ylabel('Frequency'); 
hold off;

%%
pd = fitdist(FinalRes(:,3),'Kernel');
pd2 = fitdist(FinalResB(:,3),'Kernel');
x1 = 1e-11:1e-12:5e-9;
x2 = 1e-10:1e-12:1e-7;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
figure()
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('ATP_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for ATP_g concentrations');
hold off;
 
%%
pd = fitdist(FinalRes(:,4),'Kernel');
pd2 = fitdist(FinalResB(:,4),'Kernel');
figure()
x1 = 1e-13:1e-13:5e-11;
x2 = 1e-13:1e-13:5e-10;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('DHAP_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for DHAP_g concentrations');

%%
pd = fitdist(FinalRes(:,5),'Kernel');
pd2 = fitdist(FinalResB(:,5),'Kernel');
figure()
x1 = 1e-6:1e-6:0.001;
x2 = 1e-5:1e-6:7e-2;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('ADP_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for ADP_g concentrations');

%%
pd = fitdist(FinalRes(:,6),'Kernel');
pd2 = fitdist(FinalResB(:,6),'Kernel');
figure()
x1 = 1e-9:1e-10:2e-7;
x2 = 1e-9:1e-10:8e-6;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Glc6P_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Glc6P_g concentrations');

%%
pd = fitdist(FinalRes(:,7),'Kernel');
pd2 = fitdist(FinalResB(:,7),'Kernel');
figure()
x1 = 1e-6:1e-6:2e-3;
x2 = 1e-5:1e-6:0.6;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('ADP_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for ADP_c concentrations');

%%
pd = fitdist(FinalRes(:,8),'Kernel');
pd2 = fitdist(FinalResB(:,8),'Kernel');
figure()
x1 = 0.0001:1e-4:0.05;
x2 = 0.00001:1e-5:0.01;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('3PGA_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 3PGA_c concentrations');

%%
pd = fitdist(FinalRes(:,9),'Kernel');
pd2 = fitdist(FinalResB(:,9),'Kernel');
figure()
x1 = 1e-10:1e-11:1e-7;
x2 = 1e-10:1e-11:3e-6;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Fru6P_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Fru6P_g concentrations');

%%
pd = fitdist(FinalRes(:,12),'Kernel');
pd2 = fitdist(FinalResB(:,12),'Kernel');
figure()
x = 3:0.001:4.2;
x2 = 3.8:0.001:4.2;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for NADP_c concentrations'), xlabel('NADP_c (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,13),'Kernel');
pd2 = fitdist(FinalResB(:,13),'Kernel');
figure()
x1 = 1e-11:1e-11:1e-8;
x2 = 1e-9:1e-10:5e-6;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('ATP_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for ATP_c concentrations');

%%
pd = fitdist(FinalRes(:,15),'Kernel');
pd2 = fitdist(FinalResB(:,15),'Kernel');
figure()
x1 = 1e-11:1e-11:1e-8;
x2 = 1e-11:1e-11:3e-6;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('6PG_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 6PG_g concentrations');

%%
pd = fitdist(FinalRes(:,17),'Kernel');
pd2 = fitdist(FinalResB(:,17),'Kernel');
figure()
x = 1e-4:1e-4:4e-2;
x2 = 1e-4:1e-4:2e-2;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for Rul5P_c concentrations'), xlabel('Rul5P_c (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,18),'Kernel');
pd2 = fitdist(FinalResB(:,18),'Kernel');
figure()
x = 1e-8:1e-9:1.4e-3;
x2 = 1e-8:1e-9:1e-3;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for 6PG_c concentrations'), xlabel('6PG_c (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,19),'Kernel');
pd2 = fitdist(FinalResB(:,19),'Kernel');
figure()
x = 1e-3:1e-5:8e-3;
x2 = 1e-3:1e-5:8e-3;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for Rul5P_g concentrations'), xlabel('Rul5P_g (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,20),'Kernel');
pd2 = fitdist(FinalResB(:,20),'Kernel');
figure()
x1 = 1e-2:1e-3:250;
x2 = 1e-6:1e-6:2e-3;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Glc6P_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Glc6P_c concentrations');

%%
pd = fitdist(FinalRes(:,22),'Kernel');
pd2 = fitdist(FinalResB(:,22),'Kernel');
figure()
x = 1e-14:1e-15:1e-10;
x2 = 1e-14:1e-15:1e-10;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]);
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]);
ax2 = gca;
ax2.YColor = 'k';
yyaxis left
title('Kernel density for 13BPGA_g concentrations'), xlabel('13BPGA_g (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,23),'Kernel');
pd2 = fitdist(FinalResB(:,23),'Kernel');
figure()
x1 = 0.01:1e-3:300;
x2 = 4.8:1e-2:5.3;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Glc_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Glc_c concentrations');

%%
pd = fitdist(FinalRes(:,25),'Kernel');
pd2 = fitdist(FinalResB(:,25),'Kernel');
figure()
x1 = 0.01:1e-3:300;
x2 = 4.8:1e-2:5.3;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Glc_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Glc_g concentrations');

%%
pd = fitdist(FinalRes(:,27),'Kernel');
pd2 = fitdist(FinalResB(:,27),'Kernel');
figure()
x1 = 1e-7:1e-6:4e-5;
x2 = 1e-6:1e-6:1e-3;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('NADPH_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for NADPH_g concentrations');

%%
pd = fitdist(FinalRes(:,28),'Kernel');
pd2 = fitdist(FinalResB(:,28),'Kernel');
figure()
x1 = 0.1:1e-3:0.6;
x2 = 1e-5:1e-6:0.004;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('NADPH_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for NADPH_c concentrations');

%%
pd = fitdist(FinalRes(:,29),'Kernel');
pd2 = fitdist(FinalResB(:,29),'Kernel');
figure()
x = 0:0.0000000001:0.000006;
x2 = 0:0.0000000001:0.000006;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2 = gca;
ax2.YColor = 'r';
yyaxis left
title('Kernel density for Pyr_c concentrations'), xlabel('Pyr_c (mM)'),ylabel('Frequency'); 

%%
pd = fitdist(FinalRes(:,32),'Kernel');
pd2 = fitdist(FinalResB(:,32),'Kernel');
figure()
x1 = 1e-20:1e-20:1e-17;
x2 = 1e-14:1e-15:1e-11;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Fru16BP_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Fru16BP_g concentrations');

%%
pd = fitdist(FinalRes(:,33),'Kernel');
pd2 = fitdist(FinalResB(:,33),'Kernel');
figure()
x1 = 1e-14:1e-14:5e-12;
x2 = 1e-14:1e-14:1e-10;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('GA3P_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for GA3P_g concentrations');

%%
pd = fitdist(FinalRes(:,35),'Kernel');
pd2 = fitdist(FinalResB(:,35),'Kernel');
figure()
x = 1e-3:1e-4:0.45;
x2 = 1e-4:1e-5:0.45;
y = pdf(pd,x);
y2 = pdf(pd2,x2);
plot(x,y,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
ax1 = gca;
ax1.YColor = 'k';
hold on;
yyaxis right
plot(x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2 = gca;
ax2.YColor = 'r';
yyaxis left
title('Kernel density for TSH2_c concentrations'), xlabel('TSH2_c (mM)'),ylabel('Frequency');

%%
pd = fitdist(FinalRes(:,37),'Kernel');
pd2 = fitdist(FinalResB(:,37),'Kernel');
figure()
x1 = 1e-15:1e-15:4e-11;
x2 = 1e-15:1e-15:4e-10;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Gly3P_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Gly3P_c concentrations');

%%
pd = fitdist(FinalRes(:,38),'Kernel');
pd2 = fitdist(FinalResB(:,38),'Kernel');
figure()
x1 = 1e-15:1e-15:5e-12;
x2 = 1e-15:1e-15:5e-11;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('Gly3P_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for Gly3P_g concentrations');

%% 
pd = fitdist(FinalRes(:,39),'Kernel');
pd2 = fitdist(FinalResB(:,39),'Kernel');
figure()
x1 = 1e-6:1e-6:0.007;
x2 = 1e-6:1e-6:0.001;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('6PGL_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 6PGL_c concentrations');

%%
pd = fitdist(FinalRes(:,40),'Kernel');
pd2 = fitdist(FinalResB(:,40),'Kernel');
figure()
x1 = 1e-3:1e-4:0.5;
x2 = 1e-4:1e-4:0.1;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('TS2_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for TS2_c concentrations');

%% 
pd = fitdist(FinalRes(:,41),'Kernel');
pd2 = fitdist(FinalResB(:,41),'Kernel');
figure()
x1 = 1e-9:1e-10:2e-7;
x2 = 1e-8:1e-10:1e-5;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('6PGL_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 6PGL_g concentrations');

%% 
pd = fitdist(FinalRes(:,42),'Kernel');
pd2 = fitdist(FinalResB(:,42),'Kernel');
figure()
x1 = 1e-4:1e-5:0.05;
x2 = 1e-5:1e-5:0.007;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('PEP_c (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for PEP_c concentrations');

%% 
pd = fitdist(FinalRes(:,44),'Kernel');
pd2 = fitdist(FinalResB(:,44),'Kernel');
figure()
x1 = 1e-4:1e-5:0.05;
x2 = 1e-5:1e-5:0.007;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('3PGA_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for 3PGA_g concentrations');

%% 
pd = fitdist(FinalRes(:,46),'Kernel');
pd2 = fitdist(FinalResB(:,46),'Kernel');
figure()
x1 = 1e-4:1e-5:0.03;
x2 = 1e-5:1e-5:1;
y1 = pdf(pd,x1);
y2 = pdf(pd2,x2);
t = tiledlayout(1,1);
ax1 = axes(t);
plot(ax1,x1,y1,'LineWidth',2,'Color',[0.49 0.18 0.56]); %purple
xlabel('NADH_g (mM)'),ylabel('Frequency');
hold on;
ax2 = axes(t);
plot(ax2,x2,y2,'LineWidth',2,'Color',[1.00 0.41 0.16]); %orange
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';
ax2.Box = 'off';
title('Kernel density for NADH_g concentrations');

%% Save figures
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = num2str(get(FigHandle, 'Number'));
  set(0, 'CurrentFigure', FigHandle);
  saveas(FigHandle, fullfile('Results_plots', strcat(FigName, '.png'))); 
end
