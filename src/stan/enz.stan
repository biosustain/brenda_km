/* Extends the BLK model for more specific data from the SABIO-rk database */

data {
  int<lower=1> N;
  int<lower=1> N_train;
  int<lower=1> N_test;
  int<lower=1> N_biology;
  int<lower=1> N_substrate;
  int<lower=1> N_ec4_sub;
  int<lower=1> N_enz_sub;
  int<lower=1> N_org_sub;
  int<lower=1,upper=N_ec4_sub> ec4_sub[N_biology];
  int<lower=1,upper=N_org_sub> org_sub[N_biology];
  int<lower=0,upper=N_enz_sub> enz_sub[N_biology];
  int<lower=1,upper=N_substrate> substrate[N_biology];
  array[N_train] int<lower=1,upper=N_biology> biology_train;
  array[N_train] int<lower=1,upper=N> ix_train;
  array[N_test] int<lower=1,upper=N_biology> biology_test;
  array[N_test] int<lower=1,upper=N> ix_test;
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=1> nu;
  real mu;
  real<lower=0> sigma;
  real<lower=0> tau_substrate;
  real<lower=0> tau_org_sub;
  real<lower=0> tau_ec4_sub;
  real<lower=0> tau_enz_sub;
  vector<multiplier=tau_substrate>[N_substrate] a_substrate;
  vector<multiplier=tau_org_sub>[N_org_sub] a_org_sub;
  vector<multiplier=tau_ec4_sub>[N_ec4_sub] a_ec4_sub;
  vector<multiplier=tau_enz_sub>[N_enz_sub] a_enz_sub;
}
transformed parameters {
  vector[N_biology] log_km = mu
    + a_substrate[substrate]
    + a_ec4_sub[ec4_sub]
    + a_org_sub[org_sub];
  for (b in 1:N_biology){
    if (enz_sub[b] > 1) log_km[b] += a_enz_sub[enz_sub[b]];
  }
}
model {
  if (likelihood){
    y[ix_train] ~ student_t(nu, log_km[biology_train], sigma);
  }
  nu ~ gamma(2, 0.1);
  sigma ~ normal(0, 2);
  mu ~ normal(-1, 2);
  a_substrate ~ normal(0, tau_substrate);
  a_ec4_sub ~ normal(0, tau_ec4_sub);
  a_enz_sub ~ normal(0, tau_enz_sub);
  a_org_sub ~ normal(0, tau_org_sub);
  tau_org_sub ~ normal(0, 1);
  tau_ec4_sub ~ normal(0, 1);
  tau_enz_sub ~ normal(0, 1);
  tau_substrate ~ normal(0, 1);
}
generated quantities {
  vector[N_test] llik;
  vector[N_test] yrep;
  for (n in 1:N_test){
    llik[n] = student_t_lpdf(y[ix_test[n]] | nu, log_km[biology_test[n]], sigma);
    yrep[n] = student_t_rng(nu, log_km[biology_test[n]], sigma);
  }
}
