data {
  int<lower=1> N;
  int<lower=1> E;
  int<lower=1,upper=E> enzyme[N];
  vector[N] log_km_obs;
  int<lower=0,upper=1> likelihood;
}
parameters {
  vector[E] mu_enzyme;
  real a;
  real<lower=0> sigma;
}
model {
  mu_enzyme ~ normal(0, 1);
  a ~ normal(0, 2);
  if (likelihood == 1){
    log_km_obs ~ normal(a + mu_enzyme[enzyme], sigma);
  }
}
generated quantities {
  vector[N] log_km_pred;
  vector[N] residual;
  for (n in 1:N){
    log_km_pred[n] = normal_rng(a + mu_enzyme[enzyme], sigma);
    residual[n] = log_km_obs[n] - log_km_pred[n];
  }
}
