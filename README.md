# CPsyCoun
CPsyCoun: A Report-based Multi-turn Dialogue Reconstruction and Evaluation Framework for Chinese Psychological Counseling

## Method

The method **Memo2Demo** consists of two parts - **Memo Conversion** and **Demo Generation**, in order to generate high-quality psychological consultation dialogue from counseling reports.

![Memo2Demo](Fig/Memo2Demo.png)

### CPsyCounD

The high-quality multi-turn dialogue dataset, which has a total of **3,134 multi-turn consultation dialogues**. 
* For more details, please refer to the [CPsyCounD](CPsyCounD/README.md).

## Evaluation Framework

### Evaluation Metrics

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

### Turn-Based Dialogue Evaluation

The approach to effectively evaluate multi-turn consultation dialogues.

Denote a $m$-turn dialogue as a set of paired elements $\{(q_i,r_i)|i=1, 2, ..., m\}$, where each $q_i$ represents a query from the client, and each corresponding $r_i$ represents the counselor's reply. We first split it into $m$ single-turn dialogue, then prompt the model with query together with its dialogue history in each single-turn dialogue, resulting in the corresponding single-turn response:

$$
\hat{r}_i=\begin{cases}\quad f_{LLM}(q_i),&i=1\\f_{LLM}(h_i,q_i),&1<i\leq m\end{cases}
$$

where $h_i=\{(q_j, r_j)|j=1, 2, ..., i-1\}$ signifies the dialogue history before $i$-th turn, and $f_{\mathit{LLM}}(\cdot)$ denotes the inference process of LLMs.

Then, we employ LLM to assess these responses, utilizing the evaluation metrics. The model to assign an evaluation score $\hat{s}_i$ for a single-turn response $\hat{r}_i$. Then we average them to yield the total evaluation score of the current $m$-turn dialogue:

$$
s_i=\frac{1}{m}\sum_{i=1}^m\hat{s}_i
$$

### CPsyCounE

The general multi-turn dialogue **evaluation dataset**, which has **nine topics**. 
* For more details, please refer to the [CPsyCounE](CPsyCounE/README.md).

