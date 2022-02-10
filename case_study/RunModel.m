tic;
global PGAT3_g_k PGDH6_c_Vmax PGDH6_c_Keq PGDH6_c_Km6PG PGDH6_c_KmNADP PGDH6_c_KmRul5P PGDH6_c_KmNADPH PGDH6_g_Vmax PGDH6_g_Keq PGDH6_g_Km6PG PGDH6_g_KmNADP PGDH6_g_KmRul5P PGDH6_g_KmNADPH AK_c_k1 AK_c_k2 AK_g_k1 AK_g_k2
global ALD_g_Vmax ALD_g_Keq ALD_g_KmFru16BP ALD_g_KiATP ALD_g_KiADP ALD_g_KiAMP ALD_g_KmGA3P ALD_g_KmDHAP ALD_g_KiGA3P ATPu_c_k ENO_c_Vmax ENO_c_Keq ENO_c_Km2PGA ENO_c_KmPEP G3PDH_g_Vmax G3PDH_g_Keq G3PDH_g_KmDHAP G3PDH_g_KmNADH G3PDH_g_KmGly3P G3PDH_g_KmNAD
global G6PDH_c_Vmax G6PDH_c_Keq G6PDH_c_KmGlc6P G6PDH_c_KmNADP G6PDH_c_Km6PGL G6PDH_c_KmNADPH G6PDH_g_Vmax G6PDH_g_Keq G6PDH_g_KmGlc6P G6PDH_g_KmNADP G6PDH_g_Km6PGL G6PDH_g_KmNADPH G6PP_c_Vmax G6PP_c_Keq G6PP_c_KmGlc6P G6PP_c_KmGlc
global GAPDH_g_Vmax GAPDH_g_Keq GAPDH_g_KmGA3P GAPDH_g_KmNAD GAPDH_g_Km13BPGA GAPDH_g_KmNADH GDA_g_k GK_g_Vmax GK_g_Keq GK_g_KmGly3P GK_g_KmADP GK_g_KmGly GK_g_KmATP GlcT_c_Vmax GlcT_c_KmGlc GlcT_c_alpha GPO_c_Vmax GPO_c_KmGly3P
global HXK_c_Vmax HXK_c_Keq HXK_c_KmGlc HXK_c_KmATP HXK_c_KmGlc6P HXK_c_KmADP HXK_g_Vmax HXK_g_Keq HXK_g_KmGlc HXK_g_KmATP HXK_g_KmGlc6P HXK_g_KmADP PFK_g_Vmax PFK_g_Ki1 PFK_g_Keq PFK_g_KmFru6P PFK_g_KmATP PFK_g_KsATP PFK_g_KmADP PFK_g_Ki2
global PGAM_c_Vmax PGAM_c_Keq PGAM_c_Km3PGA PGAM_c_Km2PGA PGI_g_Vmax PGI_g_Keq PGI_g_KmGlc6P PGI_g_KmFru6P PGI_g_Ki6PG PGK_g_Vmax PGK_g_Keq PGK_g_Km13BPGA PGK_g_KmADP PGK_g_Km3PGA PGK_g_KmATP PGL_c_k PGL_c_Keq PGL_c_Vmax PGL_c_Km6PGL PGL_c_Km6PG
global PGL_g_k PGL_g_Keq PGL_g_Vmax PGL_g_Km6PGL PGL_g_Km6PG PPI_c_Vmax PPI_c_Keq PPI_c_KmRul5P PPI_c_KmRib5P PPI_g_Vmax PPI_g_Keq PPI_g_KmRul5P PPI_g_KmRib5P PYK_c_Vmax PYK_c_Keq PYK_c_KmPEP PYK_c_KiADP PYK_c_n PYK_c_KmADP PYK_c_KmPyr PYK_c_KmATP PyrT_c_Vmax PyrT_c_KmPyr
global TPI_g_Vmax TPI_g_Keq TPI_g_KmDHAP TPI_g_KmGA3P TR_c_Vmax TR_c_Keq TR_c_KmTS2 TR_c_KmNADPH TR_c_KmTSH2 TR_c_KmNADP PYK_c_KiATP

time=2;
tspan=0:0.3:time;
y0=[0.1 2.23 0.2405 8.483 1.519 0.5 1.3165 0.1 0.5 0 1 0.1 0.3417 0.1 0.084 0 0.413 0.0842 0.413 0.5 0.01 0.5 0.1 0.01 0.1 5 3.9 3.9 10 0 2 10 2.5 0 0.01 0 2.769 10.52 0.0795 0.37 0.0795 1 4.241 0.1 2.242 2];

options = odeset('RelTol',1e-9,'AbsTol',1e-16,'NormControl','on');
iter = 1;

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


toc;

%% Plot ensemble

figure (1)
    for j=1:countNormal
        plot(normal{j,2},normal{j,3}(:,29));
        title('Pyr_c vs time'), xlabel('Time'),ylabel('Pyr_c');
        hold on;
    end
    hold off;

    
figure (2)
    for j=1:countNormal
        plot(normal{j,2},normal{j,3}(:,23));
        title('Glc_c vs time'), xlabel('Time'),ylabel('Glc_c');
        hold on;
    end
    hold off;
    
    
 %% Plot everything
 
 for k=1:length(normal{j,3})
 figure ()
    for j=1:countNormal
        plot(normal{j,2},normal{j,3}(:,k));
        title(['y',sprintf('%d',k),' vs time']), xlabel('Time'),ylabel(['y',sprintf('%d',k)]);
        hold on;
    end
    hold off;
 end
 
 
 