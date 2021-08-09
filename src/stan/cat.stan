data {
  int<lower=1> N;         // instantiated enz x org x sub combinations
  int<lower=1> N_substrate_type;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1> N_ec1;      // subcategory of enzyme
  vector[N] y;
  vector[N] sample_size;
  vector[N] is_natural;
  array[N] int<lower=1,upper=N_substrate_type> substrate_type;
  array[N_ec2] int<lower=1,upper=N_ec1> ec1;
  array[N_ec3] int<lower=1,upper=N_ec2> ec2;
  array[N_ec4] int<lower=1,upper=N_ec3> ec3;
  array[N] int<lower=1,upper=N_ec4> ec4;
  vector[2] prior_log_km;
  vector[2] prior_sigma;
  vector[2] prior_b_natural;
  vector[2] prior_mu;
  vector[2] prior_tau_ec3;
  vector[2] prior_tau_ec4;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real mu_log_km;
  real b_natural;
  real tau_ec2;
  vector<lower=0>[N_ec2] tau_ec3;
  vector<lower=0>[N_ec3] tau_ec4;
  vector<lower=0>[N_ec1] tau_log_km;
  vector[N_ec2] a_ec2;
  vector[N_ec3] a_ec3;
  vector[N_ec4] a_ec4;
  vector[N] log_km;
}
model {
  if (likelihood){y ~ normal(log_km, sigma * inv(sqrt(sample_size)));}

  log_km ~ normal(mu_log_km
                  + b_natural * is_natural
                  + a_ec2[ec2[ec3[ec4]]]
                  + a_ec3[ec3[ec4]]
                  + a_ec4[ec4],
                  tau_log_km[ec1[ec2[ec3[ec4]]]]);
  log_km ~ normal(prior_log_km[1], prior_log_km[2]);
  a_ec2 ~ student_t(4, 0, tau_ec2);
  a_ec3 ~ student_t(4, 0, tau_ec3[ec2]);
  a_ec4 ~ student_t(4, 0, tau_ec4[ec3]);
  mu_log_km ~ normal(prior_mu[1], prior_mu[2]);
  tau_log_km ~ lognormal(0, 1);
  tau_ec2 ~ lognormal(0, 1);
  tau_ec3 ~ lognormal(prior_tau_ec3[1], prior_tau_ec3[2]);
  tau_ec4 ~ lognormal(prior_tau_ec4[1], prior_tau_ec4[2]);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  b_natural ~ lognormal(prior_b_natural[1], prior_b_natural[2]);
}
generated quantities {
  vector[N] llik = rep_vector(0, N);
  for (n in 1:N){
    llik[n] = normal_lpdf(y[n] | log_km[n], sigma * inv(sqrt(sample_size[n])));
  }
}
