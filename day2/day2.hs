type Program = [Int]
data Command = Command Opcode Int Int Int deriving (Show)
data Opcode = Add | Product | End deriving (Show)

toOpcode :: Int -> Opcode
toOpcode 1  = Add
toOpcode 2  = Product
toOpcode 99 = End
toOpcode a  = error $ "Unknown opcode: " ++ show a

replace :: Int -> a -> [a] -> [a]
replace index element list =
  let (first, _ : second) = splitAt index list in first ++ [element] ++ second

execute :: Command -> Program -> Program
execute (Command Add index1 index2 outputIndex) program =
  let add1   = program !! index1
      add2   = program !! index2
      result = add1 + add2
  in  replace outputIndex result program

execute (Command Product index1 index2 outputIndex) program =
  let add1   = program !! index1
      add2   = program !! index2
      result = add1 * add2
  in  replace outputIndex result program

execute (Command End _ _ _) program = program


run :: Int -> Program -> Program
run i program =
  let a : b : c : d : _ = take 4 $ snd $ splitAt i program
      opcode            = toOpcode a
      command           = Command opcode b c d
      newProgram        = execute command program
  in  case opcode of
        End -> program
        _   -> run (i + 4) newProgram

testProgram :: Program
testProgram = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]

initProgram :: Program -> Program
initProgram program =
  let p1 = replace 1 12 program
      p2 = replace 2 2 p1
  in  p2

program :: Program
program =
  [ 1
  , 0
  , 0
  , 3
  , 1
  , 1
  , 2
  , 3
  , 1
  , 3
  , 4
  , 3
  , 1
  , 5
  , 0
  , 3
  , 2
  , 1
  , 10
  , 19
  , 1
  , 9
  , 19
  , 23
  , 1
  , 13
  , 23
  , 27
  , 1
  , 5
  , 27
  , 31
  , 2
  , 31
  , 6
  , 35
  , 1
  , 35
  , 5
  , 39
  , 1
  , 9
  , 39
  , 43
  , 1
  , 43
  , 5
  , 47
  , 1
  , 47
  , 5
  , 51
  , 2
  , 10
  , 51
  , 55
  , 1
  , 5
  , 55
  , 59
  , 1
  , 59
  , 5
  , 63
  , 2
  , 63
  , 9
  , 67
  , 1
  , 67
  , 5
  , 71
  , 2
  , 9
  , 71
  , 75
  , 1
  , 75
  , 5
  , 79
  , 1
  , 10
  , 79
  , 83
  , 1
  , 83
  , 10
  , 87
  , 1
  , 10
  , 87
  , 91
  , 1
  , 6
  , 91
  , 95
  , 2
  , 95
  , 6
  , 99
  , 2
  , 99
  , 9
  , 103
  , 1
  , 103
  , 6
  , 107
  , 1
  , 13
  , 107
  , 111
  , 1
  , 13
  , 111
  , 115
  , 2
  , 115
  , 9
  , 119
  , 1
  , 119
  , 6
  , 123
  , 2
  , 9
  , 123
  , 127
  , 1
  , 127
  , 5
  , 131
  , 1
  , 131
  , 5
  , 135
  , 1
  , 135
  , 5
  , 139
  , 2
  , 10
  , 139
  , 143
  , 2
  , 143
  , 10
  , 147
  , 1
  , 147
  , 5
  , 151
  , 1
  , 151
  , 2
  , 155
  , 1
  , 155
  , 13
  , 0
  , 99
  , 2
  , 14
  , 0
  , 0
  ]

part1 :: Program
part1 = run 0 (initProgram program)
