# brainfuck

After finding this [instructive Nim tutorial](https://howistart.org/posts/nim/1/index.html) that demonstrates Nim's features by implemeting a brainfuck interpreter, I decided to have some fun and implement a brainfuck interpreter in different programming langauges.


# Instruction
There's a couple brainfuck scripts in the `brainfuck` directory. To run one of the scripts:
- Python: `python brainfuck.py brainfuck/helloworld.b`
- Nim: `nim c -d:release -r brainfuck.nim brainfuck/helloworld.b`

# Comparision
Here is a speed comparison between the different implementations when running `brainfuck/mandelbrot.b` on my banged-up MacBook Pro with shitty stickers on it:

| Implementation | Speed (HH:MM:SS) |
|:-------------- | ----------------:|
| Python         |         02:00:00 |
| Nim            |         00:01:34 |
