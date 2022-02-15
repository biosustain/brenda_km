#include functions.stan
vector dxdt(real time, vector x, vector ct, vector p){
  vector[7] y;
  vector[30] x_c;
  vector[7] y_c;
  vector[9] p_c;
  vector[30] out;
  y[1] = ct[1]-x[12];	//metabolite 'TS2_c': reactions
  y[2] = ct[2]-x[23];	//metabolite 'NADH_g': reactions
  y[3] = ct[3]-x[1]-1*x[30];	//metabolite 'AMP_g': reactions
  y[4] = ct[4]-x[16];	//metabolite 'DHAP_c': reactions
  y[5] = ct[5]-x[2]-x[28];	//metabolite 'AMP_c': reactions
  y[6] = ct[6]-x[3];	//metabolite 'NADPH_c': reactions
  y[7] = ct[7]-x[6];	//metabolite 'NADPH_g': reactions
  x_c[1] = x[1]/p[11];	//concentration of metabolite 'ADP_g': reactions
  x_c[2] = x[2]/p[10];	//concentration of metabolite 'ADP_c': reactions
  x_c[3] = x[3]/p[10];	//concentration of metabolite 'NADP_c': reactions
  x_c[4] = x[4]/p[11];	//concentration of metabolite 'DHAP_g': reactions
  x_c[5] = x[5]/p[10];	//concentration of metabolite 'Glc_c': reactions
  x_c[6] = x[6]/p[11];	//concentration of metabolite 'NADP_g': reactions
  x_c[7] = x[7]/p[11];	//concentration of metabolite 'GA3P_g': reactions
  x_c[8] = x[8]/p[11];	//concentration of metabolite 'Glc6P_g': reactions
  x_c[9] = x[9]/p[10];	//concentration of metabolite '_3PGA_c': reactions
  x_c[10] = x[10]/p[11];	//concentration of metabolite 'Gly3P_g': reactions
  x_c[11] = x[11]/p[10];	//concentration of metabolite 'Pyr_c': reactions
  x_c[12] = x[12]/p[10];	//concentration of metabolite 'TSH2_c': reactions
  x_c[13] = x[13]/p[10];	//concentration of metabolite '_6PGL_c': reactions
  x_c[14] = x[14]/p[10];	//concentration of metabolite 'Rul5P_c': reactions
  x_c[15] = x[15]/p[11];	//concentration of metabolite '_6PG_g': reactions
  x_c[16] = x[16]/p[10];	//concentration of metabolite 'Gly3P_c': reactions
  x_c[17] = x[17]/p[11];	//concentration of metabolite 'Fru6P_g': reactions
  x_c[18] = x[18]/p[11];	//concentration of metabolite '_13BPGA_g': reactions
  x_c[19] = x[19]/p[10];	//concentration of metabolite '_2PGA_c': reactions
  x_c[20] = x[20]/p[11];	//concentration of metabolite 'Rul5P_g': reactions
  x_c[21] = x[21]/p[10];	//concentration of metabolite 'Glc6P_c': reactions
  x_c[22] = x[22]/p[11];	//concentration of metabolite 'Glc_g': reactions
  x_c[23] = x[23]/p[11];	//concentration of metabolite 'NAD_g': reactions
  x_c[24] = x[24]/p[10];	//concentration of metabolite 'PEP_c': reactions
  x_c[25] = x[25]/p[11];	//concentration of metabolite '_6PGL_g': reactions
  x_c[26] = x[26]/p[10];	//concentration of metabolite '_6PG_c': reactions
  x_c[27] = x[27]/p[11];	//concentration of metabolite '_3PGA_g': reactions
  x_c[28] = x[28]/p[10];	//concentration of metabolite 'ATP_c': reactions
  x_c[29] = x[29]/p[11];	//concentration of metabolite 'Fru16BP_g': reactions
  x_c[30] = x[30]/p[11];	//concentration of metabolite 'ATP_g': reactions
  y_c[1] = y[1]/p[10];	//concentration of metabolite 'TS2_c': reactions
  y_c[2] = y[2]/p[11];	//concentration of metabolite 'NADH_g': reactions
  y_c[3] = y[3]/p[11];	//concentration of metabolite 'AMP_g': reactions
  y_c[4] = y[4]/p[10];	//concentration of metabolite 'DHAP_c': reactions
  y_c[5] = y[5]/p[10];	//concentration of metabolite 'AMP_c': reactions
  y_c[6] = y[6]/p[10];	//concentration of metabolite 'NADPH_c': reactions
  y_c[7] = y[7]/p[11];	//concentration of metabolite 'NADPH_g': reactions
  p_c[1] = p[1]/p[10];	//concentration of metabolite 'CO2_c': fixed
  p_c[2] = p[2]/p[10];	//concentration of metabolite 'Rib5P_c': fixed
  p_c[3] = p[3]/p[11];	//concentration of metabolite 'Pi_g': fixed
  p_c[4] = p[4]/p[11];	//concentration of metabolite 'Rib5P_g': fixed
  p_c[5] = p[5]/p[11];	//concentration of metabolite 'CO2_g': fixed
  p_c[6] = p[6]/p[12];	//concentration of metabolite 'O2_c': fixed
  p_c[7] = p[7]/p[12];	//concentration of metabolite 'Glc_e': fixed
  p_c[8] = p[8]/p[12];	//concentration of metabolite 'Pyr_e': fixed
  p_c[9] = p[9]/p[12];	//concentration of metabolite 'Gly_e': fixed

  out[1] = FunctionForPFK_g(x_c[29], x_c[30], x_c[1], x_c[17], p[30], p[27], p[33], p[32], p[29], p[28], p[31], p[26], p[11])*p[11]+FunctionForHXK_g(x_c[1], x_c[30], x_c[8], x_c[22], p[57], p[61], p[59], p[58], p[60], p[56], p[11])*p[11]-2*FunctionForAK_g(x_c[1], p[88], p[89], y_c[3], x_c[30], p[11])*p[11]-FunctionForPGK_g(x_c[1], x_c[30], p[128], p[129], p[131], p[130], p[132], p[127], x_c[18], x_c[27], p[11])*p[11]-v2sub2prod_1(x_c[1], x_c[30], p[141], p[143], p[145], p[144], p[142], p[140], x_c[10], p_c[9]);

  out[2] = -FunctionForPYK_c(x_c[2], x_c[28], x_c[24], p[23], p[20], p[19], p[22], p[25], p[18], p[24], p[17], p[21], x_c[11], p[10])*p[10]+FunctionForHXK_c(x_c[2], x_c[28], x_c[21], x_c[5], p[65], p[69], p[67], p[66], p[68], p[64], p[10])*p[10]-2*FunctionForAK_c(x_c[2], p[71], p[72], y_c[5], x_c[28], p[10])*p[10]+FunctionForATPu_c(x_c[2], x_c[28], p[139], p[10])*p[10];

  out[3] = -FunctionForG6PDH_c(p[47], p[50], p[48], p[49], p[51], p[46], x_c[21], y_c[6], x_c[3], x_c[13], p[10])*p[10]+FunctionForNADPHu_c(y_c[6], p[63], p[10])*p[10]-FunctionFor_6PGDH_c(y_c[6], x_c[3], x_c[14], p[98], p[99], p[100], p[102], p[101], p[97], x_c[26], p[10])*p[10]+FunctionForTR_c(y_c[6], x_c[3], p[122], p[126], p[124], p[123], p[125], p[121], y_c[1], x_c[12], p[10])*p[10];

  out[4] = -FunctionForTPI_g(x_c[4], x_c[7], p[14], p[15], p[16], p[13], p[11])*p[11]+FunctionForGDA_g(y_c[4], x_c[4], p[91], x_c[16], x_c[10])-FunctionForG3PDH_g(x_c[4], p[134], p[135], p[137], p[138], p[136], p[133], x_c[10], y_c[2], x_c[23], p[11])*p[11]+FunctionForALD_g(x_c[1], p[151], p[149], p[150], p[148], p[154], p[153], p[147], p[152], p[146], y_c[3], x_c[30], x_c[4], x_c[29], x_c[7], p[11])*p[11];

  out[5] = -FunctionForHXK_c(x_c[2], x_c[28], x_c[21], x_c[5], p[65], p[69], p[67], p[66], p[68], p[64], p[10])*p[10]+FunctionForG6PP_c(p[74], p[76], p[75], p[73], x_c[21], x_c[5], p[10])*p[10]-(p[111] * x_c[5] - p[112] * x_c[22]) +FunctionForGlcT_c(p[114], p[113], p[115], x_c[5], p_c[7]);

  out[6] = -FunctionForG6PDH_g(p[35], p[38], p[36], p[37], p[39], p[34], x_c[8], y_c[7], x_c[6], x_c[25], p[11])*p[11]+FunctionForNADPHu_g(y_c[7], p[70], p[11])*p[11]-FunctionFor_6PGDH_g(y_c[7], x_c[6], x_c[20], p[78], p[79], p[80], p[82], p[81], p[77], x_c[15], p[11])*p[11];

  out[7] = FunctionForTPI_g(x_c[4], x_c[7], p[14], p[15], p[16], p[13], p[11])*p[11]+FunctionForALD_g(x_c[1], p[151], p[149], p[150], p[148], p[154], p[153], p[147], p[152], p[146], y_c[3], x_c[30], x_c[4], x_c[29], x_c[7], p[11])*p[11]-FunctionForGAPDH_g(x_c[7], p[156], p[159], p[157], p[158], p[160], p[155], y_c[2], x_c[23], x_c[18], p[11])*p[11];

  out[8] = -FunctionForG6PDH_g(p[35], p[38], p[36], p[37], p[39], p[34], x_c[8], y_c[7], x_c[6], x_c[25], p[11])*p[11]+FunctionForHXK_g(x_c[1], x_c[30], x_c[8], x_c[22], p[57], p[61], p[59], p[58], p[60], p[56], p[11])*p[11]-FunctionForPGI_g(x_c[17], x_c[8], p[85], p[87], p[86], p[84], p[83], x_c[15], p[11])*p[11];

  out[9] = -FunctionForPGAM_c(p[41], p[43], p[42], p[40], x_c[19], x_c[9], p[10])*p[10]+mass_action_rev_1(p[62], x_c[9], x_c[27]);

  out[10] = -FunctionForGDA_g(y_c[4], x_c[4], p[91], x_c[16], x_c[10])+FunctionForG3PDH_g(x_c[4], p[134], p[135], p[137], p[138], p[136], p[133], x_c[10], y_c[2], x_c[23], p[11])*p[11]-v2sub2prod_1(x_c[1], x_c[30], p[141], p[143], p[145], p[144], p[142], p[140], x_c[10], p_c[9]);

  out[11] = FunctionForPYK_c(x_c[2], x_c[28], x_c[24], p[23], p[20], p[19], p[22], p[25], p[18], p[24], p[17], p[21], x_c[11], p[10])*p[10]-v1sub_1(p[45], p[44], x_c[11]);

  out[12] = -FunctionForTOX_c(p[90], x_c[12], p[10])*p[10]+FunctionForTR_c(y_c[6], x_c[3], p[122], p[126], p[124], p[123], p[125], p[121], y_c[1], x_c[12], p[10])*p[10];

  out[13] = FunctionForG6PDH_c(p[47], p[50], p[48], p[49], p[51], p[46], x_c[21], y_c[6], x_c[3], x_c[13], p[10])*p[10]-FunctionForPGL_c(p[93], p[95], p[94], p[92], p[96], x_c[13], x_c[26], p[10])*p[10];

  out[14] = FunctionFor_6PGDH_c(y_c[6], x_c[3], x_c[14], p[98], p[99], p[100], p[102], p[101], p[97], x_c[26], p[10])*p[10]-FunctionForPPI_c(p[104], p[106], p[105], p[103], p_c[2], x_c[14], p[10])*p[10];

  out[15] = -FunctionFor_6PGDH_g(y_c[7], x_c[6], x_c[20], p[78], p[79], p[80], p[82], p[81], p[77], x_c[15], p[11])*p[11]+FunctionForPGL_g(p[117], p[119], p[118], p[116], p[120], x_c[25], x_c[15], p[11])*p[11];

  out[16] = FunctionForGDA_g(y_c[4], x_c[4], p[91], x_c[16], x_c[10])-FunctionForGPO_c(p[162], p[161], x_c[16], p[10])*p[10];

  out[17] = -FunctionForPFK_g(x_c[29], x_c[30], x_c[1], x_c[17], p[30], p[27], p[33], p[32], p[29], p[28], p[31], p[26], p[11])*p[11]+FunctionForPGI_g(x_c[17], x_c[8], p[85], p[87], p[86], p[84], p[83], x_c[15], p[11])*p[11];

  out[18] = -FunctionForPGK_g(x_c[1], x_c[30], p[128], p[129], p[131], p[130], p[132], p[127], x_c[18], x_c[27], p[11])*p[11]+FunctionForGAPDH_g(x_c[7], p[156], p[159], p[157], p[158], p[160], p[155], y_c[2], x_c[23], x_c[18], p[11])*p[11];

  out[19] = FunctionForPGAM_c(p[41], p[43], p[42], p[40], x_c[19], x_c[9], p[10])*p[10]-FunctionForENO_c(p[53], p[54], p[55], p[52], x_c[24], x_c[19], p[10])*p[10];

  out[20] = FunctionFor_6PGDH_g(y_c[7], x_c[6], x_c[20], p[78], p[79], p[80], p[82], p[81], p[77], x_c[15], p[11])*p[11]-FunctionForPPI_g(p[108], p[110], p[109], p[107], p_c[4], x_c[20], p[11])*p[11];

  out[21] = -FunctionForG6PDH_c(p[47], p[50], p[48], p[49], p[51], p[46], x_c[21], y_c[6], x_c[3], x_c[13], p[10])*p[10]+FunctionForHXK_c(x_c[2], x_c[28], x_c[21], x_c[5], p[65], p[69], p[67], p[66], p[68], p[64], p[10])*p[10]-FunctionForG6PP_c(p[74], p[76], p[75], p[73], x_c[21], x_c[5], p[10])*p[10];

  out[22] = -FunctionForHXK_g(x_c[1], x_c[30], x_c[8], x_c[22], p[57], p[61], p[59], p[58], p[60], p[56], p[11])*p[11]+(p[111] * x_c[5] - p[112] * x_c[22]) ;

  out[23] = FunctionForG3PDH_g(x_c[4], p[134], p[135], p[137], p[138], p[136], p[133], x_c[10], y_c[2], x_c[23], p[11])*p[11]-FunctionForGAPDH_g(x_c[7], p[156], p[159], p[157], p[158], p[160], p[155], y_c[2], x_c[23], x_c[18], p[11])*p[11];

  out[24] = -FunctionForPYK_c(x_c[2], x_c[28], x_c[24], p[23], p[20], p[19], p[22], p[25], p[18], p[24], p[17], p[21], x_c[11], p[10])*p[10]+FunctionForENO_c(p[53], p[54], p[55], p[52], x_c[24], x_c[19], p[10])*p[10];

  out[25] = FunctionForG6PDH_g(p[35], p[38], p[36], p[37], p[39], p[34], x_c[8], y_c[7], x_c[6], x_c[25], p[11])*p[11]-FunctionForPGL_g(p[117], p[119], p[118], p[116], p[120], x_c[25], x_c[15], p[11])*p[11];

  out[26] = FunctionForPGL_c(p[93], p[95], p[94], p[92], p[96], x_c[13], x_c[26], p[10])*p[10]-FunctionFor_6PGDH_c(y_c[6], x_c[3], x_c[14], p[98], p[99], p[100], p[102], p[101], p[97], x_c[26], p[10])*p[10];

  out[27] = -mass_action_rev_1(p[62], x_c[9], x_c[27])+FunctionForPGK_g(x_c[1], x_c[30], p[128], p[129], p[131], p[130], p[132], p[127], x_c[18], x_c[27], p[11])*p[11];

  out[28] = FunctionForPYK_c(x_c[2], x_c[28], x_c[24], p[23], p[20], p[19], p[22], p[25], p[18], p[24], p[17], p[21], x_c[11], p[10])*p[10]
    - FunctionForHXK_c(x_c[2], x_c[28], x_c[21], x_c[5], p[65], p[69], p[67], p[66], p[68], p[64], p[10])*p[10]
    + FunctionForAK_c(x_c[2], p[71], p[72], y_c[5], x_c[28], p[10])*p[10]
    - FunctionForATPu_c(x_c[2], x_c[28], p[139], p[10])*p[10];

  out[29] = FunctionForPFK_g(x_c[29], x_c[30], x_c[1], x_c[17], p[30], p[27], p[33], p[32], p[29], p[28], p[31], p[26], p[11])*p[11]-FunctionForALD_g(x_c[1], p[151], p[149], p[150], p[148], p[154], p[153], p[147], p[152], p[146], y_c[3], x_c[30], x_c[4], x_c[29], x_c[7], p[11])*p[11];

  out[30] = -FunctionForPFK_g(x_c[29], x_c[30], x_c[1], x_c[17], p[30], p[27], p[33], p[32], p[29], p[28], p[31], p[26], p[11])*p[11]-FunctionForHXK_g(x_c[1], x_c[30], x_c[8], x_c[22], p[57], p[61], p[59], p[58], p[60], p[56], p[11])*p[11]+FunctionForAK_g(x_c[1], p[88], p[89], y_c[3], x_c[30], p[11])*p[11]+FunctionForPGK_g(x_c[1], x_c[30], p[128], p[129], p[131], p[130], p[132], p[127], x_c[18], x_c[27], p[11])*p[11]+v2sub2prod_1(x_c[1], x_c[30], p[141], p[143], p[145], p[144], p[142], p[140], x_c[10], p_c[9]);
  return out;
}
