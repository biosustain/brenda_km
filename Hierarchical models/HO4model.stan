data {
  int<lower=1> N;
  int<lower=1> S;
  int<lower=1,upper=S> species[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> tauspecies;
  vector[S] bspecies_z;
}
transformed parameters {
  vector[S] bspecies = bspecies_z * tauspecies;
}
model {
  // non-hierarchical priors
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);
  tauspecies ~ normal(0, 1);
  //hierarchical priors
  bspecies_z ~ normal(0, 1);
  // likelihood
  if (likelihood == 1){
    vector[N] yhat = mu + bspecies[species];
    y ~ normal(yhat, sigma);
  }
}
generated quantities {
  vector[N] log_likelihood;
  vector[N] yrep;
  {
    vector[N] yhat = mu + bspecies[species];
    for (n in 1:N){
      log_likelihood[n] = normal_lpdf(y[n] | yhat[n] , sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}