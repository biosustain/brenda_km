/* A model of brenda data that takes into account the ec number of the
   catalysing enzyme and whether the catalysed substrate is natural.*/

data {
  int<lower=1> N;
  int<lower=1> N_cat;   // i.e. EC3 * EC4 * organism
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_nonzero_a_ec4;
  int<lower=1,upper=N_ec4> ec4[N_cat];
  int<lower=1,upper=N_ec3> ec3[N_cat];
  int<lower=1,upper=N_ec4> ix_nonzero_a_ec4[N_nonzero_a_ec4];
  int<lower=1,upper=N_ec3> ec3_to_nonzero_ec4[N_nonzero_a_ec4]; 
  vector<lower=0,upper=1>[N] is_natural;
  int<lower=1,upper=N_cat> cat[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
  vector[2] prior_mu;
  vector[2] prior_sigma;
  vector[2] prior_tau_ec3;
  vector[2] prior_tau_ec4;
  vector[2] prior_b_natural;
}
parameters {
  // hierarchical sigmas
  real<lower=0> tau_ec3;
  vector<lower=0>[N_ec3] tau_ec4;
  // hierarchical effects
  vector<multiplier=tau_ec3>[N_ec3] a_ec3;
  vector<multiplier=tau_ec4[ec3_to_nonzero_ec4]>[N_nonzero_a_ec4] a_ec4_nonzero;
  // non hierarchical effects
  real mu;
  real<lower=0> sigma;
  real b_natural;
}
transformed parameters {
  vector[N_ec4] a_ec4 = rep_vector(0, N_ec4);
  vector[N_cat] a_cat;
  a_ec4[ix_nonzero_a_ec4] = a_ec4_nonzero;
  a_cat = mu + a_ec3[ec3] + a_ec4[ec4];
}
model {
  // hierarchical sigmas
  tau_ec3 ~ lognormal(prior_tau_ec3[1], prior_tau_ec3[2]);
  tau_ec4 ~ lognormal(prior_tau_ec4[1], prior_tau_ec4[2]);
  // hierarchical effects
  a_ec3 ~ student_t(4, 0, tau_ec3);
  a_ec4_nonzero ~ student_t(4, 0, tau_ec4[ec3_to_nonzero_ec4]);
  // non hierarchical effects
  mu ~ normal(prior_mu[1], prior_mu[2]);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  b_natural ~ normal(prior_b_natural[1], prior_b_natural[2]);
  // likelihood
  if (likelihood){
    y ~ student_t(4, a_cat[cat] + b_natural * is_natural, sigma);
  }
}
generated quantities {
  vector[N] llik;
  vector[N] yrep;
  for (n in 1:N){
    llik[n] = student_t_lpdf(y[n] | 4, a_cat[cat[n]] + b_natural * is_natural[n], sigma);
    yrep[n] = student_t_rng(4, a_cat[cat[n]] + b_natural * is_natural[n], sigma);
  }
}
