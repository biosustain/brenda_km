#ifdef SIZE_DEFINITIONS
#define N_METABS 46
#define N_ODE_METABS 0
#define N_INDEP_METABS 30
#define N_COMPARTMENTS 3
#define N_GLOBAL_PARAMS 0
#define N_KIN_PARAMS 150
#define N_REACTIONS 35

#define N_ARRAY_SIZE_P  162	// number of parameters
#define N_ARRAY_SIZE_X  30	// number of initials
#define N_ARRAY_SIZE_Y  7	// number of assigned elements
#define N_ARRAY_SIZE_XC 30	// number of x concentration
#define N_ARRAY_SIZE_PC 9	// number of p concentration
#define N_ARRAY_SIZE_YC 7	// number of y concentration
#define N_ARRAY_SIZE_DX 30	// number of ODEs 
#define N_ARRAY_SIZE_CT 7	// number of conserved totals

#endif // SIZE_DEFINITIONS

#ifdef TIME
#define T  <set here a user name for the time variable> 
#endif // TIME

#ifdef NAME_ARRAYS
const char* p_names[] = {"CO2_c", "Rib5P_c", "Pi_g", "Rib5P_g", "CO2_g", "O2_c", "Glc_e", "Pyr_e", "Gly_e", "cytosol", "glycosome", "default", "TPI_g_Vmax", "TPI_g_Keq", "TPI_g_KmDHAP", "TPI_g_KmGA3P", "PYK_c_Vmax", "PYK_c_KmPEP", "PYK_c_KiATP", "PYK_c_KiADP", "PYK_c_n", "PYK_c_KmADP", "PYK_c_Keq", "PYK_c_KmPyr", "PYK_c_KmATP", "PFK_g_Vmax", "PFK_g_Ki1", "PFK_g_KmFru6P", "PFK_g_KmATP", "PFK_g_Keq", "PFK_g_KsATP", "PFK_g_KmADP", "PFK_g_Ki2", "G6PDH_g_Vmax", "G6PDH_g_Keq", "G6PDH_g_KmGlc6P", "G6PDH_g_KmNADP", "G6PDH_g_Km6PGL", "G6PDH_g_KmNADPH", "PGAM_c_Vmax", "PGAM_c_Keq", "PGAM_c_Km3PGA", "PGAM_c_Km2PGA", "PyrT_c_Vmax", "PyrT_c_KmPyr", "G6PDH_c_Vmax", "G6PDH_c_Keq", "G6PDH_c_KmGlc6P", "G6PDH_c_KmNADP", "G6PDH_c_Km6PGL", "G6PDH_c_KmNADPH", "ENO_c_Vmax", "ENO_c_Keq", "ENO_c_Km2PGA", "ENO_c_KmPEP", "HXK_g_Vmax", "HXK_g_Keq", "HXK_g_KmGlc", "HXK_g_KmATP", "HXK_g_KmGlc6P", "HXK_g_KmADP", "_3PGAT_g_k", "NADPHu_c_k", "HXK_c_Vmax", "HXK_c_Keq", "HXK_c_KmGlc", "HXK_c_KmATP", "HXK_c_KmGlc6P", "HXK_c_KmADP", "NADPHu_g_k", "AK_c_k1", "AK_c_k2", "G6PP_c_Vmax", "G6PP_c_Keq", "G6PP_c_KmGlc6P", "G6PP_c_KmGlc", "_6PGDH_g_Vmax", "_6PGDH_g_Keq", "_6PGDH_g_Km6PG", "_6PGDH_g_KmNADP", "_6PGDH_g_KmRul5P", "_6PGDH_g_KmNADPH", "PGI_g_Vmax", "PGI_g_KmGlc6P", "PGI_g_Keq", "PGI_g_KmFru6P", "PGI_g_Ki6PG", "AK_g_k1", "AK_g_k2", "TOX_c_k", "GDA_g_k", "PGL_c_Vmax", "PGL_c_Keq", "PGL_c_Km6PGL", "PGL_c_Km6PG", "PGL_c_k", "_6PGDH_c_Vmax", "_6PGDH_c_Keq", "_6PGDH_c_Km6PG", "_6PGDH_c_KmNADP", "_6PGDH_c_KmRul5P", "_6PGDH_c_KmNADPH", "PPI_c_Vmax", "PPI_c_Keq", "PPI_c_KmRul5P", "PPI_c_KmRib5P", "PPI_g_Vmax", "PPI_g_Keq", "PPI_g_KmRul5P", "PPI_g_KmRib5P", "k1", "k2", "GlcT_c_Vmax", "GlcT_c_KmGlc", "GlcT_c_alpha", "PGL_g_Vmax", "PGL_g_Keq", "PGL_g_Km6PGL", "PGL_g_Km6PG", "PGL_g_k", "TR_c_Vmax", "TR_c_Keq", "TR_c_KmTS2", "TR_c_KmNADPH", "TR_c_KmTSH2", "TR_c_KmNADP", "PGK_g_Vmax", "PGK_g_Keq", "PGK_g_Km13BPGA", "PGK_g_KmADP", "PGK_g_Km3PGA", "PGK_g_KmATP", "G3PDH_g_Vmax", "G3PDH_g_Keq", "G3PDH_g_KmDHAP", "G3PDH_g_KmNADH", "G3PDH_g_KmGly3P", "G3PDH_g_KmNAD", "ATPu_c_k", "GK_g_Vmax", "GK_g_Keq", "GK_g_KmGly3P", "GK_g_KmADP", "GK_g_KmGly", "GK_g_KmATP", "ALD_g_Vmax", "ALD_g_KmFru16BP", "ALD_g_KiATP", "ALD_g_KiADP", "ALD_g_KiAMP", "ALD_g_Keq", "ALD_g_KmGA3P", "ALD_g_KmDHAP", "ALD_g_KiGA3P", "GAPDH_g_Vmax", "GAPDH_g_Keq", "GAPDH_g_KmGA3P", "GAPDH_g_KmNAD", "GAPDH_g_Km13BPGA", "GAPDH_g_KmNADH", "GPO_c_Vmax", "GPO_c_KmGly3P",  "" };
const char* x_names[] = {"ADP_g", "ADP_c", "NADP_c", "DHAP_g", "Glc_c", "NADP_g", "GA3P_g", "Glc6P_g", "_3PGA_c", "Gly3P_g", "Pyr_c", "TSH2_c", "_6PGL_c", "Rul5P_c", "_6PG_g", "Gly3P_c", "Fru6P_g", "_13BPGA_g", "_2PGA_c", "Rul5P_g", "Glc6P_c", "Glc_g", "NAD_g", "PEP_c", "_6PGL_g", "_6PG_c", "_3PGA_g", "ATP_c", "Fru16BP_g", "ATP_g",  "" };
const char* y_names[] = {"TS2_c", "NADH_g", "AMP_g", "DHAP_c", "AMP_c", "NADPH_c", "NADPH_g",  "" };
const char* xc_names[] = {"ADP_g", "ADP_c", "NADP_c", "DHAP_g", "Glc_c", "NADP_g", "GA3P_g", "Glc6P_g", "_3PGA_c", "Gly3P_g", "Pyr_c", "TSH2_c", "_6PGL_c", "Rul5P_c", "_6PG_g", "Gly3P_c", "Fru6P_g", "_13BPGA_g", "_2PGA_c", "Rul5P_g", "Glc6P_c", "Glc_g", "NAD_g", "PEP_c", "_6PGL_g", "_6PG_c", "_3PGA_g", "ATP_c", "Fru16BP_g", "ATP_g",  "" };
const char* pc_names[] = {"CO2_c", "Rib5P_c", "Pi_g", "Rib5P_g", "CO2_g", "O2_c", "Glc_e", "Pyr_e", "Gly_e",  "" };
const char* yc_names[] = {"TS2_c", "NADH_g", "AMP_g", "DHAP_c", "AMP_c", "NADPH_c", "NADPH_g",  "" };
const char* dx_names[] = {"ODE ADP_g", "ODE ADP_c", "ODE NADP_c", "ODE DHAP_g", "ODE Glc_c", "ODE NADP_g", "ODE GA3P_g", "ODE Glc6P_g", "ODE _3PGA_c", "ODE Gly3P_g", "ODE Pyr_c", "ODE TSH2_c", "ODE _6PGL_c", "ODE Rul5P_c", "ODE _6PG_g", "ODE Gly3P_c", "ODE Fru6P_g", "ODE _13BPGA_g", "ODE _2PGA_c", "ODE Rul5P_g", "ODE Glc6P_c", "ODE Glc_g", "ODE NAD_g", "ODE PEP_c", "ODE _6PGL_g", "ODE _6PG_c", "ODE _3PGA_g", "ODE ATP_c", "ODE Fru16BP_g", "ODE ATP_g",  "" };
const char* ct_names[] = {"CT TS2_c", "CT NADH_g", "CT AMP_g", "CT DHAP_c", "CT AMP_c", "CT NADPH_c", "CT NADPH_g",  "" };
#endif // NAME_ARRAYS

