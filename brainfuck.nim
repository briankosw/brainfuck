import macros

{.push overflowchecks: off.}
proc xinc*(c: var char) = inc c
proc xdec*(c: var char) = dec c
{.pop.}


proc interpret*(code: string, tapeLen: int) =
  var
    tape: seq[char] = newSeq[char](tapeLen)
    codePos: int = 0
    tapePos: int = 0
  
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


proc compile(code: string): NimNode {.compiletime.} =
  var stmts = @[newStmtList()]

  template addStmt(text): void =
    stmts[stmts.high].add parseStmt(text)

  addStmt "var tape: array[30_000, char]"
  addStmt "var tapePos = 0"

  for c in code:
    case c
    of '>': addStmt "inc tapePos"
    of '<': addStmt "dec tapePos"
    of '+': addStmt "xinc tape[tapePos]"
    of '-': addStmt "xdec tape[tapePos]"
    of ',': addStmt "tape[tapePos] = stdin.readChar"
    of '.': addStmt "stdout.write tape[tapePos]"
    of '[': stmts.add newStmtList()
    of ']':
      var loop = newNimNode(nnkWhileStmt)
      loop.add parseExpr("tape[tapePos] != '\\0'")
      loop.add stmts.pop
      stmts[stmts.high].add loop
    else: discard
  result = stmts[0]


macro compileFile*(filename: string): void =
  compile staticRead(filename.strval)


when isMainModule:
  import docopt
  import strutils

  proc mandelbrot = compileFile("examples/mandelbrot.b")

  let doc = """
  Brianfuck interpreter written in Nim

  Usage:
    brainfuck mandelbrot
    brainfuck interpret [--num-mem-blocks=<n>] <file>
    brainfuck -h | --help

  Options:
    -h --help                    Show this screen.
    -n=<n> --num-mem-blocks=<n>  Number of memory blocks [default: 30000].
  """

  let args = docopt(doc)

  if args["mandelbrot"]:
    mandelbrot()

  let code = readFile $args["<file>"]

  interpret code, parseInt($args["--num-mem-blocks"])
