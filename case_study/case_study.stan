functions{
#include dxdt.stan
}
data {
  int<lower=1> N;
  array[N] real timepoints;
  vector[162] p;
  vector[30] x0;
  vector[7] ct;
  real rel_tol;
  real abs_tol;
  int max_num_steps;
}
transformed data {
  vector[30] vol_by_conc = [
    p[11], p[10], p[10], p[11], p[10], p[11], p[11], p[11], p[10], p[11], p[10],
    p[10], p[10], p[10], p[11], p[10], p[11], p[11], p[10], p[11], p[10], p[11],
    p[11], p[10], p[11], p[10], p[11], p[10], p[11], p[11]
  ]';
}
generated quantities {
  array[N+1] vector[30] x_c;
  array[N+1] vector[30] x;
  x[1] = x0;
  x[2:] = ode_bdf_tol(dxdt, x0, 0, timepoints, rel_tol, abs_tol, max_num_steps, ct, p);
  for (n in 1:N+1) x_c[n] = x[n] ./ vol_by_conc;
}

