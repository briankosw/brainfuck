# Brainfuck

After finding this [instructive Nim tutorial](https://howistart.org/posts/nim/1/index.html) that demonstrates Nim's features by implemeting a brainfuck interpreter, I decided to have some fun and implement a brainfuck interpreter in different programming langauges.


# Instruction
There are a few brainfuck scripts in the `examples` directory. To run one of the scripts:
- Python: `python brainfuck.py examples/helloworld.b`
- Nim: `nim c -d:release -r brainfuck.nim examples/helloworld.b`

# Comparision
Here is a speed comparison between the different implementations when running `examples/mandelbrot.b` on my banged-up MacBook Pro with shitty stickers on it:

| Implementation  | Speed (HH:MM:SS) |
|:--------------- | ----------------:|
| Python(CPython) |         02:00:00 |
| Nim             |         00:01:34 |

# Brainfuck References
While brainfuck is not a practical programming language, I found myself enjoying it! Here are some helpful references for learning about brainfuck:
- [Basics of BrainFuck](https://gist.github.com/roachhd/dce54bec8ba55fb17d3a)
- [brainfuck - Esolang](https://esolangs.org/wiki/Brainfuck)
