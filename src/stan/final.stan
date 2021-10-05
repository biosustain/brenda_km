/* Model that focuses on distributional effects. */

data {
  int<lower=1> N;             // number of measurements
  int<lower=1> N_biology;     // biologically meaningful categories
  int<lower=1> N_natural;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1> N_ec1;
  vector[N] y;
  vector[N] is_natural;
  array[N] int<lower=1,upper=N_biology> biology;
  array[N_ec2] int<lower=1,upper=N_ec1> ec1;
  array[N_ec3] int<lower=1,upper=N_ec2> ec2;
  array[N_ec4] int<lower=1,upper=N_ec3> ec3;
  array[N_biology] int<lower=1,upper=N_ec4> ec4;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu_sigma;
  real<lower=0> tau_ec3;
  array[N_ec1] real mu_log_km;
  real<lower=1> nu;
  real<lower=0> tau_log_km;
  vector[N_ec3] a_ec3;
  vector[N_biology] log_km;
}
model {
  if (likelihood){
    vector[N_biology] sigma = exp(mu_sigma + a_ec3[ec3[ec4]]);
    y ~ student_t(nu, log_km[biology], sigma[biology]);
  }
  log_km ~ normal(mu_log_km[ec1[ec2[ec3[ec4]]]], tau_log_km);
  nu ~ gamma(2, 0.1);
  mu_log_km ~ normal(-1, 2);
  a_ec3 ~ normal(0, tau_ec3);
  tau_ec3 ~ normal(0, 0.5);
  tau_log_km ~ normal(0, 2);
  mu_sigma ~ normal(0, 2);
}
generated quantities {
  vector[N_natural] llik;
  {
    int i = 1;
    vector[N_biology] sigma = exp(mu_sigma + a_ec3[ec3[ec4]]);
    for (n in 1:N){
      if (is_natural[n]){
        llik[i] =
          student_t_lpdf(y[n] | nu, log_km[biology[n]], sigma[biology[n]]);
        i += 1;
      }
    }
  }
}
