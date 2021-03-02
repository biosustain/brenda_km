data {
  int<lower=1> N;
  int<lower=1> K;
  int<lower=1,upper=K> EC2[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> tauEC2;
  vector[K] aEC2_z;
}
transformed parameters {
  vector[K] aEC2 = aEC2_z * tauEC2;
}
model {
  // non-hierarchical priors
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);
  tauEC2 ~ normal(0, 1);
  //hierarchical priors
  aEC2_z ~ normal(0, 1);
  // likelihood
  if (likelihood == 1){
    vector[N] yhat = mu + aEC2[EC2];
    y ~ normal(yhat, sigma);
  }
}
generated quantities {
  vector[N] log_likelihood;
  vector[N] yrep;
  {
    vector[N] yhat = mu + aEC2[EC2];
    for (n in 1:N){
      log_likelihood[n] = normal_lpdf(y[n] | yhat[n] , sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}