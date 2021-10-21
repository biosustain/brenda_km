/* BRENDA model extending the one in the paper

- Borger, S., Liebermeister, W., & Klipp, E. (). Prediction of Enzyme Kinetic
  Parameters Based on Statistical Learning. , (), 8.

*/

data {
  int<lower=1> N_train;
  int<lower=1> N_test;
  int<lower=1> N_biology;
  int<lower=1> N_substrate;
  int<lower=1> N_ec_sub;
  int<lower=1> N_org_sub;
  int<lower=1,upper=N_ec_sub> ec_sub[N_biology];
  int<lower=1,upper=N_org_sub> org_sub[N_biology];
  int<lower=1,upper=N_substrate> substrate[N_biology];
  array[N_train] int<lower=1,upper=N_biology> biology_train;
  vector[N_train] y_train;
  array[N_test] int<lower=1,upper=N_biology> biology_test;
  vector[N_test] y_test;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=1> nu;
  real mu;
  real<lower=0> sigma;
  real<lower=0> tau_substrate;
  real<lower=0> tau_ec_sub;
  real<lower=0> tau_org_sub;
  vector<multiplier=tau_substrate>[N_substrate] a_substrate;
  vector<multiplier=tau_ec_sub>[N_ec_sub] a_ec_sub;
  vector<multiplier=tau_org_sub>[N_org_sub] a_org_sub;
}
transformed parameters {
  vector[N_biology] log_km =
    mu + a_substrate[substrate] + a_ec_sub[ec_sub] + a_org_sub[org_sub];
}
model {
  if (likelihood){y_train ~ student_t(nu, log_km[biology_train], sigma);}
  nu ~ gamma(2, 0.1);
  sigma ~ normal(0, 2);
  mu ~ normal(-2, 1);
  a_substrate ~ normal(0, tau_substrate);
  a_ec_sub ~ normal(0, tau_ec_sub);
  a_org_sub ~ normal(0, tau_org_sub);
  tau_org_sub ~ normal(0, 1);
  tau_ec_sub ~ normal(0, 1);
  tau_substrate ~ normal(0, 1);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y_test[n] | nu, log_km[biology_test[n]], sigma);
    yrep[n] = student_t_rng(nu, log_km[biology_test[n]], sigma);
  }
}