#ifdef INITIAL
x[0] = 0.372307;	//metabolite 'ADP_g': reactions
x[1] = 7.18138;	//metabolite 'ADP_c': reactions
x[2] = 0.54549;	//metabolite 'NADP_c': reactions
x[3] = 2.07922;	//metabolite 'DHAP_g': reactions
x[4] = 0.54549;	//metabolite 'Glc_c': reactions
x[5] = 0.02451;	//metabolite 'NADP_g': reactions
x[6] = 0.61275;	//metabolite 'GA3P_g': reactions
x[7] = 0.12255;	//metabolite 'Glc6P_g': reactions
x[8] = 0.54549;	//metabolite '_3PGA_c': reactions
x[9] = 2.57768;	//metabolite 'Gly3P_g': reactions
x[10] = 54.549;	//metabolite 'Pyr_c': reactions
x[11] = 0.054549;	//metabolite 'TSH2_c': reactions
x[12] = 0.433816;	//metabolite '_6PGL_c': reactions
x[13] = 2.25189;	//metabolite 'Rul5P_c': reactions
x[14] = 0.0206364;	//metabolite '_6PG_g': reactions
x[15] = 15.1028;	//metabolite 'Gly3P_c': reactions
x[16] = 0.12255;	//metabolite 'Fru6P_g': reactions
x[17] = 0.12255;	//metabolite '_13BPGA_g': reactions
x[18] = 0.54549;	//metabolite '_2PGA_c': reactions
x[19] = 0.101182;	//metabolite 'Rul5P_g': reactions
x[20] = 2.72745;	//metabolite 'Glc6P_c': reactions
x[21] = 0.02451;	//metabolite 'Glc_g': reactions
x[22] = 0.4902;	//metabolite 'NAD_g': reactions
x[23] = 5.4549;	//metabolite 'PEP_c': reactions
x[24] = 0.0194923;	//metabolite '_6PGL_g': reactions
x[25] = 0.45928;	//metabolite '_6PG_c': reactions
x[26] = 0.02451;	//metabolite '_3PGA_g': reactions
x[27] = 1.86394;	//metabolite 'ATP_c': reactions
x[28] = 2.451;	//metabolite 'Fru16BP_g': reactions
x[29] = 0.0589466;	//metabolite 'ATP_g': reactions
#endif /* INITIAL */

