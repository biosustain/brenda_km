/* Simplest model I can think of. */

data {
  int<lower=1> N;             // number of measurements
  int<lower=1> N_biology;     // biologically meaningful categories
  int<lower=1> N_natural;
  int<lower=1> N_substrate_type;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1> N_ec1;
  vector[N] y;
  vector[N] is_natural;
  array[N] int<lower=1,upper=N_biology> biology;
  array[N_biology] int<lower=1,upper=N_substrate_type> substrate_type;
  array[N_ec2] int<lower=1,upper=N_ec1> ec1;
  array[N_ec3] int<lower=1,upper=N_ec2> ec2;
  array[N_ec4] int<lower=1,upper=N_ec3> ec3;
  array[N_biology] int<lower=1,upper=N_ec4> ec4;
  vector[2] prior_sigma;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real<lower=0> sigma;
  real<lower=1> nu;
  real mu_log_km;
}
model {
  if (likelihood){y ~ student_t(nu, mu_log_km, sigma);}
  nu ~ gamma(2, 0.1);
  mu_log_km ~ normal(0, 2);
  sigma ~ normal(0, 2);
}
generated quantities {
  vector[N_natural] llik;
  {
    int i = 1;
    for (n in 1:N){
      if (is_natural[n]){
        llik[i] = normal_lpdf(y[n] | mu_log_km, sigma);
        i += 1;
      }
    }
  }
}
