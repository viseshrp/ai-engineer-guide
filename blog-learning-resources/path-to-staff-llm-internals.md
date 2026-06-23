# Everything a Senior Engineer Needs to Know About What's Inside an LLM

Source: Path to Staff Engineer  
Author: Sidwyn Koh  
Published: June 20, 2026  
URL: <https://www.pathtostaff.com/p/everything-a-senior-engineer-needs?utm_source=tldrdev>

Note: This Markdown file was formatted from user-provided pasted text. Site chrome, subscribe prompts, and unrelated footer content were removed. Figures and formulas that were not fully preserved in the pasted text are marked inline.

Learn what AI models are made of

Sidwyn Koh  
Jun 20, 2026

Welcome back to Path to Staff! This series is a little different from our usual programming. In this series, we're covering LLMs and AI in-depth.

As an engineer, I never really had the time to understand AI's internals. But I've spent the past few weeks doing deep research to unpack it all.

As a reminder, this is Part Two of a five-part series:

- The Hardware Behind AI - And How It's Programmed. Transistors, semiconductors, and fabricators. Learn about the big players (TSMC, Nvidia, ASML). The memory-compute bottleneck. And all the acronyms you always wondered about (TPU, ASIC, FPGA, CUDA, etc.)
- Model Architecture. (We are here.) Learn about what models are made of. We'll cover the paper that started it all ("Attention Is All You Need"), plus talk about transformers and diffusion models.
- Training. The meat of teaching a model. How does pretraining work? What goes into it (backpropagation, optimizers, loss functions)? What scaling laws should we weigh before we kick off an expensive training run (up to hundreds of millions of dollars)?
- Post-Training & Alignment. How does one guide a model once it's been taught? How do we apply safety? How do we benchmark and know the model got better? How do we evaluate a model's performance?
- Inference, Serving and Agents. This might be the most familiar topic, since it's closest to you as an AI user. How does a model output its token and serve the result to you (SSE)? How do systems stay fair and fast? What tools are available (MCP, RAG, tool use) and how do agents work?

## Recurrent Neural Networks are No Longer Popular

I remember taking CS:188 by Pieter Abbeel at Berkeley, learning about Recurrent Neural Networks (RNNs) in 2014. I wish I'd paid more attention in class, but it was still a good foundation for working on this chapter.

To my surprise, RNNs are less popular today. And there's a good reason for that.

If you haven't studied neural networks before, you should know that a neural network looks at an input, guesses what it is, then immediately forgets it. The simplest form is a feed-forward neural net, where the data goes through and outputs as a layer at the end.

Recurrent neural networks take this one step further, with a built-in memory loop. It looks at the first word, jots it down in a hidden notebook (or layer), and then reads the second and jots it down again. This repeats over and over again. The downside is that it has terrible long-term memory, and would only remember what was most recently fed.

[Figure omitted: RNN reading "The cat sat on the mat" one word at a time.]

An RNN reads "The cat sat on the mat" one word at a time - its memory of "The" has almost faded by "mat".

Upgraded versions of RNNs called LSTM (Long Short-Term Memory) and GRUs (Gated Recurrent Units) were implemented to highlight important memories, but there were still two key problems with these recurrent neural networks.

They were:

- Sequential bottleneck: You can't compute the next step in a recurrent neural network till the current operation is complete. This means there's no way to parallelize training. A sequence of length N takes N sequential steps no matter how much hardware you throw at it. Training time was bound by the length of the chain, not the size of the chain.
- Long-range decay: information from early tokens fades before it reaches later ones, as seen in the image above. Training an RNN means backpropagating the signal through every step, multiplying by the same weights each time. So over a long sequence the gradient vanishes to zero or explodes, and the model can't learn that an early token should shape a much later one.

## Enter Transformers

In 2014, Bahdanau et al. added a different concept to neural networks, called attention. Rather than force the whole input through one fixed summary, let the model look back at every input token and weight the ones that matter for the current step. Simplified, when generating a new token, the model looks back at all the previous tokens to generate a vector for each of them.

It worked well, and took an important step toward the transformer. However, it was still bolted onto a recurrent network, so the sequential bottleneck remained.

