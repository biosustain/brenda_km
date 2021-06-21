/* A model of brenda data that takes into account the ec number of the
   catalysing enzyme and whether the catalysed substrate is natural.*/

data {
  int<lower=1> N;
  int<lower=1> N_predictor;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_non_singleton_ec3;
  int<lower=1> N_ec4_free;
  int<lower=1> N_organism;
  int<lower=1,upper=N_organism> organism[N_predictor];
  int<lower=1,upper=N_ec4> ec4[N_predictor];  // NB: ordered so that free ones are first
  int<lower=1,upper=N_ec3> ec3[N_predictor];  // NB: ordered so that free ones are first
  int<lower=1,upper=N_ec3> ec4_to_ec3[N_ec4];
  vector<lower=0,upper=1>[N_predictor] is_natural;
  int<lower=1,upper=N_predictor> predictor[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
  vector[2] prior_sigma;
  vector[2] prior_tau;
  vector[2] prior_tau_ec3;
  vector[2] prior_tau_organism;
  vector[2] prior_b_natural;
}
parameters {
  real baseline;
  real b_natural;
  real<lower=0> sigma;
  real<lower=0> tau;
  vector<lower=0>[N_organism] tau_predictor;
  vector[N_predictor] a_predictor;
  vector<lower=0>[N_non_singleton_ec3] tau_ec3;
  vector<multiplier=tau>[N_ec3] a_ec3;
  vector<multiplier=tau_ec3[ec4_to_ec3[1:N_ec4_free]]>[N_ec4_free] a_ec4_free;
}
transformed parameters {
  vector[N_ec4] a_ec4 = append_row(a_ec4_free, rep_vector(0, N_ec4-N_ec4_free));
  vector[N_predictor] yhat =
    baseline + a_ec3[ec3] + a_ec4[ec4] + b_natural * is_natural + a_predictor;
}
model {
  baseline ~ normal(0, 1);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  tau ~ lognormal(prior_tau[1], prior_tau[2]);
  b_natural ~ normal(prior_b_natural[1], prior_b_natural[2]);
  tau_ec3 ~ lognormal(prior_tau_ec3[1], prior_tau_ec3[2]);
  a_ec3 ~ student_t(4, 0, tau);
  a_ec4_free ~ student_t(4, 0, tau_ec3[ec4_to_ec3[1:N_ec4_free]]);
  a_predictor ~ student_t(4, 0, tau_predictor[organism]);
  if (likelihood){
    y ~ student_t(4, yhat[predictor], sigma);
  }
}
generated quantities {
  vector[N] llik;
  vector[N] yrep;
  for (n in 1:N){
    llik[n] = student_t_lpdf(y[n] | 4, yhat[predictor[n]], sigma);
    yrep[n] = student_t_rng(4, yhat[predictor[n]], sigma);
  }
}