#ifdef FIXED
ct[0] = 2.0728620000000002;	//ct[0] conserved total for 'TS2_c'
ct[1] = 0.98039999999999994;	//ct[1] conserved total for 'NADH_g'
ct[2] = 1.4706000000000001;	//ct[2] conserved total for 'AMP_g'
ct[3] = 27.274500000000003;	//ct[3] conserved total for 'DHAP_c'
ct[4] = 21.274110000000004;	//ct[4] conserved total for 'AMP_c'
ct[5] = 21.819600000000005;	//ct[5] conserved total for 'NADPH_c'
ct[6] = 0.98040000000000005;	//ct[6] conserved total for 'NADPH_g'
p[0] = 0;	//metabolite 'CO2_c': fixed
p[1] = 0.054549;	//metabolite 'Rib5P_c': fixed
p[2] = 0;	//metabolite 'Pi_g': fixed
p[3] = 0.002451;	//metabolite 'Rib5P_g': fixed
p[4] = 0;	//metabolite 'CO2_g': fixed
p[5] = 1;	//metabolite 'O2_c': fixed
p[6] = 5;	//metabolite 'Glc_e': fixed
p[7] = 0;	//metabolite 'Pyr_e': fixed
p[8] = 0;	//metabolite 'Gly_e': fixed
p[9] = 5.4549;	//compartment 'cytosol':fixed
p[10] = 0.2451;	//compartment 'glycosome':fixed
p[11] = 1;	//compartment 'default':fixed
p[12] = 999.3;	//reaction 'TPI_g':  kinetic parameter 'TPI_g_Vmax'
p[13] = 0.046;	//reaction 'TPI_g':  kinetic parameter 'TPI_g_Keq'
p[14] = 1.2;	//reaction 'TPI_g':  kinetic parameter 'TPI_g_KmDHAP'
p[15] = 0.25;	//reaction 'TPI_g':  kinetic parameter 'TPI_g_KmGA3P'
p[16] = 1020;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_Vmax'
p[17] = 0.34;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KmPEP'
p[18] = 0.57;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KiATP'
p[19] = 0.64;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KiADP'
p[20] = 2.5;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_n'
p[21] = 0.114;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KmADP'
p[22] = 10800;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_Keq'
p[23] = 50;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KmPyr'
p[24] = 15;	//reaction 'PYK_c':  kinetic parameter 'PYK_c_KmATP'
p[25] = 1708;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_Vmax'
p[26] = 15.8;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_Ki1'
p[27] = 0.999;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_KmFru6P'
p[28] = 0.0648;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_KmATP'
p[29] = 1035;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_Keq'
p[30] = 0.0393;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_KsATP'
p[31] = 1;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_KmADP'
p[32] = 10.7;	//reaction 'PFK_g':  kinetic parameter 'PFK_g_Ki2'
p[33] = 8.4;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_Vmax'
p[34] = 5.02;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_Keq'
p[35] = 0.058;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_KmGlc6P'
p[36] = 0.0094;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_KmNADP'
p[37] = 0.04;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_Km6PGL'
p[38] = 0.0001;	//reaction 'G6PDH_g':  kinetic parameter 'G6PDH_g_KmNADPH'
p[39] = 225;	//reaction 'PGAM_c':  kinetic parameter 'PGAM_c_Vmax'
p[40] = 0.17;	//reaction 'PGAM_c':  kinetic parameter 'PGAM_c_Keq'
p[41] = 0.15;	//reaction 'PGAM_c':  kinetic parameter 'PGAM_c_Km3PGA'
p[42] = 0.16;	//reaction 'PGAM_c':  kinetic parameter 'PGAM_c_Km2PGA'
p[43] = 230;	//reaction 'PyrT_c':  kinetic parameter 'PyrT_c_Vmax'
p[44] = 1.96;	//reaction 'PyrT_c':  kinetic parameter 'PyrT_c_KmPyr'
p[45] = 8.4;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_Vmax'
p[46] = 5.02;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_Keq'
p[47] = 0.058;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_KmGlc6P'
p[48] = 0.0094;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_KmNADP'
p[49] = 0.04;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_Km6PGL'
p[50] = 0.0001;	//reaction 'G6PDH_c':  kinetic parameter 'G6PDH_c_KmNADPH'
p[51] = 598;	//reaction 'ENO_c':  kinetic parameter 'ENO_c_Vmax'
p[52] = 4.17;	//reaction 'ENO_c':  kinetic parameter 'ENO_c_Keq'
p[53] = 0.054;	//reaction 'ENO_c':  kinetic parameter 'ENO_c_Km2PGA'
p[54] = 0.24;	//reaction 'ENO_c':  kinetic parameter 'ENO_c_KmPEP'
p[55] = 1774.68;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_Vmax'
p[56] = 759;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_Keq'
p[57] = 0.1;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_KmGlc'
p[58] = 0.116;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_KmATP'
p[59] = 2.7;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_KmGlc6P'
p[60] = 0.126;	//reaction 'HXK_g':  kinetic parameter 'HXK_g_KmADP'
p[61] = 250;	//reaction '_3PGAT_g':  kinetic parameter '_3PGAT_g_k'
p[62] = 2;	//reaction 'NADPHu_c':  kinetic parameter 'NADPHu_c_k'
p[63] = 154.32;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_Vmax'
p[64] = 759;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_Keq'
p[65] = 0.1;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_KmGlc'
p[66] = 0.116;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_KmATP'
p[67] = 2.7;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_KmGlc6P'
p[68] = 0.126;	//reaction 'HXK_c':  kinetic parameter 'HXK_c_KmADP'
p[69] = 2;	//reaction 'NADPHu_g':  kinetic parameter 'NADPHu_g_k'
p[70] = 480;	//reaction 'AK_c':  kinetic parameter 'AK_c_k1'
p[71] = 1000;	//reaction 'AK_c':  kinetic parameter 'AK_c_k2'
p[72] = 28;	//reaction 'G6PP_c':  kinetic parameter 'G6PP_c_Vmax'
p[73] = 263;	//reaction 'G6PP_c':  kinetic parameter 'G6PP_c_Keq'
p[74] = 5.6;	//reaction 'G6PP_c':  kinetic parameter 'G6PP_c_KmGlc6P'
p[75] = 5.6;	//reaction 'G6PP_c':  kinetic parameter 'G6PP_c_KmGlc'
p[76] = 10.6;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_Vmax'
p[77] = 47;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_Keq'
p[78] = 0.0035;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_Km6PG'
p[79] = 0.001;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_KmNADP'
p[80] = 0.03;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_KmRul5P'
p[81] = 0.0006;	//reaction '_6PGDH_g':  kinetic parameter '_6PGDH_g_KmNADPH'
p[82] = 1305;	//reaction 'PGI_g':  kinetic parameter 'PGI_g_Vmax'
p[83] = 0.4;	//reaction 'PGI_g':  kinetic parameter 'PGI_g_KmGlc6P'
p[84] = 0.457;	//reaction 'PGI_g':  kinetic parameter 'PGI_g_Keq'
p[85] = 0.12;	//reaction 'PGI_g':  kinetic parameter 'PGI_g_KmFru6P'
p[86] = 0.14;	//reaction 'PGI_g':  kinetic parameter 'PGI_g_Ki6PG'
p[87] = 480;	//reaction 'AK_g':  kinetic parameter 'AK_g_k1'
p[88] = 1000;	//reaction 'AK_g':  kinetic parameter 'AK_g_k2'
p[89] = 2;	//reaction 'TOX_c':  kinetic parameter 'TOX_c_k'
p[90] = 600;	//reaction 'GDA_g':  kinetic parameter 'GDA_g_k'
p[91] = 28;	//reaction 'PGL_c':  kinetic parameter 'PGL_c_Vmax'
p[92] = 20000;	//reaction 'PGL_c':  kinetic parameter 'PGL_c_Keq'
p[93] = 0.05;	//reaction 'PGL_c':  kinetic parameter 'PGL_c_Km6PGL'
p[94] = 0.05;	//reaction 'PGL_c':  kinetic parameter 'PGL_c_Km6PG'
p[95] = 0.055;	//reaction 'PGL_c':  kinetic parameter 'PGL_c_k'
p[96] = 10.6;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_Vmax'
p[97] = 47;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_Keq'
p[98] = 0.0035;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_Km6PG'
p[99] = 0.001;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_KmNADP'
p[100] = 0.03;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_KmRul5P'
p[101] = 0.0006;	//reaction '_6PGDH_c':  kinetic parameter '_6PGDH_c_KmNADPH'
p[102] = 72;	//reaction 'PPI_c':  kinetic parameter 'PPI_c_Vmax'
p[103] = 5.6;	//reaction 'PPI_c':  kinetic parameter 'PPI_c_Keq'
p[104] = 1.4;	//reaction 'PPI_c':  kinetic parameter 'PPI_c_KmRul5P'
p[105] = 4;	//reaction 'PPI_c':  kinetic parameter 'PPI_c_KmRib5P'
p[106] = 72;	//reaction 'PPI_g':  kinetic parameter 'PPI_g_Vmax'
p[107] = 5.6;	//reaction 'PPI_g':  kinetic parameter 'PPI_g_Keq'
p[108] = 1.4;	//reaction 'PPI_g':  kinetic parameter 'PPI_g_KmRul5P'
p[109] = 4;	//reaction 'PPI_g':  kinetic parameter 'PPI_g_KmRib5P'
p[110] = 250000;	//reaction 'GlcT_g':  kinetic parameter 'k1'
p[111] = 250000;	//reaction 'GlcT_g':  kinetic parameter 'k2'
p[112] = 111.7;	//reaction 'GlcT_c':  kinetic parameter 'GlcT_c_Vmax'
p[113] = 1;	//reaction 'GlcT_c':  kinetic parameter 'GlcT_c_KmGlc'
p[114] = 0.75;	//reaction 'GlcT_c':  kinetic parameter 'GlcT_c_alpha'
p[115] = 5;	//reaction 'PGL_g':  kinetic parameter 'PGL_g_Vmax'
p[116] = 20000;	//reaction 'PGL_g':  kinetic parameter 'PGL_g_Keq'
p[117] = 0.05;	//reaction 'PGL_g':  kinetic parameter 'PGL_g_Km6PGL'
p[118] = 0.05;	//reaction 'PGL_g':  kinetic parameter 'PGL_g_Km6PG'
p[119] = 0.055;	//reaction 'PGL_g':  kinetic parameter 'PGL_g_k'
p[120] = 252;	//reaction 'TR_c':  kinetic parameter 'TR_c_Vmax'
p[121] = 434;	//reaction 'TR_c':  kinetic parameter 'TR_c_Keq'
p[122] = 0.0069;	//reaction 'TR_c':  kinetic parameter 'TR_c_KmTS2'
p[123] = 0.00077;	//reaction 'TR_c':  kinetic parameter 'TR_c_KmNADPH'
p[124] = 0.0018;	//reaction 'TR_c':  kinetic parameter 'TR_c_KmTSH2'
p[125] = 0.081;	//reaction 'TR_c':  kinetic parameter 'TR_c_KmNADP'
p[126] = 2862;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_Vmax'
p[127] = 3377;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_Keq'
p[128] = 0.003;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_Km13BPGA'
p[129] = 0.1;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_KmADP'
p[130] = 1.62;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_Km3PGA'
p[131] = 0.29;	//reaction 'PGK_g':  kinetic parameter 'PGK_g_KmATP'
p[132] = 465;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_Vmax'
p[133] = 17085;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_Keq'
p[134] = 0.1;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_KmDHAP'
p[135] = 0.01;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_KmNADH'
p[136] = 2;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_KmGly3P'
p[137] = 0.4;	//reaction 'G3PDH_g':  kinetic parameter 'G3PDH_g_KmNAD'
p[138] = 50;	//reaction 'ATPu_c':  kinetic parameter 'ATPu_c_k'
p[139] = 200;	//reaction 'GK_g':  kinetic parameter 'GK_g_Vmax'
p[140] = 0.000837;	//reaction 'GK_g':  kinetic parameter 'GK_g_Keq'
p[141] = 3.83;	//reaction 'GK_g':  kinetic parameter 'GK_g_KmGly3P'
p[142] = 0.56;	//reaction 'GK_g':  kinetic parameter 'GK_g_KmADP'
p[143] = 0.44;	//reaction 'GK_g':  kinetic parameter 'GK_g_KmGly'
p[144] = 0.24;	//reaction 'GK_g':  kinetic parameter 'GK_g_KmATP'
p[145] = 560;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_Vmax'
p[146] = 0.009;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KmFru16BP'
p[147] = 0.68;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KiATP'
p[148] = 1.51;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KiADP'
p[149] = 3.65;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KiAMP'
p[150] = 0.084;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_Keq'
p[151] = 0.067;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KmGA3P'
p[152] = 0.015;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KmDHAP'
p[153] = 0.098;	//reaction 'ALD_g':  kinetic parameter 'ALD_g_KiGA3P'
p[154] = 720.9;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_Vmax'
p[155] = 0.066;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_Keq'
p[156] = 0.15;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_KmGA3P'
p[157] = 0.45;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_KmNAD'
p[158] = 0.1;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_Km13BPGA'
p[159] = 0.02;	//reaction 'GAPDH_g':  kinetic parameter 'GAPDH_g_KmNADH'
p[160] = 368;	//reaction 'GPO_c':  kinetic parameter 'GPO_c_Vmax'
p[161] = 1.7;	//reaction 'GPO_c':  kinetic parameter 'GPO_c_KmGly3P'
#endif /* FIXED */

