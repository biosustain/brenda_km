data {
  int<lower=1> N;
  int<lower=1> O;
  int<lower=1> F;
  int<lower=1,upper=O> superking[N];
  int<lower=1,upper=F> family[N];
  int<lower=1,upper=O> parent_of_family[F];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> tausuperking;
  vector<lower=0>[O] taufamily;
  vector[O] bsuperking_z;
  vector[F] bfamily_z;
}
transformed parameters {
  vector[O] bsuperking = bsuperking_z * tausuperking;
  vector[F] bfamily = bfamily_z .* taufamily[parent_of_family];
}
model {
  // non-hierarchical priors
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);
  tausuperking ~ normal(0, 1);
  taufamily ~ normal(0, 1);
  //hierarchical priors
  bsuperking_z ~ normal(0, 1);
  bfamily_z ~ normal(0, 1);
  // likelihood
  if (likelihood == 1){
    vector[N] yhat = mu + bsuperking[superking] + bfamily[family];
    y ~ normal(yhat, sigma);
  }
}
generated quantities {
  vector[N] log_likelihood;
  vector[N] yrep;
  {
    vector[N] yhat = mu + bsuperking[superking] + bfamily[family];
    for (n in 1:N){
      log_likelihood[n] = normal_lpdf(y[n] | yhat[n] , sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}
