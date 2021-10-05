/* Model extending the one in the paper

- Borger, S., Liebermeister, W., & Klipp, E. (). Prediction of Enzyme Kinetic
  Parameters Based on Statistical Learning. , (), 8.

*/

data {
  int<lower=1> N;             // number of measurements
  int<lower=1> N_natural;
  int<lower=1> N_biology;     // instantiated biological categories
  int<lower=1> N_sub;
  int<lower=1> N_ec_sub;
  int<lower=1> N_org_sub;
  int<lower=1,upper=N_ec_sub> ec_sub[N_biology];
  int<lower=1,upper=N_org_sub> org_sub[N_biology];
  int<lower=1,upper=N_sub> substrate[N_biology];
  vector[N] y;
  vector[N] is_natural;
  array[N] int<lower=1,upper=N_biology> biology;
  int<lower=0,upper=1> likelihood;
}
parameters {
  vector[N_sub] a_sub;
  vector[N_ec_sub] a_ec_sub;
  vector[N_org_sub] a_org_sub;
  real<lower=1> nu;
  real<lower=0> sigma;
  real<lower=0> tau_ec_sub;
  real<lower=0> tau_org_sub;
  real<lower=0> tau_log_km;
  vector[N_biology] log_km;
}
model {
  if (likelihood){
    y ~ student_t(nu, log_km[biology], sigma);
  }
  log_km ~ normal(a_sub[substrate]
                  + a_ec_sub[ec_sub]
                  + a_org_sub[org_sub], tau_log_km);
  nu ~ gamma(2, 0.1);
  a_sub ~ normal(-1, 2);
  a_ec_sub ~ normal(0, tau_ec_sub);
  a_org_sub ~ normal(0, tau_org_sub);
  tau_log_km ~ normal(0, 2);
  tau_org_sub ~ normal(0, 2);
  tau_ec_sub ~ normal(0, 2);
}
generated quantities {
  vector[N_natural] llik;
  {
    int i = 1;
    for (n in 1:N){
      if (is_natural[n]){
        llik[i] = student_t_lpdf(y[n] | nu, log_km[biology[n]], sigma);
        i += 1;
      }
    }
  }
}
