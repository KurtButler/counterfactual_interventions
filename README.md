# On Counterfactual Interventions in Vector Autoregressive Models
In this repository, we provide the MATLAB code used to produce the results in our paper, "[On Counterfactual Interventions in Vector Autoregressive Models](https://arxiv.org/abs/2406.19573?context=eess.SP)," to be published in the proceedings of the 32nd European Signal Processing Conference.

> **Abstract:** Counterfactual reasoning allows us to explore hypothetical scenarios in order to explain the impacts of our decisions. However, addressing such inquires is impossible without establishing the appropriate mathematical framework. In this work, we introduce the problem of counterfactual reasoning in the context of vector autoregressive (VAR) processes. We also formulate the inference of a causal model as a joint regression task where for inference we use both data with and without interventions. After learning the model, we exploit linearity of the VAR model to make exact predictions about the effects of counterfactual interventions. Furthermore, we quantify the total causal effects of past counterfactual interventions. 


## Instructions
To run the code, simply run `main.m` using Matlab. We used Matlab 2022a at the time of writing. 

## Citation
If you use our code or results from this project in your academic work, please consider citing our paper:
```
@article{butler2024counterfactual,
  title={On Counterfactual Interventions in Vector Autoregressive Models},
  author={Butler, Kurt and Iloska, Marija and Djuri{\'c}, Petar M},
  journal={arXiv preprint arXiv:2406.19573},
  year={2024}
}
```
