real v1sub1prod(real varb_0, real varb_1, real varb_2, real varb_3, real varb_4, real varb_5) 	//v1sub1prod
{return  varb_0*varb_2*(1.00000000000000000-varb_4/(varb_1*varb_2))/(varb_3*(1.00000000000000000+varb_2/varb_3+varb_4/varb_5));} 
real FunctionForTPI_g(real sub_0, real prod_0, real param_0, real param_1, real param_2, real param_3, real volume_0) 	//Function for TPI_g
{return  v1sub1prod(param_3,param_0,sub_0,param_1,prod_0,param_2)/volume_0;} 
real FunctionForPYK_c(real sub_0, real prod_0, real sub_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real param_6, real param_7, real param_8, real prod_1, real volume_0) 	//Function for PYK_c
{return  param_7*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0))*pow((sub_1/(param_5*(1.00000000000000000+sub_0/param_1+prod_0/param_2))),param_8)/(param_3*(1.00000000000000000+pow((sub_1/(param_5*(1.00000000000000000+sub_0/param_1+prod_0/param_2))),param_8)+prod_1/param_6)*(1.00000000000000000+sub_0/param_3+prod_0/param_4))/volume_0;} 
real FunctionForPFK_g(real prod_0, real sub_0, real prod_1, real sub_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real param_6, real param_7, real volume_0) 	//Function for PFK_g
{
  real numerator = param_7*param_1*sub_1*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0));
  real denominator = (param_5*param_4*(prod_1+param_1)*(param_6/param_4+sub_1/param_5+sub_0/param_4+prod_0/param_3+prod_1*prod_0/(param_3*param_2)+sub_1*sub_0/(param_5*param_4)));
 return numerator / denominator / volume_0;
}
real v2sub2prod(real varb_0, real varb_1, real varb_2, real varb_3, real varb_4, real varb_5, real varb_6, real varb_7, real varb_8, real varb_9) 	//v2sub2prod
{return  varb_0*varb_2*varb_4*(1.00000000000000000-varb_6*varb_8/(varb_1*varb_2*varb_4))/(varb_3*varb_5*(1.00000000000000000+varb_2/varb_3+varb_6/varb_7)*(1.00000000000000000+varb_4/varb_5+varb_8/varb_9));} 
real FunctionForG6PDH_g(real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_0, real prod_0, real sub_1, real prod_1, real volume_0) 	//Function for G6PDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
real FunctionForPGAM_c(real param_0, real param_1, real param_2, real param_3, real prod_0, real sub_0, real volume_0) 	//Function for PGAM_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
real v1sub_1(real param_0, real param_1, real sub_0) 	//v1sub_1
{return  param_1*sub_0/(param_0*(1.00000000000000000+sub_0/param_0));} 
real FunctionForG6PDH_c(real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_0, real prod_0, real sub_1, real prod_1, real volume_0) 	//Function for G6PDH_c
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
real FunctionForENO_c(real param_0, real param_1, real param_2, real param_3, real prod_0, real sub_0, real volume_0) 	//Function for ENO_c
{return  v1sub1prod(param_3,param_0,sub_0,param_1,prod_0,param_2)/volume_0;} 
real FunctionForHXK_g(real prod_0, real sub_0, real prod_1, real sub_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real volume_0) 	//Function for HXK_g
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
real mass_action_rev_1(real param_0, real prod_0, real sub_0) 	//mass_action_rev_1
{return  param_0*sub_0-param_0*prod_0;} 
real mass_action_irrev(real varb_0, real varb_1) 	//mass_action_irrev
{return  varb_0*varb_1;} 
real FunctionForNADPHu_c(real sub_0, real param_0, real volume_0) 	//Function for NADPHu_c
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
real FunctionForHXK_c(real prod_0, real sub_0, real prod_1, real sub_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real volume_0) 	//Function for HXK_c
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
real FunctionForNADPHu_g(real sub_0, real param_0, real volume_0) 	//Function for NADPHu_g
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
real vAK(real varb_0, real varb_1, real varb_2, real varb_3, real varb_4) 	//vAK
{return  varb_3*pow(varb_0,2.00000000000000000)-varb_1*varb_2*varb_4;} 
real FunctionForAK_c(real sub_0, real param_0, real param_1, real prod_0, real prod_1, real volume_0) 	//Function for AK_c
{return  vAK(sub_0,prod_0,prod_1,param_0,param_1)/volume_0;} 
real FunctionForG6PP_c(real param_0, real param_1, real param_2, real param_3, real sub_0, real prod_0, real volume_0) 	//Function for G6PP_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
real FunctionFor_6PGDH_g(real prod_0, real sub_0, real prod_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_1, real volume_0) 	//Function for _6PGDH_g
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_2,prod_1,param_4,prod_0,param_3)/volume_0;} 
real FunctionForPGI_g(real prod_0, real sub_0, real param_0, real param_1, real param_2, real param_3, real param_4, real modif_0, real volume_0) 	//Function for PGI_g
{return  param_4*sub_0*(1.00000000000000000-prod_0/(param_0*sub_0))/(param_3*(1.00000000000000000+sub_0/param_3+prod_0/param_2+modif_0/param_1))/volume_0;} 
real FunctionForAK_g(real sub_0, real param_0, real param_1, real prod_0, real prod_1, real volume_0) 	//Function for AK_g
{return  vAK(sub_0,prod_0,prod_1,param_0,param_1)/volume_0;} 
real FunctionForTOX_c(real param_0, real sub_0, real volume_0) 	//Function for TOX_c
{return  mass_action_irrev(param_0,sub_0)/volume_0;} 
real FunctionForGDA_g(real sub_0, real prod_0, real param_0, real prod_1, real sub_1) 	//Function for GDA_g
{return  sub_1*param_0*sub_0-prod_1*param_0*prod_0;} 
real FunctionForPGL_c(real param_0, real param_1, real param_2, real param_3, real param_4, real sub_0, real prod_0, real volume_0) 	//Function for PGL_c
{return  (param_4*volume_0*(sub_0-prod_0/param_0)+v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1))/volume_0;} 
real FunctionFor_6PGDH_c(real prod_0, real sub_0, real prod_1, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_1, real volume_0) 	//Function for _6PGDH_c
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_2,prod_1,param_4,prod_0,param_3)/volume_0;} 
real FunctionForPPI_c(real param_0, real param_1, real param_2, real param_3, real prod_0, real sub_0, real volume_0) 	//Function for PPI_c
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
real FunctionForPPI_g(real param_0, real param_1, real param_2, real param_3, real prod_0, real sub_0, real volume_0) 	//Function for PPI_g
{return  v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1)/volume_0;} 
real FunctionForGlcT_c(real param_0, real param_1, real param_2, real prod_0, real sub_0) 	//Function for GlcT_c
{return  param_1*(sub_0-prod_0)/(param_0+sub_0+prod_0+param_2*sub_0*prod_0/param_0);} 
real FunctionForPGL_g(real param_0, real param_1, real param_2, real param_3, real param_4, real sub_0, real prod_0, real volume_0) 	//Function for PGL_g
{return  (volume_0*param_4*(sub_0-prod_0/param_0)+v1sub1prod(param_3,param_0,sub_0,param_2,prod_0,param_1))/volume_0;} 
real FunctionForTR_c(real sub_0, real prod_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_1, real prod_1, real volume_0) 	//Function for TR_c
{return  v2sub2prod(param_5,param_0,sub_1,param_3,sub_0,param_2,prod_1,param_4,prod_0,param_1)/volume_0;} 
real FunctionForPGK_g(real sub_0, real prod_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_1, real prod_1, real volume_0) 	//Function for PGK_g
{return  v2sub2prod(param_5,param_0,sub_1,param_1,sub_0,param_3,prod_1,param_2,prod_0,param_4)/volume_0;} 
real FunctionForG3PDH_g(real sub_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real prod_0, real sub_1, real prod_1, real volume_0) 	//Function for G3PDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_1,sub_1,param_4,prod_0,param_2,prod_1,param_3)/volume_0;} 
real FunctionForATPu_c(real prod_0, real sub_0, real param_0, real volume_0) 	//Function for ATPu_c
{return  param_0*sub_0/prod_0/volume_0;} 
real v2sub2prod_1(real sub_0, real prod_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real sub_1, real prod_1) 	//v2sub2prod_1
{return  param_5*sub_1*sub_0*(1.00000000000000000-prod_1*prod_0/(param_0*sub_1*sub_0))/(param_4*param_1*(1.00000000000000000+sub_1/param_4+prod_1/param_3)*(1.00000000000000000+sub_0/param_1+prod_0/param_2));} 
real FunctionForALD_g(real modif_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real param_6, real param_7, real param_8, real modif_1, real modif_2, real prod_0, real sub_0, real prod_1, real volume_0) 	//Function for ALD_g
{return  param_8*sub_0*(1.00000000000000000-prod_1*prod_0/(sub_0*param_0))/(param_6*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2)*(1.00000000000000000+prod_1/param_7+prod_0/param_5+sub_0/(param_6*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2))+prod_1*prod_0/(param_7*param_5)+sub_0*prod_1/(param_6*param_4*(1.00000000000000000+modif_2/param_3+modif_0/param_1+modif_1/param_2))))/volume_0;} 
real FunctionForGAPDH_g(real sub_0, real param_0, real param_1, real param_2, real param_3, real param_4, real param_5, real prod_0, real sub_1, real prod_1, real volume_0) 	//Function for GAPDH_g
{return  v2sub2prod(param_5,param_0,sub_0,param_2,sub_1,param_3,prod_1,param_1,prod_0,param_4)/volume_0;} 
real v1sub(real varb_0, real varb_1, real varb_2) 	//v1sub
{return  varb_0*varb_1/(varb_2*(1.00000000000000000+varb_1/varb_2));} 
real FunctionForGPO_c(real param_0, real param_1, real sub_0, real volume_0) 	//Function for GPO_c
{return  v1sub(param_1,sub_0,param_0)/volume_0;} 
