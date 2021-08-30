/* Model that focuses on distributional effects. */

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
  real<lower=0> t_ec3;
  array[N_ec1] real mu_log_km;
  real<lower=1> nu;
  real<lower=0> tau;
  vector[N_ec3] a_ec3;
  vector[N_substrate_type] a_sub;
  vector[N_biology] log_km;
}
transformed parameters {
}
model {
  if (likelihood){
    vector[N_biology] sd_coef = exp(a_ec3[ec3[ec4]] + a_sub[substrate_type]);
    y ~ student_t(nu, log_km[biology], sigma * sd_coef[biology]);
  }
  log_km ~ normal(mu_log_km[ec1[ec2[ec3[ec4]]]], tau);
  nu ~ gamma(2, 0.1);
  mu_log_km ~ normal(-1, 2);
  a_sub ~ normal(0, 1);
  a_ec3 ~ normal(0, t_ec3);
  t_ec3 ~ normal(0, 0.5);
  tau ~ normal(0, 2);
  sigma ~ normal(prior_sigma[1], prior_sigma[2]);
}
generated quantities {
  vector[N_natural] llik;
  {
    int i = 1;
    vector[N_biology] sd_coef = exp(a_ec3[ec3[ec4]] + a_sub[substrate_type]);
    for (n in 1:N){
      if (is_natural[n]){
        llik[i] = student_t_lpdf(y[n] |
                                 nu,
                                 log_km[biology[n]],
                                 sigma * sd_coef[biology[n]]);
        i += 1;
      }
    }
  }
}
