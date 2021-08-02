data {
  int<lower=1> N;          // measurements
  vector[N] y;
  int<lower=1> N_cat;      // instantiated enz x org x sub combinations
  int<lower=1> N_substrate_type;
  int<lower=1> N_enz;
  int<lower=1> N_ec3;      // subcategory of enzyme
  int<lower=1,upper=N_ec3> ec3[N_enz];
  int<lower=1,upper=N_enz> enz[N_cat];
  array[N_cat] int<lower=1,upper=N_substrate_type> substrate_type;
  int<lower=1,upper=N_cat> cat[N];
  int<lower=0,upper=1> likelihood;

  vector[2] prior_mu;
  vector[2] prior_sigma;
  vector[2] prior_tau_ec3;
  vector[2] prior_tau_ec4;
  vector[2] prior_tau_organism;
  vector[2] prior_b_natural;
}
parameters {
  real<lower=0> sigma;
  real b_natural;
  real mu_log_tau_cat;
  real<lower=0> tau_ec3;
  vector[N_substrate_type] mu;
  vector[N_substrate_type] a_substrate_type_log_tau_cat;
  vector<lower=0>[N_ec3] tau_ec4;
  vector[N_ec3] a_ec3_log_tau_cat;
  vector[N_ec3] a_ec3;
  vector[N_enz] a_ec4;
  vector[N_cat] a_cat;
}
transformed parameters {
  vector[N_cat] log_tau_cat = mu_log_tau_cat + a_ec3_log_tau_cat[ec3[enz]] + a_substrate_type_log_tau_cat[substrate_type];
  vector[N_cat] yhat =
    mu[substrate_type] + a_ec3[ec3[enz]] + a_ec4[enz] + a_cat;
}
model {
  // likelihood
  if (likelihood){y ~ student_t(4, yhat[cat], sigma);}
  // non-hierarchical priors
  mu ~ normal(prior_mu[1], prior_mu[2]);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  b_natural ~ normal(prior_b_natural[1], prior_b_natural[2]);
  mu_log_tau_cat ~ normal(0, 1);
  a_ec3_log_tau_cat ~ normal(0, 1);
  a_substrate_type_log_tau_cat ~ normal(0, 1);
  tau_ec3 ~ lognormal(prior_tau_ec3[1], prior_tau_ec3[2]);
  tau_ec4 ~ lognormal(prior_tau_ec4[1], prior_tau_ec4[2]);
  // hierarchical priors
  a_ec3 ~ student_t(4, 0, tau_ec3);
  a_ec4 ~ student_t(4, 0, tau_ec4[ec3]);
  a_cat ~ student_t(4, 0, exp(log_tau_cat[ec3[enz]]));
}
generated quantities {
  vector[N] llik;
  for (n in 1:N){
    llik[n] = student_t_lpdf(y[n] | 4, yhat[cat[n]], sigma);
  }
}
