# CPsyCoun

**CPsyCoun: A Report-based Multi-turn Dialogue Reconstruction and Evaluation Framework for Chinese Psychological Counseling**

## 🔥News

* **[May. 2024]**: Our paper has released on [arXiv](https://arxiv.org/abs/2405.16433) , check it out!
* **[May. 2024]**: **CPsyCoun** has been accepted to **2024 ACL** ***Findings***!
* **[Apr. 2024]**: **CPsyCoun** has been used in [EmoLLM ![img](https://img.shields.io/github/stars/SmartFlowAI/EmoLLM?style=social)](https://github.com/SmartFlowAI/EmoLLM), welcome!

## Method

### CPsyCoun Framework

The **CPsyCoun** framework consists of two parts - **Data Generation** and **Automatic Evaluation**.

![Framework](Fig/Framework.png)


### Dialogue Reconstruction

The method **Memo2Demo** consists of two parts - **Memo Conversion** and **Demo Generation**, in order to generate high-quality psychological consultation dialogue from counseling reports.

![Memo2Demo](Fig/Memo2Demo.png)

#### Counseling Report

Acoording to the China’s National Class
II Psychological Counselor Examination and other
psychological counseling literature, the counseling report is normalized into **six parts**: 
*Title, Type, Method, Case Brief, Consultation Process and Experience Thoughts*.

* An example of counseling report 

![Counseling_Report](Fig/Counseling_Report.png)

#### CPsyCounD

The high-quality multi-turn dialogue dataset, which has a total of **3,134 multi-turn consultation dialogues**. 
* For more details, please refer to the [CPsyCounD](CPsyCounD/README.md).


### Evaluation Framework

#### Evaluation Metrics

* **Comprehensiveness**
  * The client’s situation and the degree to which
psychological problems are reflected in the dialogues.
* **Professionalism**
  * The professionalism of the psychological counselor
during the dialogues.
* **Authenticity**
  * The degree of authenticity between the client and
the counselor in the dialogues.
* **Safety**
  * The degree of privacy protection of clients.

#### Score Criterion

* The score criterion of each evaluation metric

![Score Criterion](Fig/Score_Criterion.png)

#### Turn-Based Dialogue Evaluation

**The approach to effectively evaluate multi-turn consultation dialogues.**

Denote a $m$-turn dialogue as a set of paired elements $\{(q_i,r_i)|i=1, 2, ..., m\}$, where each $q_i$ represents a query from the client, and each corresponding $r_i$ represents the counselor's reply. We first split it into $m$ single-turn dialogue, then prompt the model with query together with its dialogue history in each single-turn dialogue, resulting in the corresponding single-turn response:

![math_1](Fig/math_1.png)

where $h_i=\{(q_j, r_j)|j=1, 2, ..., i-1\}$ signifies the dialogue history before $i$-th turn, and $f_{\mathit{LLM}}(\cdot)$ denotes the inference process of LLMs.

Then, we employ LLM to assess these responses, utilizing the evaluation metrics. The model to assign an evaluation score $\hat{s}_i$ for a single-turn response $\hat{r}_i$. Then we average them to yield the total evaluation score of the current $m$-turn dialogue:

![math_2](Fig/math_2.png)

* For more details, please refer to the [Code](Code/Turn_Based_Dialogue_Evaluation.ipynb).

#### CPsyCounE

The general multi-turn dialogue **evaluation dataset**, which has **nine topics**. 
* For more details, please refer to the [CPsyCounE](CPsyCounE/README.md).


### Experiments

#### Intrinsic Evaluation

##### Role-play VS Memo2Demo

* Statistics of generated dialogues

![Statistics](Fig/Experiment_1.png)

* The results of intrinsic evaluation

![Intrinsic evaluation](Fig/Experiment_2.png)


#### Extrinsic Evaluation

##### CPsyCounX

We further fine-tune **InternLM2-7B-Chat** on **CPsyCounD**. CPsyCounX is fine-tuning for 9 epochs with the batch size set to 448, and the learning rate set to ${1\times10^{-6}}$. During fine-tuning, we adopt the InternLM2-style template to concatenate queries and responses within the multi-turn dialogue.
* For more details, please refer to the [Code](Code/sft_CPsyCounX.sh).

##### Results

* The average results of extrinsic evaluation

![Extrinsic evaluation](Fig/Experiment_3.png)

* Radar plot of detailed scores of CPsyCounX and other baselines

![Radar plot](Fig/Experiment_4.png)

* The full results of extrinsic evaluation

![Full results](Fig/Experiment_5.png)


## Citation

If you find our work helpful in your research, please cite the following paper:

```
@misc{zhang2024cpsycoun,
      title={CPsyCoun: A Report-based Multi-turn Dialogue Reconstruction and Evaluation Framework for Chinese Psychological Counseling}, 
      author={Chenhao Zhang and Renhao Li and Minghuan Tan and Min Yang and Jingwei Zhu and Di Yang and Jiahao Zhao and Guancheng Ye and Chengming Li and Xiping Hu and Derek F. Wong},
      year={2024},
      eprint={2405.16433},
      archivePrefix={arXiv},
      primaryClass={cs.CL}
}
```