Three years later, Vaswani et al. made a large leap: keep the attention, drop the recurrence entirely. Their insight was that self-attention, where every token computes its relationship to every other token through dot products, solves both problems (sequential bottleneck and long-range decay) at once.

With matrix multiplication happening over all pairs simultaneously, the whole sequence can now be processed in parallel rather than step by step. And with no recurrent chain, there's no information left to decay.

[Figure omitted: RNN chain versus self-attention all-to-all comparison.]

The same five tokens with two ways to handle them. In RNN mode: it passes information hand-to-hand down a chain, so it runs one step at a time and the earliest signal fades by the end. Self-attention connects every token to every other at once. This is fully parallel, with nothing left to decay.

Eight Google researchers laid this out in a paper titled "Attention Is All You Need". The architecture they proposed within is called the transformer.

At first, they built it to improve machine translation, but they already saw further, noting in the paper that the same architecture should extend to other tasks. They were not wrong.

## An Overview of Transformers

A transformer is a neural network that processes sequences.

An input goes in, passes through N identical blocks and a prediction head converts it into an output.

A prediction head is a translator at the end of the model that turns the model's numbers into a score for every word. These raw scores are called logits.

There are different types of transformers. Let's first look at an example of translating a sentence. You have an input that gets read, which gets translated to an output.

Say you want to translate "The cat sat on the mat" to Chinese. This goes from "The cat sat on the mat" to "猫坐在垫子上".

In this case, we are using an encoder-decoder architecture. The encoder reads the input, while the decoder generates output.

[Figure omitted: encoder-decoder transformer architecture.]

Now remember that the authors were solving machine translation. However, the AI field took this architecture apart and found that the halves were independently useful. Google used the encoder, trained it to understand text, and got BERT (Bidirectional Encoder Representations from Transformers), released in 2018.

By 2019, it was rolled into the ranking backend of Google Search. It was able to understand each word in context with all other words simultaneously. It was incredibly good at understanding context, and so most researchers would use it for sentiment analysis, or for named entity recognition.

Google also worked on decoders, but it worked towards Generating Wikipedia by Summarizing Long Sequences. Then Alec Radford at OpenAI took the same move, but in a different, important direction: combining the decoder-only transformer with his generative-pretraining thesis.

In Improving Language Understanding by Generative Pre-Training, Alec et al. argue that raw text is everywhere, but text that's been labeled for a specific task (like "this review is positive") is rare and expensive, which limits models that can only learn from labeled examples.

To fix this, let a model learn language broadly by reading a huge pile of unlabeled text, then give it a small amount of labeled data to specialize on a particular task. That two-step recipe produces big improvements.

## Enter GPT

These two steps are known as:

- Generative pre-training (GPT, anyone?) - read unlabeled text
- Fine-tuning - specialize on a particular text

This generative pre-training is the first step of an AI model, where it is trained on a massive general dataset to learn general-purpose representations and patterns (think grammar, language, reasoning).

Alec, together with Karthik Narasimhan, Tim Salimans and Ilya Sutskever, came up with GPT-1 in June 2018, a decoder-only transformer.

While Google was doubling down on BERT, OpenAI doubled down on Generative Pre-Training (GPT), pushing out GPT-2 in 2019 with the same architecture but roughly 10x the parameters and data. Now, the model could start doing tasks zero-shot from prompting, without any fine-tuning. GPT-3 in 2020 scaled another 100x.

What happened to the fine-tuning step? By GPT-3, the model showed that it mostly didn't need it. A big enough model was smart enough to understand most tasks from a prompt alone. More work was put into post-training, which we will cover in a future chapter.

## Encoder Only vs Encoder-Decoder Models

Now, it is important to understand why GPTs (decoder-only transformers) became much more popular than say the encoder-decoder or the encoder model.

Three reasons:

- A decoder trains on predicting the next token. This requires no labels and task-specific setup. This meant that the entire internet corpus becomes training data.
- The objective was universal. You could use it for translation (e.g. "continue this text"), summarization ("summarize this text"), etc. All of these reduced to continuation. On the other hand, BERT could never be prompted this way.
- Why it beat encoder-decoder models: There was just no input sometimes. Inputs work for translation, but there's no clear input in a multi-turn conversation. Having both an encoder and a decoder also meant cross-attention added more surface area to the model. This also resulted in more ways for a training run to go wrong.

