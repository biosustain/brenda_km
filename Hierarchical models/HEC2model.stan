data {
  int<lower=1> N;
  int<lower=1> I;
  int<lower=1> J;
  int<lower=1,upper=I> EC3[N];
  int<lower=1,upper=J> EC4[N];
  int<lower=1,upper=I> parent_of_EC4[J];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> tauEC3;
  vector<lower=0>[I] tauEC4;
  vector[I] aEC3_z;
  vector[J] aEC4_z;
}
transformed parameters {
  vector[I] aEC3 = aEC3_z * tauEC3;
  vector[J] aEC4 = aEC4_z .* tauEC4[parent_of_EC4];
}
model {
  // non-hierarchical priors
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);
  tauEC3 ~ normal(0, 1);
  tauEC4 ~ normal(0, 1);
  //hierarchical priors
  aEC3_z ~ normal(0, 1);
  aEC4_z ~ normal(0, 1);
  // likelihood
  if (likelihood == 1){
    vector[N] yhat = mu + aEC3[EC3] + aEC4[EC4];
    y ~ normal(yhat, sigma);
  }
}
generated quantities {
  vector[N] log_likelihood;
  vector[N] yrep;
  {
    vector[N] yhat = mu + aEC3[EC3] + aEC4[EC4];
    for (n in 1:N){
      log_likelihood[n] = normal_lpdf(y[n] | yhat[n] , sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}