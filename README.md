# MixtureIS
Codes for replicating some of the experiments of the paper _Bayesian Cross-Validation and Importance Sampling_. 

- For a pedagogical walk trough of the construction of the estimator read [**tutorial.md**](https://github.com/luchinoprince/MixtureIS/blob/main/tutorial.md). 

- To test the estimator, together with some of the competing ones in the paper, in a toy-setting where closed form solutions of the quantities are available, one can run [**Gaussian_Simulated.ipynb**](https://github.com/luchinoprince/MixtureIS/blob/main/Gaussian_simulated.ipynb). Note that in this notebook we leverage the module [**models.py**](https://github.com/luchinoprince/MixtureIS/blob/main/models.py) which guarantee more robust numerical behaviours and efficiency. 

- To replicate some of the results on the high-D logistic models in **R** refer to the folder [R_codes](https://github.com/luchinoprince/MixtureIS/tree/main/R_codes). For some information regarding the code and the datasets available there look at [**Guide.md**](https://github.com/luchinoprince/MixtureIS/blob/main/R_codes/guide.md).