#ifdef ASSIGNMENT
y[0] = ct[0]-x[11];	//metabolite 'TS2_c': reactions
y[1] = ct[1]-x[22];	//metabolite 'NADH_g': reactions
y[2] = ct[2]-x[0]-1*x[29];	//metabolite 'AMP_g': reactions
y[3] = ct[3]-x[15];	//metabolite 'DHAP_c': reactions
y[4] = ct[4]-x[1]-x[27];	//metabolite 'AMP_c': reactions
y[5] = ct[5]-x[2];	//metabolite 'NADPH_c': reactions
y[6] = ct[6]-x[5];	//metabolite 'NADPH_g': reactions
x_c[0] = x[0]/p[10];	//concentration of metabolite 'ADP_g': reactions
x_c[1] = x[1]/p[9];	//concentration of metabolite 'ADP_c': reactions
x_c[2] = x[2]/p[9];	//concentration of metabolite 'NADP_c': reactions
x_c[3] = x[3]/p[10];	//concentration of metabolite 'DHAP_g': reactions
x_c[4] = x[4]/p[9];	//concentration of metabolite 'Glc_c': reactions
x_c[5] = x[5]/p[10];	//concentration of metabolite 'NADP_g': reactions
x_c[6] = x[6]/p[10];	//concentration of metabolite 'GA3P_g': reactions
x_c[7] = x[7]/p[10];	//concentration of metabolite 'Glc6P_g': reactions
x_c[8] = x[8]/p[9];	//concentration of metabolite '_3PGA_c': reactions
x_c[9] = x[9]/p[10];	//concentration of metabolite 'Gly3P_g': reactions
x_c[10] = x[10]/p[9];	//concentration of metabolite 'Pyr_c': reactions
x_c[11] = x[11]/p[9];	//concentration of metabolite 'TSH2_c': reactions
x_c[12] = x[12]/p[9];	//concentration of metabolite '_6PGL_c': reactions
x_c[13] = x[13]/p[9];	//concentration of metabolite 'Rul5P_c': reactions
x_c[14] = x[14]/p[10];	//concentration of metabolite '_6PG_g': reactions
x_c[15] = x[15]/p[9];	//concentration of metabolite 'Gly3P_c': reactions
x_c[16] = x[16]/p[10];	//concentration of metabolite 'Fru6P_g': reactions
x_c[17] = x[17]/p[10];	//concentration of metabolite '_13BPGA_g': reactions
x_c[18] = x[18]/p[9];	//concentration of metabolite '_2PGA_c': reactions
x_c[19] = x[19]/p[10];	//concentration of metabolite 'Rul5P_g': reactions
x_c[20] = x[20]/p[9];	//concentration of metabolite 'Glc6P_c': reactions
x_c[21] = x[21]/p[10];	//concentration of metabolite 'Glc_g': reactions
x_c[22] = x[22]/p[10];	//concentration of metabolite 'NAD_g': reactions
x_c[23] = x[23]/p[9];	//concentration of metabolite 'PEP_c': reactions
x_c[24] = x[24]/p[10];	//concentration of metabolite '_6PGL_g': reactions
x_c[25] = x[25]/p[9];	//concentration of metabolite '_6PG_c': reactions
x_c[26] = x[26]/p[10];	//concentration of metabolite '_3PGA_g': reactions
x_c[27] = x[27]/p[9];	//concentration of metabolite 'ATP_c': reactions
x_c[28] = x[28]/p[10];	//concentration of metabolite 'Fru16BP_g': reactions
x_c[29] = x[29]/p[10];	//concentration of metabolite 'ATP_g': reactions
y_c[0] = y[0]/p[9];	//concentration of metabolite 'TS2_c': reactions
y_c[1] = y[1]/p[10];	//concentration of metabolite 'NADH_g': reactions
y_c[2] = y[2]/p[10];	//concentration of metabolite 'AMP_g': reactions
y_c[3] = y[3]/p[9];	//concentration of metabolite 'DHAP_c': reactions
y_c[4] = y[4]/p[9];	//concentration of metabolite 'AMP_c': reactions
y_c[5] = y[5]/p[9];	//concentration of metabolite 'NADPH_c': reactions
y_c[6] = y[6]/p[10];	//concentration of metabolite 'NADPH_g': reactions
p_c[0] = p[0]/p[9];	//concentration of metabolite 'CO2_c': fixed
p_c[1] = p[1]/p[9];	//concentration of metabolite 'Rib5P_c': fixed
p_c[2] = p[2]/p[10];	//concentration of metabolite 'Pi_g': fixed
p_c[3] = p[3]/p[10];	//concentration of metabolite 'Rib5P_g': fixed
p_c[4] = p[4]/p[10];	//concentration of metabolite 'CO2_g': fixed
p_c[5] = p[5]/p[11];	//concentration of metabolite 'O2_c': fixed
p_c[6] = p[6]/p[11];	//concentration of metabolite 'Glc_e': fixed
p_c[7] = p[7]/p[11];	//concentration of metabolite 'Pyr_e': fixed
p_c[8] = p[8]/p[11];	//concentration of metabolite 'Gly_e': fixed
#endif /* ASSIGNMENT */

