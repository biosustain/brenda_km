data {
  int<lower=1> N;
  int<lower=1> O;
  int<lower=1,upper=O> superking[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> tausuperking;
  vector[O] bsuperking_z;
}
transformed parameters {
  vector[O] bsuperking = bsuperking_z * tausuperking;
}
model {
  // non-hierarchical priors
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);
  tausuperking ~ normal(0, 1);
  //hierarchical priors
  bsuperking_z ~ normal(0, 1);
  // likelihood
  if (likelihood == 1){
    vector[N] yhat = mu + bsuperking[superking];
    y ~ normal(yhat, sigma);
  }
}
generated quantities {
  vector[N] log_likelihood;
  vector[N] yrep;
  {
    vector[N] yhat = mu + bsuperking[superking];
    for (n in 1:N){
      log_likelihood[n] = normal_lpdf(y[n] | yhat[n] , sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}