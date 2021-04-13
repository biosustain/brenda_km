data {
  int<lower=1> N;
  int<lower=1> N_ec4;
  int<lower=1> N_ec3;
  int<lower=1> N_ec2;
  int<lower=1> N_subs;
  int<lower=1> N_superking;
  int<lower=1> N_family;
  int<lower=1> N_genus;
  int<lower=1> N_species;
  int<lower=1,upper=N_ec4> ec4[N];
  int<lower=1,upper=N_ec3> ec3[N];
  int<lower=1,upper=N_ec2> ec2[N];
  int<lower=1,upper=N_subs> subs[N];
  int<lower=1,upper=N_superking> superking[N];
  int<lower=1,upper=N_family> family[N];
  int<lower=1,upper=N_genus> genus[N];
  int<lower=1,upper=N_species> species[N];
  vector[N] y;
  int<lower=0,upper=1> likelihood;
  vector[2] prior_mu;
  vector[2] prior_nu;
  vector[2] prior_sigma;
  matrix[8,2] prior_tau;
}
parameters {
  real<lower=1> nu;
  real mu;
  real<lower=0> sigma;
  real<lower=0> tau[8];
  vector<multiplier=tau[1]>[N_ec4] a_ec4;
  vector<multiplier=tau[2]>[N_ec3] a_ec3;
  vector<multiplier=tau[3]>[N_ec2] a_ec2;
  vector<multiplier=tau[4]>[N_subs] a_subs;
  vector<multiplier=tau[5]>[N_superking] a_superking;
  vector<multiplier=tau[6]>[N_family] a_family;
  vector<multiplier=tau[7]>[N_genus] a_genus;
  vector<multiplier=tau[8]>[N_species] a_species;
}
model {
  mu ~ normal(prior_mu[1], prior_mu[2]);
  nu ~ gamma(prior_nu[1], prior_nu[2]);
  sigma ~ lognormal(prior_sigma[1], prior_sigma[2]);
  tau ~ lognormal(prior_tau[,1], prior_tau[,2]);
  a_ec4 ~ normal(0, tau[1]);
  a_ec3 ~ normal(0, tau[2]);
  a_ec2 ~ normal(0, tau[3]);
  a_subs ~ normal(0, tau[4]);
  a_superking ~ normal(0, tau[5]);
  a_family ~ normal(0, tau[6]);
  a_genus ~ normal(0, tau[7]);
  a_species ~ normal(0, tau[8]);
  if (likelihood){
    y ~ normal(mu
               + a_ec2[ec2]
               + a_ec3[ec3]
               + a_ec4[ec4]
               + a_subs[subs]
               + a_superking[superking]
               + a_family[family]
               + a_genus[genus]
               + a_species[species], sigma);
  }
}
generated quantities {
  vector[N] llik;
  vector[N] yrep;
  {
    vector[N] yhat =
      mu
      + a_ec2[ec2]
      + a_ec3[ec3]
      + a_ec4[ec4]
      + a_subs[subs]
      + a_superking[superking]
      + a_family[family]
      + a_genus[genus]
      + a_species[species];
    for (n in 1:N){
      llik[n] = normal_lpdf(y[n] | yhat[n], sigma);
      yrep[n] = normal_rng(yhat[n], sigma);
    }
  }
}