#ifdef FUNCTIONS_HEADERS
double v1sub1prod(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4, double varb_5); 
double FunctionForTPI_g(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double volume_0); 
double FunctionForPYK_c(double sub_0, double prod_0, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double param_8, double prod_1, double volume_0); 
double FunctionForPFK_g(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double volume_0); 
double v2sub2prod(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4, double varb_5, double varb_6, double varb_7, double varb_8, double varb_9); 
double FunctionForG6PDH_g(double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_0, double prod_0, double sub_1, double prod_1, double volume_0); 
double FunctionForPGAM_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0); 
double v1sub_1(double param_0, double param_1, double sub_0); 
double FunctionForG6PDH_c(double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_0, double prod_0, double sub_1, double prod_1, double volume_0); 
double FunctionForENO_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0); 
double FunctionForHXK_g(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double volume_0); 
double mass_action_rev_1(double param_0, double prod_0, double sub_0); 
double mass_action_irrev(double varb_0, double varb_1); 
double FunctionForNADPHu_c(double sub_0, double param_0, double volume_0); 
double FunctionForHXK_c(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double volume_0); 
double FunctionForNADPHu_g(double sub_0, double param_0, double volume_0); 
double vAK(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4); 
double FunctionForAK_c(double sub_0, double param_0, double param_1, double prod_0, double prod_1, double volume_0); 
double FunctionForG6PP_c(double param_0, double param_1, double param_2, double param_3, double sub_0, double prod_0, double volume_0); 
double FunctionFor_6PGDH_g(double prod_0, double sub_0, double prod_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double volume_0); 
double FunctionForPGI_g(double prod_0, double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double modif_0, double volume_0); 
double FunctionForAK_g(double sub_0, double param_0, double param_1, double prod_0, double prod_1, double volume_0); 
double FunctionForTOX_c(double param_0, double sub_0, double volume_0); 
double FunctionForGDA_g(double sub_0, double prod_0, double param_0, double prod_1, double sub_1); 
double FunctionForPGL_c(double param_0, double param_1, double param_2, double param_3, double param_4, double sub_0, double prod_0, double volume_0); 
double FunctionFor_6PGDH_c(double prod_0, double sub_0, double prod_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double volume_0); 
double FunctionForPPI_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0); 
double FunctionForPPI_g(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0); 
double FunctionForGlcT_c(double param_0, double param_1, double param_2, double prod_0, double sub_0); 
double FunctionForPGL_g(double param_0, double param_1, double param_2, double param_3, double param_4, double sub_0, double prod_0, double volume_0); 
double FunctionForTR_c(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1, double volume_0); 
double FunctionForPGK_g(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1, double volume_0); 
double FunctionForG3PDH_g(double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double prod_0, double sub_1, double prod_1, double volume_0); 
double FunctionForATPu_c(double prod_0, double sub_0, double param_0, double volume_0); 
double v2sub2prod_1(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1); 
double FunctionForALD_g(double modif_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double param_8, double modif_1, double modif_2, double prod_0, double sub_0, double prod_1, double volume_0); 
double FunctionForGAPDH_g(double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double prod_0, double sub_1, double prod_1, double volume_0); 
double v1sub(double varb_0, double varb_1, double varb_2); 
double FunctionForGPO_c(double param_0, double param_1, double sub_0, double volume_0); 
#endif /* FUNCTIONS_HEADERS */

