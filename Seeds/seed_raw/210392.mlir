module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<103> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.clamp %0 {max_val = -14 : i32, min_val = -59 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %2 = tosa.clz %1 : (tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.arithmetic_right_shift %2, %1 {round = true} : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.identity %3 : (tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.identity %4 : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