If you want to see how far the decoder family tree has branched - LLaMA, Mistral, DeepSeek, Qwen, and the architectural deltas between them - Sebastian Raschka maintains an excellent visual gallery of LLM architectures.

From here on, we'll zoom into the decoder-only stack - the architecture behind GPT-style models - and walk through what happens inside it, one component at a time.

## Turning Text into Numbers

In this section, we'll also learn why the model keeps getting "how many r's in strawberry" wrong. Yes, it has to do with tokenization.

If a transformer operates on sequences of vectors, how do we turn text into numbers? How does "The cat sat" turn into vectors? This is also known as tokenization, because we are breaking down a sentence into individual tokens.

What are simple ways to break up a sentence into tokens? Here's a few:

- Words: "The", "cat", "sat" are all valid words in the dictionary. However, unknown words have to be represented by "<UNK>", where UNK stands for unknown. And when we decode and encode that word, we lose precision.
- Characters. Every character gets represented, however it is a lot longer than what we need.
- Subwords. Can we break up a word like "misrepresented" as "mis", "represent" and "ed", to individual tokens? This is the key idea behind Byte-Pair Encoding, which was actually invented in 1994.

BPE was invented by Philip Gage for data compression, and was brought to NLP in 2016 by Sennrich et al. for machine translation.

Let's take a look:

[Figure omitted: BPE merge example.]

BPE on our sentence: after three merges, "at", "th" and "the" have joined the vocabulary. Real tokenizers keep going to around 32k-200k.

The steps are simple:

1. Start with a base vocabulary of individual characters.
2. Count every adjacent pair of tokens.
3. Find the most frequent pair, and merge it into a new token, adding it to the vocabulary.
4. Repeat step 2-3 until the vocabulary hits your target size (which is a model hyperparameter, typically around 32-200k).

Now, BPE has evolved a little more than that into byte-level BPE. In GPT-2, BPE is run over raw bytes, so that the base vocab is exactly 256 symbols and every possible string (across languages) is just some sequence of bytes.

## Where BPE falters

There are a couple of places where BPE falters. Here's three of them:

- Token spelling: "How many r's are there in strawberry?" This is hard for a model because it could have broken out "straw" and "berry" into two different tokens, say token 2516 and 426. There would be no way for the model to know the spelling of token 426.
- How this was fixed: Reasoning (model actually decomposes the word), memorization (remembering that strawberry has 3 "r"s), and tool use (model writes code to count the number - do you see ChatGPT or Claude sometimes suddenly writing code to answer a math problem? Well, this is why.)
- Arithmetic: Asking a model to do math is hard because digits are arbitrarily chunked. This was fixed by splitting digits into their own tokens.
- Multilingual cost inequality: While in English tokens cost roughly 4 characters each, other languages may cost more tokens per character. This is definitely trickier.
- How this was fixed: Well, it's still ongoing, but OpenAI's GPT-4o tokenizer (o200k) doubled the vocabulary to 200k tokens and dramatically reduced token counts for non-English languages, letting them fit more words into the mix.

There's also been new advances in this space, such as ByT5 and the Byte Latent Transformer (Meta, 2024), which operate on raw bytes, learning to group bytes into variable-size patches. This is an interesting frontier, but for the sake of this article, will be left as extra reading.

## From Token IDs to Meaning: Embeddings

So tokenization gives us integers. But a token ID like 1024 is just a row number - it doesn't mean anything by itself.

The thing that gives it meaning is a giant lookup table called the embedding matrix: one row per vocabulary entry, where each row is a long vector of numbers.

