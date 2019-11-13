data {
  int<lower=1> N;
  int<lower=1> E;
  int<lower=1> EC3;
  int<lower=1,upper=E> enzyme[N];
  int<lower=1,upper=EC3> ec3[E];
  vector[N] log_km_obs;
  int<lower=0,upper=1> likelihood;
}
parameters {
  vector[EC3] mu_ec3;
  vector[EC3] log_sigma_ec3;
  vector[E] mu_enzyme;
  real a;
  real<lower=0> sigma;
  real tau_ec3;
}
transformed parameters {
  vector<lower=0>[EC3] sigma_ec3 = exp(tau_ec3 + log_sigma_ec3);
}
model {
  a ~ normal(-2, 1);
  tau_ec3 ~ normal(0, 1);
  sigma ~ normal(0, 1);
  mu_ec3 ~ normal(0, 1);
  log_sigma_ec3 ~ normal(0, 1);
  mu_enzyme ~ normal(mu_ec3[ec3], sigma_ec3[ec3]);
  if (likelihood == 1){
    log_km_obs ~ normal(a + mu_enzyme[enzyme], sigma);
  }
}
generated quantities {
  vector[N] log_km_pred;
  vector[N] residual;
  for (n in 1:N){
    log_km_pred[n] = normal_rng(a + mu_enzyme[enzyme[n]], sigma);
    residual[n] = log_km_obs[n] - log_km_pred[n];
  }
}