#ifdef FUNCTIONS
double v1sub1prod(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4, double varb_5) 	//v1sub1prod
{return  varb_0*varb_2*(1.00000000000000000-varb_4/(varb_1*varb_2))/(varb_3*(1.00000000000000000+varb_2/varb_3+varb_4/varb_5));} 
double FunctionForTPI_g(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double volume_0) 	//Function for TPI_g
{return  v1sub1prod(param_3,param_0,sub_0,param_1,prod_0,param_2)/volume_0;} 
double FunctionForPYK_c(double sub_0, double prod_0, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double param_8, double prod_1, double volume_0) 	//Function for PYK_c
{return  param_7*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0))*pow((sub_1/(param_5*(1.00000000000000000+sub_0/param_1+prod_0/param_2))),param_8)/(param_3*(1.00000000000000000+pow((sub_1/(param_5*(1.00000000000000000+sub_0/param_1+prod_0/param_2))),param_8)+prod_1/param_6)*(1.00000000000000000+sub_0/param_3+prod_0/param_4))/volume_0;} 
double FunctionForPFK_g(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double volume_0) 	//Function for PFK_g
{return  param_7*param_1*sub_1*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0))/(param_5*param_4*(prod_1+param_1)*(param_6/param_4+sub_1/param_5+sub_0/param_4+prod_0/param_3+prod_1*prod_0/(param_3*param_2)+sub_1*sub_0/(param_5*param_4)))/volume_0;} 
double v2sub2prod(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4, double varb_5, double varb_6, double varb_7, double varb_8, double varb_9) 	//v2sub2prod
{return  varb_0*varb_2*varb_4*(1.00000000000000000-varb_6*varb_8/(varb_1*varb_2*varb_4))/(varb_3*varb_5*(1.00000000000000000+varb_2/varb_3+varb_6/varb_7)*(1.00000000000000000+varb_4/varb_5+varb_8/varb_9));} 
double FunctionForG6PDH_g(double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_0, double prod_0, double sub_1, double prod_1, double volume_0) 	//Function for G6PDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
double FunctionForPGAM_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0) 	//Function for PGAM_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
double v1sub_1(double param_0, double param_1, double sub_0) 	//v1sub_1
{return  param_1*sub_0/(param_0*(1.00000000000000000+sub_0/param_0));} 
double FunctionForG6PDH_c(double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_0, double prod_0, double sub_1, double prod_1, double volume_0) 	//Function for G6PDH_c
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
double FunctionForENO_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0) 	//Function for ENO_c
{return  v1sub1prod(param_3,param_0,sub_0,param_1,prod_0,param_2)/volume_0;} 
double FunctionForHXK_g(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double volume_0) 	//Function for HXK_g
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
double mass_action_rev_1(double param_0, double prod_0, double sub_0) 	//mass_action_rev_1
{return  param_0*sub_0-param_0*prod_0;} 
double mass_action_irrev(double varb_0, double varb_1) 	//mass_action_irrev
{return  varb_0*varb_1;} 
double FunctionForNADPHu_c(double sub_0, double param_0, double volume_0) 	//Function for NADPHu_c
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
double FunctionForHXK_c(double prod_0, double sub_0, double prod_1, double sub_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double volume_0) 	//Function for HXK_c
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
double FunctionForNADPHu_g(double sub_0, double param_0, double volume_0) 	//Function for NADPHu_g
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
double vAK(double varb_0, double varb_1, double varb_2, double varb_3, double varb_4) 	//vAK
{return  varb_3*pow(varb_0,2.00000000000000000)-varb_1*varb_2*varb_4;} 
double FunctionForAK_c(double sub_0, double param_0, double param_1, double prod_0, double prod_1, double volume_0) 	//Function for AK_c
{return  vAK(sub_0,prod_0,prod_1,param_0,param_1)/volume_0;} 
double FunctionForG6PP_c(double param_0, double param_1, double param_2, double param_3, double sub_0, double prod_0, double volume_0) 	//Function for G6PP_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
double FunctionFor_6PGDH_g(double prod_0, double sub_0, double prod_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double volume_0) 	//Function for _6PGDH_g
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_2,prod_1,param_4,prod_0,param_3)/volume_0;} 
double FunctionForPGI_g(double prod_0, double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double modif_0, double volume_0) 	//Function for PGI_g
{return  param_4*sub_0*(1.00000000000000000-prod_0/(param_0*sub_0))/(param_3*(1.00000000000000000+sub_0/param_3+prod_0/param_2+modif_0/param_1))/volume_0;} 
double FunctionForAK_g(double sub_0, double param_0, double param_1, double prod_0, double prod_1, double volume_0) 	//Function for AK_g
{return  vAK(sub_0,prod_0,prod_1,param_0,param_1)/volume_0;} 
double FunctionForTOX_c(double param_0, double sub_0, double volume_0) 	//Function for TOX_c
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
double FunctionForGDA_g(double sub_0, double prod_0, double param_0, double prod_1, double sub_1) 	//Function for GDA_g
{return  sub_1*param_0*sub_0-prod_1*param_0*prod_0;} 
double FunctionForPGL_c(double param_0, double param_1, double param_2, double param_3, double param_4, double sub_0, double prod_0, double volume_0) 	//Function for PGL_c
{return  (param_4*volume_0*(sub_0-prod_0/param_0)+v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1))/volume_0;} 
double FunctionFor_6PGDH_c(double prod_0, double sub_0, double prod_1, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double volume_0) 	//Function for _6PGDH_c
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_2,prod_1,param_4,prod_0,param_3)/volume_0;} 
double FunctionForPPI_c(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0) 	//Function for PPI_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
double FunctionForPPI_g(double param_0, double param_1, double param_2, double param_3, double prod_0, double sub_0, double volume_0) 	//Function for PPI_g
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
double FunctionForGlcT_c(double param_0, double param_1, double param_2, double prod_0, double sub_0) 	//Function for GlcT_c
{return  param_1*(sub_0-prod_0)/(param_0+sub_0+prod_0+param_2*sub_0*prod_0/param_0);} 
double FunctionForPGL_g(double param_0, double param_1, double param_2, double param_3, double param_4, double sub_0, double prod_0, double volume_0) 	//Function for PGL_g
{return  (volume_0*param_4*(sub_0-prod_0/param_0)+v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1))/volume_0;} 
double FunctionForTR_c(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1, double volume_0) 	//Function for TR_c
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
double FunctionForPGK_g(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1, double volume_0) 	//Function for PGK_g
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_3,prod_1,param_2,prod_0,param_4)/volume_0;} 
double FunctionForG3PDH_g(double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double prod_0, double sub_1, double prod_1, double volume_0) 	//Function for G3PDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_1,sub_1,param_4,prod_0,param_2,prod_1,param_3)/volume_0;} 
double FunctionForATPu_c(double prod_0, double sub_0, double param_0, double volume_0) 	//Function for ATPu_c
{return  param_0*sub_0/prod_0/volume_0;} 
double v2sub2prod_1(double sub_0, double prod_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double sub_1, double prod_1) 	//v2sub2prod_1
{return  param_5*sub_1*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0))/(param_4*param_1*(1.00000000000000000+sub_1/param_4+prod_1/param_3)*(1.00000000000000000+sub_0/param_1+prod_0/param_2));} 
double FunctionForALD_g(double modif_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double param_6, double param_7, double param_8, double modif_1, double modif_2, double prod_0, double sub_0, double prod_1, double volume_0) 	//Function for ALD_g
{return  param_8*sub_0*(1.00000000000000000-prod_1*prod_0/(sub_0*param_0))/(param_6*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2)*(1.00000000000000000+prod_1/param_7+prod_0/param_5+sub_0/(param_6*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2))+prod_1*prod_0/(param_7*param_5)+sub_0*prod_1/(param_6*param_4*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2))))/volume_0;} 
double FunctionForGAPDH_g(double sub_0, double param_0, double param_1, double param_2, double param_3, double param_4, double param_5, double prod_0, double sub_1, double prod_1, double volume_0) 	//Function for GAPDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
double v1sub(double varb_0, double varb_1, double varb_2) 	//v1sub
{return  varb_0*varb_1/(varb_2*(1.00000000000000000+varb_1/varb_2));} 
double FunctionForGPO_c(double param_0, double param_1, double sub_0, double volume_0) 	//Function for GPO_c
{return  v1sub(param_1,sub_0,param_0)/volume_0;} 
#endif /* FUNCTIONS */