The length of that row is the model's hidden size - in many 7B-class models, that's 4,096 numbers per token (our running example uses the original paper's 512). That's a crazy large number, but if you think about it, it could actually encode a lot of information.

Can a model encode too much information? Yes, in the sense of waste. A wider hidden size gives each token more room to store features, but past a point you get diminishing returns, where extra dimensions end up redundant or near-empty.

Let's work through an example.

When the tokenizer hands the model the ID for "cat", the model looks up that row and works with the vector instead. Here's the magical part... nobody designs these vectors.

They're learned during training, and semantically similar tokens end up close together in space - "cat" lands near "kitten", "mat" near "rug". The geometry even supports arithmetic: the famous example is king - man + woman approximately queen.

[Figure omitted: 2D embedding intuition.]

In this image, we've squashed our vector size to 2 dimensions. Take note that there are up to 4,096 dimensions as mentioned above.

However, there's one thing the embedding does not carry: position within a sentence. The vector for "cat" is identical whether "cat" is the first word of your prompt or the fiftieth.

## Positional Encoding

Now in order for encoders and decoders to understand order in a sentence, we have positional encoding. This is placed at the start of the Encoder and Decoder stacks, immediately after raw tokens are converted into word embeddings, and before the Attention layers.

[Figure omitted: where positional encoding sits in the stack.]

Now for our same example, we need to distinguish between "The cat sat on the mat." and "The mat sat on the cat." To do this, we need each word's position. For instance:

- Position 0: "The"
- Position 1: "cat"
- Position 2: "sat"
- Position 3: "on"
- Position 4: "the"
- Position 5: "mat"

The model handles this by generating a unique positional vector for each index and merging it with the word vector.

- Positional Vector: A 512-length vector is generated specifically for Position 1. We used sine and cosine waves in 2017 since they would fluctuate strictly between -1 and 1 and would not overpower the actual meaning of words.
- Word Vector: The word "cat" is converted into a 512-length vector representing its semantic meaning.

## Limitations of Sine & Cosine Waves

However, there were limits to these sine and cosine waves for positional vectors. There were three key reasons:

- Corruption of word semantics: The sinusoidal method adds position directly into a token's meaning. We'd rather have a way to encode position into a vector's angle, preserving its length and not distorting the original features.
- Generalized sequence lengths: Positions are limited by the inputs. E.g. if you trained an LLM on 4000 token limits, it would not understand positioning for slots 4001 and beyond.
- Relative text shifts: Sometimes the same grammatical phrase occurs at different places in a text. The math with positional encoding leaves behind absolute room numbers that change the final score based on where the phrase sits in the document. Often all we want is the relative position, not the absolute one.

We look at Rotary Positional Encoding (RoPE, proposed by Su et al. in 2021) to solve this. It gets a little deep here, so I'll try to simplify: Instead of changing a word's vector by adding position numbers to it, RoPE injects order by physically rotating the vectors in a mathematical space based on their position index.

[Figure omitted: RoPE as rotation metaphor.]

RoPE turns position into rotation: the hand's length (meaning) never changes, only its angle (position).

Think of each word as a clock hand. The hand's length is the word's meaning which never changes. Its angle is the position: "cat" at position 1 gets rotated a little, "mat" at position 5 gets rotated more.

Now this way, we have a much better way to represent token positions.

## Is Attention All We Really Need?

In 2017, eight researchers at Google were racing to finish a paper for NIPS, the field's biggest conference, before the deadline. The work was done. The architecture that would reorganize all of AI was sitting in the draft. What they didn't have was a title.

Then, Llion Jones, the Welsh researcher among them, threw one out almost as a joke: after the Beatles' "All You Need Is Love," why not "Attention Is All You Need"? He didn't expect the team to keep it, but - they kept it.

And the joke turned out to be the most honest summary. Where everyone else was bolting attention onto recurrent networks, this paper deleted the recurrence and kept only attention.

Heads up: There's going to be a lot of math in the next few sections. Take your time to digest them, and use your favorite AI to break it down for you. I recommend understanding this formula in-depth because it is the basis of today's LLM models.

Let's now take a look at the key paper: Attention Is All You Need. Most importantly, look at this formula in Section 3.2.1: Scaled Dot-Product Attention:

[Formula omitted from pasted text.]

I know this formula looks scary if you haven't seen it before, but let's walk through it together with an example.

The key thing to note is that instead of RNNs reading one word at a time, we are going to have a sentence where each token looks at every other token.

Back to our favorite example: The cat sat on the mat.

[Figure omitted: attention scores for "sat".]

"sat" attends to every token. If you look at those with the highest scores, it's what's relevant to "sat". For instance: who sat? "cat" (0.42). Sat where? "mat" (0.30).

Now each token gets broken down into three vectors:

- Query: What am I looking for from other tokens?
- Key: What can I give to other tokens looking at me?
- Value: What gets passed along when I match with other tokens?

Remember matmuls from the first chapter? Here's where they come into play. Every token's Query is going to be dot-producted with the Key of each other token, to produce a score. These are all values that have been initialized to random weights.

This calculation is QK^T, where K^T just means the K matrix transposed (flipped along its diagonal). We do this to produce a similarity score.

[Figure omitted: Step 1 scaled dot-product.]

Step 1: "sat"'s Query dot-producted with every Key, then divided by sqrt(dk).

We then divide by sqrt(dk). This refers to the key dimension (e.g. if the Key is [0.1, -0.5, 0.9, 0.2], the dimension is 4, and the sqrt of that is 2).

The reason we do this is that dot products of bigger vectors produce bigger numbers: the variance of the dot product of two random dk-dimensional vectors grows to dk, so dividing by sqrt(dk) brings the scores back to a sane scale before they hit the softmax.

Then we need to convert these scores to probabilities.

To do this, we use the softmax function. Softmax exponentiates each score and normalizes.

The reason for the exponent is to eliminate negative numbers, since e raised to any power is always positive.

[Figure omitted: Step 2 softmax normalization.]

Step 2: softmax exponentiates and normalizes - each row becomes a probability distribution.

Now last but not least, we have to multiply the weights by the Value matrix. This focuses the model on the most compatible and valuable keys, producing a context-aware representation of each token.

[Figure omitted: Step 3 weighted value sum.]

Step 3: each token's Value is scaled by its attention weight and summed - "cat" and "mat" dominate the blend that becomes the new vector for "sat".

The best part of all is that this is all happening in parallel, which is why GPUs have become so popular.

## Multi-Head Attention

Now to take this even more parallel, we can split up the vector dimension into multiple smaller vectors. Each of these smaller vectors is a head. In the paper, the model's total vector dimension was set to 512, split into 8 heads of 64 dimensions each. Each head learns to look for something different: one might track which noun a word refers to, another might track syntax.

[Figure omitted: 512 dimensions split into 8 heads.]

The 512-dimensional vector is split into 8 heads of 64 dims each. The heads run in parallel, then their outputs are concatenated back into a single 512-dim vector.

That 64 turns out to be a very hardware-friendly number. Remember GPU warps from the first chapter? A warp is a group of 32 threads executing in lockstep, so a 64-dimensional head divides cleanly across warps. These days, AI engineers choose the head dimension - usually 64, 128 or 256 - to align with the GPU's Tensor Cores.

What do thousands of heads actually learn? Anthropic's interpretability team found induction heads - heads that spot the pattern "A B ... A" in your prompt and predict B comes next. They're one of the clearest known mechanisms behind in-context learning, where the model picks up a pattern from your prompt and continues it.

[Figure omitted: induction head pattern.]

An induction head spots that the current token already appeared earlier, then predicts whatever followed it last time - "A B ... A" -> B.

## Masking Matrices

Now in the last part of Section 3.2.3 in the paper, there's a key sentence here: "We implement this inside of scaled dot-product attention by masking out (setting to -infinity) all values in the input of the softmax which correspond to illegal connections."

We have another step here: to apply a mask matrix (kind of like a mask in Photoshop).

This ensures that only past and present words can be seen, and that the model cannot cheat by looking ahead during training. This is also known as autoregression in statistics.

## Why The Context Window Matters

Here's a crucial property of attention: its computational cost scales quadratically, O(N^2), with the sequence length. E.g. if you double your prompt from 100 to 200 tokens, the compute and memory for attention quadruples.

This is why context windows exist at all. Every new token has to attend to every token before it, and the model has to keep all those Keys and Values around in memory (the "KV cache").

With RoPE, there's a second ceiling: positional coordinates only stretch as far as you've trained them. A model trained on 4,000-token sequences has simply never seen a rotation angle for position 50,000. So the context window is bounded by both compute and the positional encoding's training range.

One more wrinkle: even within the window, attention isn't spread evenly. Researchers documented a "lost in the middle" effect - models use information at the start and end of long prompts far more reliably than information buried in the middle. This is why prompt tips like "put the important context first" or "repeat the key instruction at the end" work well.

## The Other Important Blocks

Let's go back to the transformer architecture. Attention gets all the headlines (and the paper title), but if you look at the diagram, there are still several other important blocks.

[Figure omitted: remaining transformer blocks.]

## Add & Norm

This pair shows up after every attention unit and every feed-forward unit, and it does two jobs.

Adding: the block's output (the residual) is added back to its input. This is to make sure that gradients don't vanish halfway through a deep stack (just like how they did in RNNs). Think of it as a gradient highway: even if one layer learns nothing useful, the signal can flow straight through the addition unharmed. This trick came from ResNet in computer vision, and it's a big part of why we can train models hundreds of layers deep.

Normalization: after all that adding, we rescale each token's vector to mean 0 and variance 1, to make sure we don't blow numbers out of proportion.

The formula, if you were interested, is:

[Formula omitted from pasted text.]

Reading it left to right: x is the token's incoming vector. Mu is the mean of its values and sigma their standard deviation, both computed per token across the vector's own dimensions (not across the batch). Subtracting mu then dividing by sigma re-centers the vector to mean 0 and variance 1.

But forcing every vector to look statistically identical is too rigid, so we hand back two learned knobs: gamma rescales the spread and beta shifts the center, and the model figures out the right values for each during training.

Modern models like Llama use a leaner cousin called RMSNorm (skip subtracting the mean, just divide by the magnitude), and apply it before each unit rather than after - "pre-norm" - because it trains more stably.

## Feed-Forward Network

In this unit, each token digests what happened during attention. It takes its current vector and blows it up to 4x the width, before squashing it back down:

[Figure omitted: FFN expansion and contraction.]

The FFN blows each token's vector up 4x, bends it, and squashes it back. No token-to-token communication.

Why do we do this? When we blow up the vector, we can analyze it across many more dimensions. Think of a detective who empties a cramped case folder out across a huge table: in the original 512 dimensions, clues are stacked on top of each other and hard to tell apart, but spread across 2048 dimensions each pattern gets its own bit of room.

Now, there is no token-to-token communication here. This all happens within one token.

That GELU (Gaussian Error Linear Unit) in the middle is the activation function. Modern models like Llama, Mistral and PaLM have since moved on to SwiGLU, a different variant.

Here's the part that surprised me: this boring block is where most of the model's parameters live.

For the original 512-dimension transformer, one matrix is 512x2048 and the other is 2048x512 - about 2.1M parameters per layer, roughly double what attention uses.

In modern LLMs, the feed-forward layers hold around two-thirds of all weights. There's research suggesting they act as key-value memories - this is plausibly where "Paris is the capital of France" is stored.

## The Final Linear Layer

After the final block, each token's vector gets multiplied by one last matrix (the "LM head"), producing one score per vocabulary entry - if your tokenizer has 200k tokens, that's 200k scores.

These scores are called logits, and a final softmax turns them into next-token probabilities. We'll look at this in-depth in the next essay.

## The Attention Formula

Let's wrap up. How do we write attention in code?

Well, good news. The entire attention formula fits in about a dozen lines of NumPy. Andrej Karpathy also covers this in a longer video, but here it is:

```python
import numpy as np

tokens = ["The", "cat", "sat", "on", "the", "mat"]
d_k = 4
np.random.seed(0)
E = np.random.randn(len(tokens), d_k)          # pretend embeddings
Wq, Wk, Wv = (np.random.randn(d_k, d_k) for _ in range(3))
Q, K, V = E @ Wq, E @ Wk, E @ Wv

scores = Q @ K.T / np.sqrt(d_k)                # QK^T / sqrt(dk)
mask = np.triu(np.ones_like(scores), k=1)      # hide the future
scores = np.where(mask == 1, -np.inf, scores)
weights = np.exp(scores) / np.exp(scores).sum(-1, keepdims=True)  # softmax
output = weights @ V                           # weighted sum of Values

print(np.round(weights, 2))   # each row: where that token is looking
```

That's the transformer.

Next time you watch tokens stream out of Claude, you'll know what's happening underneath: bytes merging into tokens, vectors rotating by position, and every word attending to every word that came before it.

Stay tuned for the rest of this series.

## Extra Reading Section

Because the entire essay is so long, I've left the following in an appendix here. I know most of you won't get to these, but they are very useful for understanding modern architecture.

## Grouped-Query Attention

Back to attention for now. When the model generates the token 5,001, it needs the Keys and Values of all 5,000 tokens before it. Recomputing them every step would be madness, so they're cached - per layer, per head. At long contexts, this cache can eat more VRAM than the model weights themselves.

[Figure omitted: grouped-query attention.]

The modern fix is Grouped-Query Attention (GQA): instead of every head keeping its own Keys and Values, groups of query heads share one K/V head. Llama 2 70B runs 64 query heads against just 8 shared K/V heads; Mistral 7B does 32 against 8. You keep almost all the quality of full multi-head attention with a fraction of the cache - which is why nearly every open model since 2023 ships with it.

## FlashAttention

We'll look into ways to optimize this through FlashAttention, invented by Tri Dao et al. in 2022. Remember the memory bottleneck that we explored last chapter? GPUs have a lightning-fast but tiny SRAM, and a big but slow VRAM (HBM).

[Figure omitted: FlashAttention memory traffic.]

The naive implementation computes the full N x N score table for "The cat sat on the mat", writes it out to slow VRAM, reads it back in to do the softmax, writes it out again. Now, the matrix isn't the bottleneck. The memory traffic is. How do we solve this?

With FlashAttention. The trick here is to use tiling. The sentence gets cut into small blocks, and each Streaming Multiprocessor (SM) grabs a tile - say, the Queries for "The cat" against the Keys for "the mat" - and computes that entire piece inside its local SRAM without ever writing the intermediate table out to VRAM. To keep the math correct, it accumulates running statistics locally and applies the softmax normalization exactly once at the end of each row (this is called the online softmax).

The result is the exact same answer as standard attention, just with far fewer round trips to slow memory. No approximation, just better traffic management.

There's also been further headway in this space, which I will leave as further reading:

- Linear Attention & State Space Models (Mamba): Architectures trying to replace the attention formula completely to achieve O(N) linear scaling.
- RoPE Scaling (YaRN & RoPE Interpolation): The mathematical tricks used to compress and stretch coordinate systems, letting a model trained on 4,000 tokens seamlessly read 128,000 tokens.

## Mixture of Experts (MoE)

There's a newer technique that turns a dense transformer block into a sparse network. This increases the total parameter count by hundreds of billions of weights without increasing the FLOPs spent per token. How do we do this?

We swap out the single Feed-Forward Network for a fleet of them - the "experts" - plus a tiny router in front.

[Figure omitted: MoE router selecting top experts.]

The MoE router scores all 8 experts and wakes only the top 2, while the rest of the parameters are inactive.

When a token vector enters the MoE layer, the router multiplies the token vector by its own weight matrix to score every expert, then routes the token to the top-k highest-scoring experts. Only those experts run; their outputs are summed, weighted by the router's scores. Not all the experts are activated at the same time - that's the entire trick.

The math here:

[Formula omitted from pasted text.]

So when "cat" passes through, maybe expert 3 (which has drifted towards noun-ish, animal-ish patterns during training) and expert 7 fire, while the other six sleep. You get a model with trillions of potential parameters where each token only pays for a fraction of them.

The idea dates back to Shazeer et al. in 2017 (yes, the same Noam Shazeer from Attention Is All You Need - and yes this guy just moved to OpenAI this week.), scaled up by Google's Switch Transformer. Today, Mixtral 8x7B (8 experts, top-2: 47B total parameters, only 13B active per token) and DeepSeek-V3 (256 experts plus 1 shared, top-8: 671B total, 37B active) are leveraging this.

One catch worth knowing: routers can collapse, learning to send everything to a couple of favorite experts while the rest atrophy. The fix is a load-balancing loss during training that nudges tokens to spread out evenly.
