proc interpret*(code: string, tapeLen: int) = 
  var
    tape: seq[char] = newSeq[char](tapeLen)
    codePos: int = 0
    tapePos: int = 0
  
  {.push overflowchecks: off.}
  proc xinc(c: var char) = inc c
  proc xdec(c: var char) = dec c
  {.pop.}

  
  proc run(skip = false): bool =
    while tapePos >= 0 and codePos < code.len:
      if code[codePos] == '[':
        inc codePos
        let oldPos = codePos
        while run(tape[tapePos] == '\0'):
          codePos = oldPos
      elif code[codePos] == ']':
        return tape[tapePos] != '\0'
      elif not skip:
        case code[codePos]
        of '>': inc tapePos
        of '<': dec tapePos
        of '+': xinc tape[tapePos]
        of '-': xdec tape[tapePos]
        of ',': tape[tapePos] = stdin.readChar
        of '.': stdout.write tape[tapePos]
        else: discard
  
      inc codePos

  discard run()

when isMainModule:
  import docopt
  import strutils

  let doc = """
  Brianfuck interpreter written in Nim

  Usage:
    brainfuck <file> [--num-mem-blocks=<n>]
    brainfuck -h | --help

  Options:
    -h --help                    Show this screen.
    -n=<n> --num-mem-blocks=<n>  Number of memory blocks [default: 30000].
  """

  let args = docopt(doc)

  let code = readFile $args["<file>"]

  interpret code, parseInt($args["--num-mem-blocks"])