#ifdef ODEs
dx[0] = FunctionForPFK_g(x_c[0], x_c[29], x_c[28], x_c[16], p[29], p[26], p[32], p[31], p[28], p[27], p[30], p[25], p[10])*p[10]+FunctionForHXK_g(x_c[0], x_c[29], x_c[7], x_c[21], p[56], p[60], p[58], p[57], p[59], p[55], p[10])*p[10]-2*FunctionForAK_g(x_c[0], p[87], p[88], y_c[2], x_c[29], p[10])*p[10]-FunctionForPGK_g(x_c[0], x_c[29], p[127], p[128], p[130], p[129], p[131], p[126], x_c[17], x_c[26], p[10])*p[10]-v2sub2prod_1(x_c[0], x_c[29], p[140], p[142], p[144], p[143], p[141], p[139], x_c[9], p_c[8]);
dx[1] = -FunctionForPYK_c(x_c[1], x_c[27], x_c[23], p[22], p[19], p[18], p[21], p[24], p[17], p[23], p[16], p[20], x_c[10], p[9])*p[9]+FunctionForHXK_c(x_c[1], x_c[27], x_c[20], x_c[4], p[64], p[68], p[66], p[65], p[67], p[63], p[9])*p[9]-2*FunctionForAK_c(x_c[1], p[70], p[71], y_c[4], x_c[27], p[9])*p[9]+FunctionForATPu_c(x_c[1], x_c[27], p[138], p[9])*p[9];
dx[2] = -FunctionForG6PDH_c(p[46], p[49], p[47], p[48], p[50], p[45], x_c[20], y_c[5], x_c[2], x_c[12], p[9])*p[9]+FunctionForNADPHu_c(y_c[5], p[62], p[9])*p[9]-FunctionFor_6PGDH_c(y_c[5], x_c[2], x_c[13], p[97], p[98], p[99], p[101], p[100], p[96], x_c[25], p[9])*p[9]+FunctionForTR_c(y_c[5], x_c[2], p[121], p[125], p[123], p[122], p[124], p[120], y_c[0], x_c[11], p[9])*p[9];
dx[3] = -FunctionForTPI_g(x_c[3], x_c[6], p[13], p[14], p[15], p[12], p[10])*p[10]+FunctionForGDA_g(y_c[3], x_c[3], p[90], x_c[15], x_c[9])-FunctionForG3PDH_g(x_c[3], p[133], p[134], p[136], p[137], p[135], p[132], x_c[9], y_c[1], x_c[22], p[10])*p[10]+FunctionForALD_g(x_c[0], p[150], p[148], p[149], p[147], p[153], p[152], p[146], p[151], p[145], y_c[2], x_c[29], x_c[3], x_c[28], x_c[6], p[10])*p[10];
dx[4] = -FunctionForHXK_c(x_c[1], x_c[27], x_c[20], x_c[4], p[64], p[68], p[66], p[65], p[67], p[63], p[9])*p[9]+FunctionForG6PP_c(p[73], p[75], p[74], p[72], x_c[20], x_c[4], p[9])*p[9]-(p[110] * x_c[4] - p[111] * x_c[21]) +FunctionForGlcT_c(p[113], p[112], p[114], x_c[4], p_c[6]);
dx[5] = -FunctionForG6PDH_g(p[34], p[37], p[35], p[36], p[38], p[33], x_c[7], y_c[6], x_c[5], x_c[24], p[10])*p[10]+FunctionForNADPHu_g(y_c[6], p[69], p[10])*p[10]-FunctionFor_6PGDH_g(y_c[6], x_c[5], x_c[19], p[77], p[78], p[79], p[81], p[80], p[76], x_c[14], p[10])*p[10];
dx[6] = FunctionForTPI_g(x_c[3], x_c[6], p[13], p[14], p[15], p[12], p[10])*p[10]+FunctionForALD_g(x_c[0], p[150], p[148], p[149], p[147], p[153], p[152], p[146], p[151], p[145], y_c[2], x_c[29], x_c[3], x_c[28], x_c[6], p[10])*p[10]-FunctionForGAPDH_g(x_c[6], p[155], p[158], p[156], p[157], p[159], p[154], y_c[1], x_c[22], x_c[17], p[10])*p[10];
dx[7] = -FunctionForG6PDH_g(p[34], p[37], p[35], p[36], p[38], p[33], x_c[7], y_c[6], x_c[5], x_c[24], p[10])*p[10]+FunctionForHXK_g(x_c[0], x_c[29], x_c[7], x_c[21], p[56], p[60], p[58], p[57], p[59], p[55], p[10])*p[10]-FunctionForPGI_g(x_c[16], x_c[7], p[84], p[86], p[85], p[83], p[82], x_c[14], p[10])*p[10];
dx[8] = -FunctionForPGAM_c(p[40], p[42], p[41], p[39], x_c[18], x_c[8], p[9])*p[9]+mass_action_rev_1(p[61], x_c[8], x_c[26]);
dx[9] = -FunctionForGDA_g(y_c[3], x_c[3], p[90], x_c[15], x_c[9])+FunctionForG3PDH_g(x_c[3], p[133], p[134], p[136], p[137], p[135], p[132], x_c[9], y_c[1], x_c[22], p[10])*p[10]-v2sub2prod_1(x_c[0], x_c[29], p[140], p[142], p[144], p[143], p[141], p[139], x_c[9], p_c[8]);
dx[10] = FunctionForPYK_c(x_c[1], x_c[27], x_c[23], p[22], p[19], p[18], p[21], p[24], p[17], p[23], p[16], p[20], x_c[10], p[9])*p[9]-v1sub_1(p[44], p[43], x_c[10]);
dx[11] = -FunctionForTOX_c(p[89], x_c[11], p[9])*p[9]+FunctionForTR_c(y_c[5], x_c[2], p[121], p[125], p[123], p[122], p[124], p[120], y_c[0], x_c[11], p[9])*p[9];
dx[12] = FunctionForG6PDH_c(p[46], p[49], p[47], p[48], p[50], p[45], x_c[20], y_c[5], x_c[2], x_c[12], p[9])*p[9]-FunctionForPGL_c(p[92], p[94], p[93], p[91], p[95], x_c[12], x_c[25], p[9])*p[9];
dx[13] = FunctionFor_6PGDH_c(y_c[5], x_c[2], x_c[13], p[97], p[98], p[99], p[101], p[100], p[96], x_c[25], p[9])*p[9]-FunctionForPPI_c(p[103], p[105], p[104], p[102], p_c[1], x_c[13], p[9])*p[9];
dx[14] = -FunctionFor_6PGDH_g(y_c[6], x_c[5], x_c[19], p[77], p[78], p[79], p[81], p[80], p[76], x_c[14], p[10])*p[10]+FunctionForPGL_g(p[116], p[118], p[117], p[115], p[119], x_c[24], x_c[14], p[10])*p[10];
dx[15] = FunctionForGDA_g(y_c[3], x_c[3], p[90], x_c[15], x_c[9])-FunctionForGPO_c(p[161], p[160], x_c[15], p[9])*p[9];
dx[16] = -FunctionForPFK_g(x_c[0], x_c[29], x_c[28], x_c[16], p[29], p[26], p[32], p[31], p[28], p[27], p[30], p[25], p[10])*p[10]+FunctionForPGI_g(x_c[16], x_c[7], p[84], p[86], p[85], p[83], p[82], x_c[14], p[10])*p[10];
dx[17] = -FunctionForPGK_g(x_c[0], x_c[29], p[127], p[128], p[130], p[129], p[131], p[126], x_c[17], x_c[26], p[10])*p[10]+FunctionForGAPDH_g(x_c[6], p[155], p[158], p[156], p[157], p[159], p[154], y_c[1], x_c[22], x_c[17], p[10])*p[10];
dx[18] = FunctionForPGAM_c(p[40], p[42], p[41], p[39], x_c[18], x_c[8], p[9])*p[9]-FunctionForENO_c(p[52], p[53], p[54], p[51], x_c[23], x_c[18], p[9])*p[9];
dx[19] = FunctionFor_6PGDH_g(y_c[6], x_c[5], x_c[19], p[77], p[78], p[79], p[81], p[80], p[76], x_c[14], p[10])*p[10]-FunctionForPPI_g(p[107], p[109], p[108], p[106], p_c[3], x_c[19], p[10])*p[10];
dx[20] = -FunctionForG6PDH_c(p[46], p[49], p[47], p[48], p[50], p[45], x_c[20], y_c[5], x_c[2], x_c[12], p[9])*p[9]+FunctionForHXK_c(x_c[1], x_c[27], x_c[20], x_c[4], p[64], p[68], p[66], p[65], p[67], p[63], p[9])*p[9]-FunctionForG6PP_c(p[73], p[75], p[74], p[72], x_c[20], x_c[4], p[9])*p[9];
dx[21] = -FunctionForHXK_g(x_c[0], x_c[29], x_c[7], x_c[21], p[56], p[60], p[58], p[57], p[59], p[55], p[10])*p[10]+(p[110] * x_c[4] - p[111] * x_c[21]) ;
dx[22] = FunctionForG3PDH_g(x_c[3], p[133], p[134], p[136], p[137], p[135], p[132], x_c[9], y_c[1], x_c[22], p[10])*p[10]-FunctionForGAPDH_g(x_c[6], p[155], p[158], p[156], p[157], p[159], p[154], y_c[1], x_c[22], x_c[17], p[10])*p[10];
dx[23] = -FunctionForPYK_c(x_c[1], x_c[27], x_c[23], p[22], p[19], p[18], p[21], p[24], p[17], p[23], p[16], p[20], x_c[10], p[9])*p[9]+FunctionForENO_c(p[52], p[53], p[54], p[51], x_c[23], x_c[18], p[9])*p[9];
dx[24] = FunctionForG6PDH_g(p[34], p[37], p[35], p[36], p[38], p[33], x_c[7], y_c[6], x_c[5], x_c[24], p[10])*p[10]-FunctionForPGL_g(p[116], p[118], p[117], p[115], p[119], x_c[24], x_c[14], p[10])*p[10];
dx[25] = FunctionForPGL_c(p[92], p[94], p[93], p[91], p[95], x_c[12], x_c[25], p[9])*p[9]-FunctionFor_6PGDH_c(y_c[5], x_c[2], x_c[13], p[97], p[98], p[99], p[101], p[100], p[96], x_c[25], p[9])*p[9];
dx[26] = -mass_action_rev_1(p[61], x_c[8], x_c[26])+FunctionForPGK_g(x_c[0], x_c[29], p[127], p[128], p[130], p[129], p[131], p[126], x_c[17], x_c[26], p[10])*p[10];
dx[27] = FunctionForPYK_c(x_c[1], x_c[27], x_c[23], p[22], p[19], p[18], p[21], p[24], p[17], p[23], p[16], p[20], x_c[10], p[9])*p[9]-FunctionForHXK_c(x_c[1], x_c[27], x_c[20], x_c[4], p[64], p[68], p[66], p[65], p[67], p[63], p[9])*p[9]+FunctionForAK_c(x_c[1], p[70], p[71], y_c[4], x_c[27], p[9])*p[9]-FunctionForATPu_c(x_c[1], x_c[27], p[138], p[9])*p[9];
dx[28] = FunctionForPFK_g(x_c[0], x_c[29], x_c[28], x_c[16], p[29], p[26], p[32], p[31], p[28], p[27], p[30], p[25], p[10])*p[10]-FunctionForALD_g(x_c[0], p[150], p[148], p[149], p[147], p[153], p[152], p[146], p[151], p[145], y_c[2], x_c[29], x_c[3], x_c[28], x_c[6], p[10])*p[10];
dx[29] = -FunctionForPFK_g(x_c[0], x_c[29], x_c[28], x_c[16], p[29], p[26], p[32], p[31], p[28], p[27], p[30], p[25], p[10])*p[10]-FunctionForHXK_g(x_c[0], x_c[29], x_c[7], x_c[21], p[56], p[60], p[58], p[57], p[59], p[55], p[10])*p[10]+FunctionForAK_g(x_c[0], p[87], p[88], y_c[2], x_c[29], p[10])*p[10]+FunctionForPGK_g(x_c[0], x_c[29], p[127], p[128], p[130], p[129], p[131], p[126], x_c[17], x_c[26], p[10])*p[10]+v2sub2prod_1(x_c[0], x_c[29], p[140], p[142], p[144], p[143], p[141], p[139], x_c[9], p_c[8]);
#endif /* ODEs */
