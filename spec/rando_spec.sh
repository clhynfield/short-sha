length() {
  test "${#length}" "$1" "$2"
}

is_hex() {
  echo "$is_hex" | grep '^[0-9a-f][0-9a-f]*$' >/dev/null 2>&1
}

iterate() {
  local count="$1"; shift
  local i=1; while [ $i -le $count ]; do
    "$@"
    i=$(($i+1))
  done
}

no_matching_lines() {
  local sorted_lines=$(echo "$no_matching_lines" | sort)
  local num_sorted_lines=$(echo "$sorted_lines" | wc -l)
  local unique_lines=$(echo "$sorted_lines" | uniq)
  local num_unique_lines=$(echo "$unique_lines" | wc -l)
  [ "$num_sorted_lines" -eq "$num_unique_lines" ]
}

Describe 'rando'
  Describe 'as a function'
    Include ./rando
    It 'prints a five-character hex string by default'
      When run rando
      The output should satisfy length -eq 5
      The output should satisfy is_hex
    End
    It 'prints different strings in immediate succession'
      When run iterate 3 rando
      The output should satisfy is_hex
      The lines of stdout should equal 3
      The output should satisfy no_matching_lines
    End
  End
  Describe 'as a script'
    It 'prints a five-character hex string by default'
      When run ./rando
      The output should satisfy length -eq 5
      The output should satisfy is_hex
    End
    It 'prints a three-character hex string with a parameter of 3'
      When run ./rando 3
      The output should satisfy length -eq 3
      The output should satisfy is_hex
    End
    It 'prints different strings in immediate succession'
      When run iterate 2 ./rando
      The output should satisfy is_hex
      The lines of stdout should equal 2
      The output should satisfy no_matching_lines
    End
  End
End
