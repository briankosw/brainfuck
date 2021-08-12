import argparse
import os
import sys


class BrainFuck:
    def __init__(self, file_path: str, num_mem_blocks: int = 30000) -> None:
        self.program = ""
        with open(file_path, "r") as f:
            self.program = f.read()
        self.mem = [0] * num_mem_blocks
        self.ptr = 0

    def run(self):
        idx = 0
        bracket_stack = []
        while idx < len(self.program):
            op = self.program[idx]
            if op == ">":
                self.ptr += 1
            elif op == "<":
                self.ptr -= 1
            elif op == "+":
                self.mem[self.ptr] += 1
            elif op == "-":
                self.mem[self.ptr] -= 1
            elif op == "[":
                bracket_stack.append(("[", idx))
                if self.mem[self.ptr] == 0:
                    old_idx = idx
                    idx += 1
                    while idx < len(self.program):
                        if self.program[idx] == "[":
                            bracket_stack.append(("[", idx))
                        elif self.program[idx] == "]":
                            _, b_idx = bracket_stack.pop()
                            if b_idx == old_idx:
                                break
                        idx += 1
            elif op == "]":
                idx = bracket_stack.pop()[1] - 1
            elif op == ",":
                try:
                    self.mem[self.ptr] = ord(sys.stdin.read(1))
                except:
                    ...
            elif op == ".":
                print(chr(self.mem[self.ptr]), end="")
            idx += 1


def create_parser():
    parser = argparse.ArgumentParser(description="Brainfuck interpreter written in Python")
    parser.add_argument("-n", "--num-mem-blocks", type=int, help="the number of memory blocks", default=30000)
    parser.add_argument("file", type=str, help="the brainfuck file to run")
    return parser


if __name__ == "__main__":
    parser = create_parser()
    args = parser.parse_args()
    brainfuck = BrainFuck(file_path=args.file, num_mem_blocks=args.num_mem_blocks)
    try:
        brainfuck.run()
    except Exception as error:
        raise
